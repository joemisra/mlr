#!/usr/bin/env python3
"""Minimal stdio MCP server for local Max/MSP tooling.

This exposes:
- compact `.maxpat` analysis via `analyze_maxpat.py`
- live patch inspection/edit tools over the existing Max Socket.IO bridge
"""

from __future__ import annotations

import asyncio
import importlib
import json
import os
import socket
import sys
import traceback
import uuid
from pathlib import Path
from typing import Any
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parent.parent
SCRIPTS_DIR = Path(__file__).resolve().parent
if str(SCRIPTS_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPTS_DIR))

import analyze_maxpat  # noqa: E402


def socketio_site_package_candidates() -> list[Path]:
    candidates: list[Path] = []
    configured = os.environ.get("PYTHON_SOCKETIO_SITE_PACKAGES", "")
    if configured:
        for entry in configured.split(os.pathsep):
            if entry:
                candidates.append(Path(entry).expanduser())
    candidates.extend(sorted((ROOT / ".venv" / "lib").glob("python*/site-packages")))
    candidates.extend(sorted((ROOT.parent / "MaxMSP-MCP-Server" / ".venv" / "lib").glob("python*/site-packages")))
    return candidates


def import_socketio_module():
    try:
        module = importlib.import_module("socketio")
        if hasattr(module, "AsyncClient"):
            return module
    except ImportError:
        module = None
    except Exception:
        module = None

    for path in socketio_site_package_candidates():
        if not path.exists():
            continue
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)
        sys.modules.pop("socketio", None)
        try:
            module = importlib.import_module("socketio")
            if hasattr(module, "AsyncClient"):
                return module
        except ImportError:
            continue
        except Exception:
            continue

    return module


socketio = import_socketio_module()


SERVER_NAME = "mlr-maxpat-tools"
SERVER_VERSION = "0.2.0"

SOCKETIO_SERVER_URL_ENV = os.environ.get("SOCKETIO_SERVER_URL", "")
PARSED_SOCKETIO_SERVER_URL = (
    urlparse(SOCKETIO_SERVER_URL_ENV) if SOCKETIO_SERVER_URL_ENV else None
)
DEFAULT_MAX_BRIDGE_HOST = os.environ.get("MAX_BRIDGE_HOST") or (
    PARSED_SOCKETIO_SERVER_URL.hostname if PARSED_SOCKETIO_SERVER_URL else None
) or "127.0.0.1"
DEFAULT_MAX_BRIDGE_PORT = int(
    os.environ.get("MAX_BRIDGE_PORT")
    or os.environ.get("SOCKETIO_SERVER_PORT")
    or (PARSED_SOCKETIO_SERVER_URL.port if PARSED_SOCKETIO_SERVER_URL else 0)
    or 5002
)
DEFAULT_MAX_BRIDGE_NAMESPACE = os.environ.get("MAX_BRIDGE_NAMESPACE") or os.environ.get(
    "NAMESPACE", "/mcp"
)
DEFAULT_MAX_BRIDGE_SCHEME = os.environ.get("MAX_BRIDGE_SCHEME") or (
    PARSED_SOCKETIO_SERVER_URL.scheme if PARSED_SOCKETIO_SERVER_URL else None
) or "http"
DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS = 5000
DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS = 2000

_FLATTENED_DOCS: dict[str, Any] | None = None
_DOCS_PATH: Path | None = None


def log(message: str) -> None:
    print(message, file=sys.stderr, flush=True)


def send_message(payload: dict[str, Any]) -> None:
    body = json.dumps(payload, ensure_ascii=True, separators=(",", ":")).encode("utf-8")
    header = f"Content-Length: {len(body)}\r\n\r\n".encode("ascii")
    sys.stdout.buffer.write(header)
    sys.stdout.buffer.write(body)
    sys.stdout.buffer.flush()


def read_message() -> dict[str, Any] | None:
    content_length = None

    while True:
        line = sys.stdin.buffer.readline()
        if not line:
            return None
        if line in (b"\r\n", b"\n"):
            break
        if b":" not in line:
            continue
        key, value = line.split(b":", 1)
        if key.strip().lower() == b"content-length":
            content_length = int(value.strip())

    if content_length is None:
        raise ValueError("Missing Content-Length header")

    body = sys.stdin.buffer.read(content_length)
    if not body:
        return None
    return json.loads(body.decode("utf-8"))


def make_error(code: int, message: str, data: Any = None) -> dict[str, Any]:
    error = {"code": code, "message": message}
    if data is not None:
        error["data"] = data
    return error


def send_result(msg_id: Any, result: dict[str, Any]) -> None:
    send_message({"jsonrpc": "2.0", "id": msg_id, "result": result})


def send_error(msg_id: Any, code: int, message: str, data: Any = None) -> None:
    send_message({"jsonrpc": "2.0", "id": msg_id, "error": make_error(code, message, data)})


def text_result(text: str, is_error: bool = False) -> dict[str, Any]:
    result = {
        "content": [
            {
                "type": "text",
                "text": text,
            }
        ]
    }
    if is_error:
        result["isError"] = True
    return result


def json_result(data: Any, is_error: bool = False) -> dict[str, Any]:
    return text_result(json.dumps(data, ensure_ascii=True, indent=2, sort_keys=True), is_error=is_error)


def tool_schema(properties: dict[str, Any], required: list[str] | None = None) -> dict[str, Any]:
    schema: dict[str, Any] = {
        "type": "object",
        "properties": properties,
        "additionalProperties": False,
    }
    if required:
        schema["required"] = required
    return schema


def bridge_connection_properties() -> dict[str, Any]:
    return {
        "host": {
            "type": "string",
            "description": "Bridge hostname or base URL.",
            "default": DEFAULT_MAX_BRIDGE_HOST,
        },
        "port": {
            "type": "integer",
            "description": "Bridge TCP port.",
            "default": DEFAULT_MAX_BRIDGE_PORT,
            "minimum": 1,
            "maximum": 65535,
        },
        "namespace": {
            "type": "string",
            "description": "Socket.IO namespace exposed by the Max bridge.",
            "default": DEFAULT_MAX_BRIDGE_NAMESPACE,
        },
    }


def bridge_tool_schema(
    properties: dict[str, Any],
    *,
    required: list[str] | None = None,
    timeout_default_ms: int,
) -> dict[str, Any]:
    merged = dict(properties)
    merged.update(bridge_connection_properties())
    merged["timeout_ms"] = {
        "type": "integer",
        "description": "Connection and response timeout in milliseconds.",
        "default": timeout_default_ms,
        "minimum": 1,
    }
    return tool_schema(merged, required=required)


def resolve_repo_path(path_str: str) -> Path:
    path = Path(path_str).expanduser()
    if not path.is_absolute():
        path = ROOT / path
    path = path.resolve()
    try:
        path.relative_to(ROOT)
    except ValueError as exc:
        raise ValueError(f"Path must stay within {ROOT}") from exc
    return path


def list_maxpat_files(include_agent_demo: bool = False) -> list[str]:
    files: list[str] = []
    ignore_roots = {"node_modules", ".git"}

    for path in ROOT.rglob("*.maxpat"):
        parts = set(path.relative_to(ROOT).parts)
        if ignore_roots & parts:
            continue
        if not include_agent_demo and "MaxMSP_Agent" in parts:
            continue
        files.append(str(path.relative_to(ROOT)))
    return sorted(files)


def analyze_one(path_str: str, depth: int | None, no_comments: bool, sends_only: bool) -> str:
    path = resolve_repo_path(path_str)
    if not path.exists():
        raise FileNotFoundError(f"{path} does not exist")
    if path.suffix != ".maxpat":
        raise ValueError(f"{path.name} is not a .maxpat file")
    return analyze_maxpat.analyze_file(
        str(path),
        max_depth=depth,
        skip_comments=no_comments,
        sends_only=sends_only,
    )


def analyze_many(
    paths: list[str],
    depth: int | None,
    no_comments: bool,
    sends_only: bool,
) -> str:
    if not paths:
        raise ValueError("paths must contain at least one file")
    sections = [analyze_one(path, depth, no_comments, sends_only) for path in paths]
    return "\n---\n\n".join(sections)


def docs_path_candidates() -> list[Path]:
    candidates: list[Path] = []
    docs_env = os.environ.get("MAX_DOCS_PATH")
    if docs_env:
        candidates.append(Path(docs_env).expanduser())
    candidates.append(ROOT / "docs.json")
    candidates.append(ROOT.parent / "MaxMSP-MCP-Server" / "docs.json")
    return candidates


def load_flattened_docs() -> tuple[dict[str, Any], Path | None]:
    global _FLATTENED_DOCS, _DOCS_PATH

    if _FLATTENED_DOCS is not None:
        return _FLATTENED_DOCS, _DOCS_PATH

    for path in docs_path_candidates():
        if not path.exists():
            continue
        data = json.loads(path.read_text())
        flattened: dict[str, Any] = {}
        if isinstance(data, dict):
            for obj_list in data.values():
                if not isinstance(obj_list, list):
                    continue
                for obj in obj_list:
                    if not isinstance(obj, dict):
                        continue
                    name = obj.get("name")
                    if isinstance(name, str) and name:
                        flattened[name] = obj
        _FLATTENED_DOCS = flattened
        _DOCS_PATH = path
        return flattened, path

    _FLATTENED_DOCS = {}
    _DOCS_PATH = None
    return _FLATTENED_DOCS, _DOCS_PATH


def require_socketio() -> None:
    if socketio is None or not hasattr(socketio, "AsyncClient"):
        module_path = getattr(socketio, "__file__", None)
        raise RuntimeError(
            "python-socketio is not available for this interpreter. "
            f"Imported module: {module_path or 'none'}. "
            "Install python-socketio, set PYTHON_SOCKETIO_SITE_PACKAGES, or keep a compatible .venv available."
        )


def build_bridge_url(host: str, port: int) -> str:
    if "://" not in host:
        host = f"{DEFAULT_MAX_BRIDGE_SCHEME}://{host}"
    parsed = urlparse(host)
    scheme = parsed.scheme or DEFAULT_MAX_BRIDGE_SCHEME
    netloc = parsed.netloc or parsed.path
    if not netloc:
        raise ValueError(f"Invalid bridge host: {host!r}")
    if ":" in netloc:
        return f"{scheme}://{netloc}"
    return f"{scheme}://{netloc}:{port}"


def bridge_settings(arguments: dict[str, Any], *, timeout_default_ms: int) -> dict[str, Any]:
    return {
        "host": str(arguments.get("host", DEFAULT_MAX_BRIDGE_HOST)),
        "port": int(arguments.get("port", DEFAULT_MAX_BRIDGE_PORT)),
        "namespace": str(arguments.get("namespace", DEFAULT_MAX_BRIDGE_NAMESPACE)),
        "timeout_ms": int(arguments.get("timeout_ms", timeout_default_ms)),
    }


def max_bridge_status(host: str, port: int, timeout_ms: int) -> dict[str, Any]:
    timeout_s = max(timeout_ms, 1) / 1000.0
    docs, docs_path = load_flattened_docs()
    status: dict[str, Any] = {
        "bridge": {
            "host": host,
            "port": port,
            "url": build_bridge_url(host, port),
            "namespace": DEFAULT_MAX_BRIDGE_NAMESPACE,
        },
        "timeout_ms": timeout_ms,
        "socketio_available": socketio is not None and hasattr(socketio, "AsyncClient"),
        "socketio_module": getattr(socketio, "__file__", None),
        "docs_index": {
            "available": bool(docs),
            "path": str(docs_path) if docs_path else None,
            "count": len(docs),
        },
    }
    try:
        with socket.create_connection((host, port), timeout=timeout_s):
            status["reachable"] = True
            status["note"] = (
                "The Max bridge is listening. Live tools use this Socket.IO bridge rather than a native MCP server in Max."
            )
    except OSError as exc:
        status["reachable"] = False
        status["error"] = str(exc)
        status["hint"] = "Open `_mlr.maxpat` in Max and ensure the node script bridge is running."
        if getattr(exc, "errno", None) == 1:
            status["note"] = (
                "Operation not permitted can also mean the current execution environment is blocking localhost socket access."
            )
    return status


async def socketio_send_request(
    action: str,
    payload: dict[str, Any],
    *,
    host: str,
    port: int,
    namespace: str,
    timeout_ms: int,
) -> dict[str, Any]:
    require_socketio()
    assert socketio is not None

    request_id = str(uuid.uuid4())
    timeout_s = max(timeout_ms, 1) / 1000.0
    url = build_bridge_url(host, port)
    sio = socketio.AsyncClient(reconnection=False)
    loop = asyncio.get_running_loop()
    response_future: asyncio.Future[Any] = loop.create_future()

    @sio.on("response", namespace=namespace)
    def _on_response(data: Any) -> None:
        if not isinstance(data, dict):
            return
        if data.get("request_id") != request_id:
            return
        if not response_future.done():
            response_future.set_result(data.get("results"))

    @sio.on("connect_error", namespace=namespace)
    def _on_connect_error(data: Any) -> None:
        if not response_future.done():
            response_future.set_exception(ConnectionError(f"Socket.IO connect_error: {data!r}"))

    request_payload = {"action": action, "request_id": request_id}
    request_payload.update(payload)

    try:
        await sio.connect(url, namespaces=[namespace], wait_timeout=timeout_s)
        await sio.emit("request", request_payload, namespace=namespace)
        results = await asyncio.wait_for(response_future, timeout=timeout_s)
        return {
            "action": action,
            "bridge": {
                "host": host,
                "port": port,
                "url": url,
                "namespace": namespace,
            },
            "results": results,
        }
    except asyncio.TimeoutError as exc:
        raise TimeoutError(
            f"Timed out waiting for Max bridge response to {action!r} after {timeout_ms} ms. "
            "If the patch is large, narrow the selection or lower the requested object count."
        ) from exc
    finally:
        try:
            await sio.disconnect()
        except Exception:  # noqa: BLE001
            pass


async def socketio_send_command(
    action: str,
    payload: dict[str, Any],
    *,
    host: str,
    port: int,
    namespace: str,
    timeout_ms: int,
) -> dict[str, Any]:
    require_socketio()
    assert socketio is not None

    timeout_s = max(timeout_ms, 1) / 1000.0
    url = build_bridge_url(host, port)
    sio = socketio.AsyncClient(reconnection=False)
    command_payload = {"action": action}
    command_payload.update(payload)

    try:
        await sio.connect(url, namespaces=[namespace], wait_timeout=timeout_s)
        await sio.emit("command", command_payload, namespace=namespace)
        await asyncio.sleep(0.05)
        return {
            "status": "sent",
            "action": action,
            "bridge": {
                "host": host,
                "port": port,
                "url": url,
                "namespace": namespace,
            },
            "command": command_payload,
        }
    finally:
        try:
            await sio.disconnect()
        except Exception:  # noqa: BLE001
            pass


def run_bridge_request(
    action: str,
    payload: dict[str, Any],
    *,
    host: str,
    port: int,
    namespace: str,
    timeout_ms: int,
) -> dict[str, Any]:
    return asyncio.run(
        socketio_send_request(
            action,
            payload,
            host=host,
            port=port,
            namespace=namespace,
            timeout_ms=timeout_ms,
        )
    )


def run_bridge_command(
    action: str,
    payload: dict[str, Any],
    *,
    host: str,
    port: int,
    namespace: str,
    timeout_ms: int,
) -> dict[str, Any]:
    return asyncio.run(
        socketio_send_command(
            action,
            payload,
            host=host,
            port=port,
            namespace=namespace,
            timeout_ms=timeout_ms,
        )
    )


def build_request_action(name: str, arguments: dict[str, Any]) -> tuple[str, dict[str, Any]]:
    if name == "get_objects_in_patch":
        payload: dict[str, Any] = {}
        limit = int(arguments.get("limit", 0))
        if limit > 0:
            payload["limit"] = limit
        return "get_objects_in_patch", payload
    if name == "get_objects_in_selected":
        return "get_objects_in_selected", {}
    if name == "expand_selection":
        return "expand_selection", {"hops": int(arguments.get("hops", 1))}
    if name == "select_objects":
        return "select_objects", {
            "varnames": list(arguments["varnames"]),
            "add_to_selection": bool(arguments.get("add_to_selection", False)),
        }
    if name == "get_object_attributes":
        return "get_object_attributes", {"varname": str(arguments["varname"])}
    if name == "get_avoid_rect_position":
        return "get_avoid_rect_position", {}
    raise KeyError(name)


def build_command_action(name: str, arguments: dict[str, Any]) -> tuple[str, dict[str, Any]]:
    if name == "add_max_object":
        return "add_object", {
            "position": list(arguments["position"]),
            "obj_type": str(arguments["obj_type"]),
            "varname": str(arguments["varname"]),
            "args": list(arguments.get("args", [])),
        }
    if name == "remove_max_object":
        return "remove_object", {"varname": str(arguments["varname"])}
    if name == "connect_max_objects":
        return "connect_objects", {
            "src_varname": str(arguments["src_varname"]),
            "outlet_idx": int(arguments["outlet_idx"]),
            "dst_varname": str(arguments["dst_varname"]),
            "inlet_idx": int(arguments["inlet_idx"]),
        }
    if name == "disconnect_max_objects":
        return "disconnect_objects", {
            "src_varname": str(arguments["src_varname"]),
            "outlet_idx": int(arguments["outlet_idx"]),
            "dst_varname": str(arguments["dst_varname"]),
            "inlet_idx": int(arguments["inlet_idx"]),
        }
    if name == "set_object_attribute":
        return "set_object_attribute", {
            "varname": str(arguments["varname"]),
            "attr_name": str(arguments["attr_name"]),
            "attr_value": list(arguments["attr_value"]),
        }
    if name == "set_message_text":
        return "set_message_text", {
            "varname": str(arguments["varname"]),
            "new_text": list(arguments["text_list"]),
        }
    if name == "send_bang_to_object":
        return "send_bang_to_object", {"varname": str(arguments["varname"])}
    if name == "send_messages_to_object":
        return "send_message_to_object", {
            "varname": str(arguments["varname"]),
            "message": list(arguments["message"]),
        }
    if name == "set_number":
        return "set_number", {
            "varname": str(arguments["varname"]),
            "num": arguments["num"],
        }
    raise KeyError(name)


REQUEST_TOOL_NAMES = {
    "get_objects_in_patch",
    "get_objects_in_selected",
    "expand_selection",
    "select_objects",
    "get_object_attributes",
    "get_avoid_rect_position",
}

COMMAND_TOOL_NAMES = {
    "add_max_object",
    "remove_max_object",
    "connect_max_objects",
    "disconnect_max_objects",
    "set_object_attribute",
    "set_message_text",
    "send_bang_to_object",
    "send_messages_to_object",
    "set_number",
}

TOOLS: list[dict[str, Any]] = [
    {
        "name": "list_maxpat_files",
        "description": "List .maxpat files in this repo, excluding node_modules and, by default, the MaxMSP_Agent demo patch files.",
        "inputSchema": tool_schema(
            {
                "include_agent_demo": {
                    "type": "boolean",
                    "description": "Include .maxpat files under MaxMSP_Agent.",
                    "default": False,
                }
            }
        ),
    },
    {
        "name": "analyze_maxpat",
        "description": "Produce a compact AI-friendly summary of a single .maxpat file using the local analyzer script.",
        "inputSchema": tool_schema(
            {
                "path": {
                    "type": "string",
                    "description": "Path to the .maxpat file, relative to the repo root or absolute inside the repo.",
                },
                "depth": {
                    "type": ["integer", "null"],
                    "description": "Maximum subpatcher recursion depth. Null means unlimited.",
                    "minimum": 0,
                },
                "no_comments": {
                    "type": "boolean",
                    "description": "Skip comment boxes.",
                    "default": True,
                },
                "sends_only": {
                    "type": "boolean",
                    "description": "Return only send/receive topology and external references.",
                    "default": False,
                },
            },
            required=["path"],
        ),
    },
    {
        "name": "analyze_maxpat_batch",
        "description": "Produce compact summaries for multiple .maxpat files in one call.",
        "inputSchema": tool_schema(
            {
                "paths": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "List of .maxpat paths, relative to the repo root or absolute inside the repo.",
                    "minItems": 1,
                },
                "depth": {
                    "type": ["integer", "null"],
                    "description": "Maximum subpatcher recursion depth. Null means unlimited.",
                    "minimum": 0,
                },
                "no_comments": {
                    "type": "boolean",
                    "description": "Skip comment boxes.",
                    "default": True,
                },
                "sends_only": {
                    "type": "boolean",
                    "description": "Return only send/receive topology and external references.",
                    "default": False,
                },
            },
            required=["paths"],
        ),
    },
    {
        "name": "max_bridge_status",
        "description": "Check whether the existing Max Socket.IO bridge is reachable and whether the optional Max object docs index is available.",
        "inputSchema": tool_schema(
            {
                "host": {
                    "type": "string",
                    "description": "Hostname or base URL to probe.",
                    "default": DEFAULT_MAX_BRIDGE_HOST,
                },
                "port": {
                    "type": "integer",
                    "description": "TCP port to probe.",
                    "default": DEFAULT_MAX_BRIDGE_PORT,
                    "minimum": 1,
                    "maximum": 65535,
                },
                "timeout_ms": {
                    "type": "integer",
                    "description": "Connection timeout in milliseconds.",
                    "default": 1500,
                    "minimum": 1,
                },
            }
        ),
    },
    {
        "name": "list_all_objects",
        "description": "List Max object names from the local docs index used by the older MaxMSP MCP server.",
        "inputSchema": tool_schema(
            {
                "prefix": {
                    "type": "string",
                    "description": "Optional case-insensitive prefix filter.",
                },
                "limit": {
                    "type": "integer",
                    "description": "Maximum number of object names to return. 0 means no limit.",
                    "default": 0,
                    "minimum": 0,
                },
            }
        ),
    },
    {
        "name": "get_object_doc",
        "description": "Return the indexed documentation entry for a Max object name.",
        "inputSchema": tool_schema(
            {
                "object_name": {
                    "type": "string",
                    "description": "Exact Max object name to look up.",
                }
            },
            required=["object_name"],
        ),
    },
    {
        "name": "get_objects_in_patch",
        "description": "Retrieve the list of boxes and patch cords in the current Max patch.",
        "inputSchema": bridge_tool_schema(
            {
                "limit": {
                    "type": "integer",
                    "description": "Optional maximum number of objects to return. 0 means no limit.",
                    "default": 0,
                    "minimum": 0,
                }
            },
            timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS,
        ),
    },
    {
        "name": "get_objects_in_selected",
        "description": "Retrieve the boxes and patch cords currently selected in an unlocked patcher.",
        "inputSchema": bridge_tool_schema({}, timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS),
    },
    {
        "name": "expand_selection",
        "description": "Expand the current selection to include objects connected by patch cords.",
        "inputSchema": bridge_tool_schema(
            {
                "hops": {
                    "type": "integer",
                    "description": "Number of connection hops to expand.",
                    "default": 1,
                    "minimum": 1,
                }
            },
            timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS,
        ),
    },
    {
        "name": "select_objects",
        "description": "Select objects in the current patch by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varnames": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "List of object varnames to select.",
                    "minItems": 1,
                },
                "add_to_selection": {
                    "type": "boolean",
                    "description": "Add to the current selection instead of replacing it.",
                    "default": False,
                },
            },
            required=["varnames"],
            timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS,
        ),
    },
    {
        "name": "get_object_attributes",
        "description": "Retrieve the attribute map for a Max object by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {
                    "type": "string",
                    "description": "Object varname in the current patch.",
                }
            },
            required=["varname"],
            timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS,
        ),
    },
    {
        "name": "get_avoid_rect_position",
        "description": "Return the rectangular area to avoid when placing newly created objects.",
        "inputSchema": bridge_tool_schema({}, timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS),
    },
    {
        "name": "add_max_object",
        "description": "Add a new Max object to the current patch.",
        "inputSchema": bridge_tool_schema(
            {
                "position": {
                    "type": "array",
                    "items": {"type": "number"},
                    "description": "Position in patch coordinates as [x, y].",
                    "minItems": 2,
                    "maxItems": 2,
                },
                "obj_type": {
                    "type": "string",
                    "description": "Max object type such as `message`, `button`, or `cycle~`.",
                },
                "varname": {
                    "type": "string",
                    "description": "Varname to assign for scripting.",
                },
                "args": {
                    "type": "array",
                    "description": "Arguments passed to the created object.",
                    "default": [],
                },
            },
            required=["position", "obj_type", "varname"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "remove_max_object",
        "description": "Remove a Max object by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {
                    "type": "string",
                    "description": "Varname of the object to remove.",
                }
            },
            required=["varname"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "connect_max_objects",
        "description": "Connect one Max object outlet to another object's inlet.",
        "inputSchema": bridge_tool_schema(
            {
                "src_varname": {"type": "string", "description": "Source object varname."},
                "outlet_idx": {"type": "integer", "description": "Source outlet index.", "minimum": 0},
                "dst_varname": {"type": "string", "description": "Destination object varname."},
                "inlet_idx": {"type": "integer", "description": "Destination inlet index.", "minimum": 0},
            },
            required=["src_varname", "outlet_idx", "dst_varname", "inlet_idx"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "disconnect_max_objects",
        "description": "Disconnect one Max object outlet from another object's inlet.",
        "inputSchema": bridge_tool_schema(
            {
                "src_varname": {"type": "string", "description": "Source object varname."},
                "outlet_idx": {"type": "integer", "description": "Source outlet index.", "minimum": 0},
                "dst_varname": {"type": "string", "description": "Destination object varname."},
                "inlet_idx": {"type": "integer", "description": "Destination inlet index.", "minimum": 0},
            },
            required=["src_varname", "outlet_idx", "dst_varname", "inlet_idx"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "set_object_attribute",
        "description": "Set a Max object attribute by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {"type": "string", "description": "Object varname."},
                "attr_name": {"type": "string", "description": "Attribute name to set."},
                "attr_value": {
                    "type": "array",
                    "description": "Attribute value list passed through to Max.",
                },
            },
            required=["varname", "attr_name", "attr_value"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "set_message_text",
        "description": "Replace the contents of a message box.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {"type": "string", "description": "Message box varname."},
                "text_list": {
                    "type": "array",
                    "description": "List of atoms to set as the message text.",
                },
            },
            required=["varname", "text_list"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "send_bang_to_object",
        "description": "Send a `bang` message to a Max object by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {"type": "string", "description": "Target object varname."},
            },
            required=["varname"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "send_messages_to_object",
        "description": "Send an arbitrary Max message, expressed as a list of atoms, to an object by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {"type": "string", "description": "Target object varname."},
                "message": {
                    "type": "array",
                    "description": "Message atoms to send.",
                },
            },
            required=["varname", "message"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
    {
        "name": "set_number",
        "description": "Set the value of a numeric-style Max UI object by varname.",
        "inputSchema": bridge_tool_schema(
            {
                "varname": {"type": "string", "description": "Target object varname."},
                "num": {
                    "type": "number",
                    "description": "Numeric value to set.",
                },
            },
            required=["varname", "num"],
            timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS,
        ),
    },
]


def handle_tool_call(name: str, arguments: dict[str, Any]) -> dict[str, Any]:
    if name == "list_maxpat_files":
        files = list_maxpat_files(bool(arguments.get("include_agent_demo", False)))
        return text_result("\n".join(files) if files else "(no .maxpat files found)")

    if name == "analyze_maxpat":
        summary = analyze_one(
            path_str=arguments["path"],
            depth=arguments.get("depth"),
            no_comments=bool(arguments.get("no_comments", True)),
            sends_only=bool(arguments.get("sends_only", False)),
        )
        return text_result(summary)

    if name == "analyze_maxpat_batch":
        summary = analyze_many(
            paths=list(arguments["paths"]),
            depth=arguments.get("depth"),
            no_comments=bool(arguments.get("no_comments", True)),
            sends_only=bool(arguments.get("sends_only", False)),
        )
        return text_result(summary)

    if name == "max_bridge_status":
        return json_result(
            max_bridge_status(
                host=str(arguments.get("host", DEFAULT_MAX_BRIDGE_HOST)),
                port=int(arguments.get("port", DEFAULT_MAX_BRIDGE_PORT)),
                timeout_ms=int(arguments.get("timeout_ms", 1500)),
            )
        )

    if name == "list_all_objects":
        docs, docs_path = load_flattened_docs()
        if not docs:
            raise FileNotFoundError(
                "No docs.json index was found. Set MAX_DOCS_PATH or keep the MaxMSP-MCP-Server checkout beside this repo."
            )
        prefix = str(arguments.get("prefix", "")).lower().strip()
        limit = int(arguments.get("limit", 0))
        names = sorted(docs)
        if prefix:
            names = [name for name in names if name.lower().startswith(prefix)]
        if limit > 0:
            names = names[:limit]
        return json_result(
            {
                "count": len(names),
                "docs_path": str(docs_path) if docs_path else None,
                "objects": names,
            }
        )

    if name == "get_object_doc":
        docs, docs_path = load_flattened_docs()
        if not docs:
            raise FileNotFoundError(
                "No docs.json index was found. Set MAX_DOCS_PATH or keep the MaxMSP-MCP-Server checkout beside this repo."
            )
        object_name = str(arguments["object_name"])
        if object_name not in docs:
            raise KeyError(f"No docs entry found for Max object {object_name!r}")
        return json_result(
            {
                "docs_path": str(docs_path) if docs_path else None,
                "object": docs[object_name],
            }
        )

    if name in REQUEST_TOOL_NAMES:
        action, payload = build_request_action(name, arguments)
        settings = bridge_settings(arguments, timeout_default_ms=DEFAULT_BRIDGE_REQUEST_TIMEOUT_MS)
        return json_result(
            run_bridge_request(
                action,
                payload,
                host=settings["host"],
                port=settings["port"],
                namespace=settings["namespace"],
                timeout_ms=settings["timeout_ms"],
            )
        )

    if name in COMMAND_TOOL_NAMES:
        action, payload = build_command_action(name, arguments)
        settings = bridge_settings(arguments, timeout_default_ms=DEFAULT_BRIDGE_COMMAND_TIMEOUT_MS)
        return json_result(
            run_bridge_command(
                action,
                payload,
                host=settings["host"],
                port=settings["port"],
                namespace=settings["namespace"],
                timeout_ms=settings["timeout_ms"],
            )
        )

    return text_result(f"Unknown tool: {name}", is_error=True)


def handle_request(message: dict[str, Any]) -> None:
    msg_id = message.get("id")
    method = message.get("method")
    params = message.get("params") or {}

    if method == "initialize":
        negotiated_version = params.get("protocolVersion", "2025-03-26")
        send_result(
            msg_id,
            {
                "protocolVersion": negotiated_version,
                "capabilities": {"tools": {}},
                "serverInfo": {
                    "name": SERVER_NAME,
                    "version": SERVER_VERSION,
                },
            },
        )
        return

    if method == "notifications/initialized":
        return

    if method == "ping":
        send_result(msg_id, {})
        return

    if method == "tools/list":
        send_result(msg_id, {"tools": TOOLS})
        return

    if method == "tools/call":
        tool_name = params.get("name")
        arguments = params.get("arguments") or {}
        if not isinstance(tool_name, str):
            send_error(msg_id, -32602, "Invalid params", {"reason": "Missing tool name"})
            return
        if not isinstance(arguments, dict):
            send_error(msg_id, -32602, "Invalid params", {"reason": "Tool arguments must be an object"})
            return
        try:
            send_result(msg_id, handle_tool_call(tool_name, arguments))
        except Exception as exc:  # noqa: BLE001
            send_result(
                msg_id,
                text_result(
                    f"{type(exc).__name__}: {exc}",
                    is_error=True,
                ),
            )
        return

    if msg_id is not None:
        send_error(msg_id, -32601, f"Method not found: {method}")


def main() -> int:
    log(f"{SERVER_NAME} starting in {ROOT}")
    while True:
        try:
            message = read_message()
            if message is None:
                return 0
            handle_request(message)
        except KeyboardInterrupt:
            return 0
        except Exception as exc:  # noqa: BLE001
            log(f"fatal server error: {exc}")
            log(traceback.format_exc())
            return 1


if __name__ == "__main__":
    raise SystemExit(main())
