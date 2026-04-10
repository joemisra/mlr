#!/usr/bin/env python3
"""Analyze .maxpat files and produce compact AI-friendly summaries.

Strips visual/layout noise (rects, colors, fonts, gradients) and preserves
only logical structure: objects, connections, subpatcher hierarchy, and
inter-patch messaging (send/receive).

Zero external dependencies -- stdlib only.
"""
import argparse
import json
import re
import sys
from pathlib import Path

SEND_RE = re.compile(r"^(?:send~?|s~?)\s+(.+)$")
RECV_RE = re.compile(r"^(?:receive~?|r~?)\s+(.+)$")


def parse_maxpat(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def box_label(box):
    """Build a compact human-readable label for a box."""
    mc = box.get("maxclass", "?")
    text = box.get("text", "")

    if mc == "bpatcher":
        name = box.get("name", "")
        args = box.get("args", [])
        label = f"bpatcher {name}" if name else "bpatcher"
        if args:
            label += f" args={args}"
        return label

    if mc in ("newobj", "message", "comment"):
        return text or mc

    if mc in ("inlet", "outlet"):
        comment = box.get("comment", "")
        idx = box.get("index", "")
        parts = [mc]
        if idx != "":
            parts[0] += f"[{idx}]"
        if comment:
            parts.append(f'"{comment}"')
        return " ".join(parts)

    if mc == "number":
        parts = [mc]
        attrs = []
        if "minimum" in box:
            attrs.append(f"min={box['minimum']}")
        if "maximum" in box:
            attrs.append(f"max={box['maximum']}")
        if attrs:
            parts.append(f"({', '.join(attrs)})")
        return " ".join(parts)

    if text:
        return f"{mc}: {text}"
    return mc


def extract_patcher(patcher, depth=0, max_depth=None, skip_comments=False):
    """Recursively extract logical structure from a patcher dict.

    Returns a dict with keys: objects, connections, subpatchers, sends, receives,
    bpatchers, scripts, stats.
    """
    result = {
        "objects": [],
        "connections": [],
        "subpatchers": [],
        "sends": set(),
        "receives": set(),
        "bpatchers": set(),
        "scripts": set(),
    }

    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])

    id_to_label = {}

    for bw in boxes:
        box = bw.get("box", bw)
        mc = box.get("maxclass", "?")

        if skip_comments and mc == "comment":
            continue

        obj_id = box.get("id", "?")
        label = box_label(box)
        ni = box.get("numinlets", 0)
        no = box.get("numoutlets", 0)
        varname = box.get("varname", "")
        filename = box.get("filename", "")

        id_to_label[obj_id] = label

        obj_info = {
            "id": obj_id,
            "maxclass": mc,
            "label": label,
            "numinlets": ni,
            "numoutlets": no,
        }
        if varname:
            obj_info["varname"] = varname
        if filename:
            obj_info["filename"] = filename

        result["objects"].append(obj_info)

        text = box.get("text", "")
        if mc == "newobj":
            m = SEND_RE.match(text)
            if m:
                result["sends"].add(m.group(1))
            m = RECV_RE.match(text)
            if m:
                result["receives"].add(m.group(1))

        if mc == "bpatcher" and box.get("name"):
            result["bpatchers"].add(box["name"])
        if filename:
            result["scripts"].add(filename)

        if "patcher" in box and (max_depth is None or depth < max_depth):
            sub_name = text or obj_id
            sub_result = extract_patcher(
                box["patcher"], depth + 1, max_depth, skip_comments
            )
            result["subpatchers"].append({
                "name": sub_name,
                "parent_id": obj_id,
                "depth": depth + 1,
                "data": sub_result,
            })
            result["sends"] |= sub_result["sends"]
            result["receives"] |= sub_result["receives"]
            result["bpatchers"] |= sub_result["bpatchers"]
            result["scripts"] |= sub_result["scripts"]

    for lw in lines:
        pl = lw.get("patchline", lw)
        src = pl.get("source", [])
        dst = pl.get("destination", [])
        conn = {
            "src_id": src[0] if src else "?",
            "src_out": src[1] if len(src) > 1 else 0,
            "dst_id": dst[0] if dst else "?",
            "dst_in": dst[1] if len(dst) > 1 else 0,
        }
        if pl.get("order") is not None:
            conn["order"] = pl["order"]
        if pl.get("disabled"):
            conn["disabled"] = True
        result["connections"].append(conn)

    return result


def count_all(result):
    """Count total objects, connections, subpatchers recursively."""
    objs = len(result["objects"])
    conns = len(result["connections"])
    subs = len(result["subpatchers"])
    for sp in result["subpatchers"]:
        so, sc, ss = count_all(sp["data"])
        objs += so
        conns += sc
        subs += ss
    return objs, conns, subs


def format_objects(objects, indent=""):
    """Format object list as compact text lines."""
    lines = []
    for o in objects:
        parts = [f"{indent}{o['id']:<14s} {o['label']}"]
        ni, no = o["numinlets"], o["numoutlets"]
        if ni > 1 or no > 1:
            parts.append(f"  [{ni} in, {no} out]")
        if o.get("varname"):
            parts.append(f"  varname={o['varname']}")
        lines.append("".join(parts))
    return lines


def format_connections(connections, indent=""):
    """Format connection list as compact edge notation."""
    sorted_conns = sorted(connections, key=lambda c: (c["src_id"], c["src_out"], c.get("order", 0)))

    lines = []
    for c in sorted_conns:
        s = f"{indent}{c['src_id']}:{c['src_out']} -> {c['dst_id']}:{c['dst_in']}"
        tags = []
        if c.get("order") is not None:
            tags.append(f"order={c['order']}")
        if c.get("disabled"):
            tags.append("DISABLED")
        if tags:
            s += f"  ({', '.join(tags)})"
        lines.append(s)
    return lines


def format_patcher(result, name, indent="", sends_only=False):
    """Format a full patcher (objects + connections + subpatchers) as text lines."""
    out = []

    if sends_only:
        return out

    if not sends_only:
        if result["objects"]:
            out.append(f"{indent}### Objects")
            out.extend(format_objects(result["objects"], indent))
            out.append("")

        if result["connections"]:
            out.append(f"{indent}### Connections")
            out.extend(format_connections(result["connections"], indent))
            out.append("")

    for sp in result["subpatchers"]:
        sub_data = sp["data"]
        sub_obj_count = len(sub_data["objects"])
        sub_conn_count = len(sub_data["connections"])
        sub_sub_count = len(sub_data["subpatchers"])
        header = f'{indent}## Subpatcher "{sp["name"]}" ({sp["parent_id"]})'
        stats = f"{sub_obj_count} objects, {sub_conn_count} connections"
        if sub_sub_count:
            stats += f", {sub_sub_count} subpatchers"
        out.append(header)
        out.append(f"{indent}{stats}")
        out.append("")
        out.extend(format_patcher(sub_data, sp["name"], indent + "  ", sends_only))

    return out


def format_send_receive(result):
    """Format the send/receive map."""
    lines = []
    if result["sends"]:
        sorted_sends = sorted(result["sends"])
        lines.append(f"  send: {', '.join(sorted_sends)}")
    if result["receives"]:
        sorted_recvs = sorted(result["receives"])
        lines.append(f"  receive: {', '.join(sorted_recvs)}")
    matched = result["sends"] & result["receives"]
    send_only = result["sends"] - result["receives"]
    recv_only = result["receives"] - result["sends"]
    if send_only:
        lines.append(f"  send-only (no local receiver): {', '.join(sorted(send_only))}")
    if recv_only:
        lines.append(f"  receive-only (no local sender): {', '.join(sorted(recv_only))}")
    return lines


def format_refs(result):
    """Format external references (bpatchers, js files)."""
    lines = []
    if result["bpatchers"]:
        lines.append(f"  bpatcher: {', '.join(sorted(result['bpatchers']))}")
    if result["scripts"]:
        lines.append(f"  js/v8: {', '.join(sorted(result['scripts']))}")
    return lines


def analyze_file(path, max_depth=None, skip_comments=False, sends_only=False):
    """Analyze one .maxpat file and return formatted text."""
    data = parse_maxpat(path)
    patcher = data.get("patcher", data)
    result = extract_patcher(patcher, 0, max_depth, skip_comments)
    total_objs, total_conns, total_subs = count_all(result)

    out = []
    filename = Path(path).name
    out.append(f"# {filename}")
    out.append(f"Root: {len(result['objects'])} objects, {len(result['connections'])} connections")
    if total_subs:
        out.append(
            f"Total (incl. subpatchers): {total_objs} objects, "
            f"{total_conns} connections, {total_subs} subpatchers"
        )
    out.append("")

    out.extend(format_patcher(result, "root", "", sends_only))

    sr = format_send_receive(result)
    if sr:
        out.append("## Send/Receive Map")
        out.extend(sr)
        out.append("")

    refs = format_refs(result)
    if refs:
        out.append("## External References")
        out.extend(refs)
        out.append("")

    return "\n".join(out)


def main():
    parser = argparse.ArgumentParser(
        description="Analyze .maxpat files and produce compact AI-friendly summaries."
    )
    parser.add_argument("files", nargs="+", help=".maxpat file(s) to analyze")
    parser.add_argument(
        "--depth", type=int, default=None,
        help="Max subpatcher recursion depth (default: unlimited)",
    )
    parser.add_argument(
        "--no-comments", action="store_true",
        help="Skip comment objects (maxclass=comment)",
    )
    parser.add_argument(
        "--sends-only", action="store_true",
        help="Only show send/receive topology and external references",
    )
    parser.add_argument(
        "-o", "--output", type=str, default=None,
        help="Write output to file instead of stdout",
    )
    args = parser.parse_args()

    sections = []
    for fpath in args.files:
        p = Path(fpath)
        if not p.exists():
            print(f"Error: {fpath} not found", file=sys.stderr)
            sys.exit(1)
        if not p.suffix == ".maxpat":
            print(f"Warning: {fpath} is not a .maxpat file", file=sys.stderr)
        sections.append(analyze_file(fpath, args.depth, args.no_comments, args.sends_only))

    output = "\n---\n\n".join(sections)

    if args.output:
        Path(args.output).write_text(output, encoding="utf-8")
        print(f"Wrote {args.output}", file=sys.stderr)
    else:
        print(output)


if __name__ == "__main__":
    main()
