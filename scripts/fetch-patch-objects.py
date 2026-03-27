#!/usr/bin/env python3
"""
Fetch objects from the top-level Max patch via Socket.IO.
Requires: Max running with _mlr.maxpat open (node.script serving on 5002).
Run from MaxMSP-MCP-Server: .venv/bin/python ../mlr/scripts/fetch-patch-objects.py
"""
import asyncio
import json
import os
import sys
import uuid

# Add MaxMSP-MCP-Server to path for socketio
sys.path.insert(0, os.path.expanduser("~/Projects/MaxMSP-MCP-Server"))
import socketio

PORT = 5002
NAMESPACE = "/mcp"
URL = f"http://127.0.0.1:{PORT}"

async def main():
    sio = socketio.AsyncClient()
    response_received = asyncio.Event()
    result_container = [None]

    @sio.on("response", namespace=NAMESPACE)
    def on_response(data):
        print("Received response event")
        result_container[0] = data
        response_received.set()

    @sio.on("connect", namespace=NAMESPACE)
    def on_connect():
        print("Connected to Max (Socket.IO)")

    @sio.on("connect_error", namespace=NAMESPACE)
    def on_error(data):
        print("Connection error:", data)
        response_received.set()

    try:
        await sio.connect(URL, namespaces=[NAMESPACE], wait_timeout=3)
    except Exception as e:
        print(f"Cannot connect to {URL}: {e}")
        print("Is Max open with _mlr.maxpat?")
        return 1

    request_id = str(uuid.uuid4())
    payload = {"action": "get_objects_in_patch", "request_id": request_id, "limit": 10}
    print("Emitting request...")
    await sio.emit("request", payload, namespace=NAMESPACE)

    try:
        await asyncio.wait_for(response_received.wait(), timeout=10.0)
    except asyncio.TimeoutError:
        print("Timeout waiting for response from Max")
        await sio.disconnect()
        return 1

    await sio.disconnect()

    if result_container[0] is None:
        print("No response received")
        return 1

    data = result_container[0]
    if "results" in data:
        results = data["results"]
        if isinstance(results, dict) and "boxes" in results:
            boxes = results["boxes"]
            lines = results.get("lines", [])
            print(f"\n--- Top-level patch: {len(boxes)} objects, {len(lines)} patch cords ---\n")
            for i, box in enumerate(boxes[:50]):  # First 50
                cls = box.get("maxclass", "?")
                var = box.get("varname", "")
                text = box.get("text", box.get("boxtext", ""))
                rect = box.get("patching_rect", [])
                print(f"  {i+1}. [{cls}] varname={var or '(none)'} text={text[:60] if text else ''}")
            if len(boxes) > 50:
                print(f"  ... and {len(boxes) - 50} more")
        else:
            print(json.dumps(results, indent=2))
    else:
        print(json.dumps(data, indent=2))

    return 0

if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
