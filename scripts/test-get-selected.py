#!/usr/bin/env python3
"""Test get_objects_in_selected via Socket.IO."""
import asyncio
import json
import sys
import uuid

sys.path.insert(0, "/Users/jm/Projects/MaxMSP-MCP-Server")
import socketio

async def main():
    sio = socketio.AsyncClient()
    done = asyncio.Event()
    result = [None]

    @sio.on("response", namespace="/mcp")
    def on_response(data):
        result[0] = data
        done.set()

    try:
        await sio.connect("http://127.0.0.1:5002", namespaces=["/mcp"], wait_timeout=3)
    except Exception as e:
        print(f"Cannot connect: {e}")
        return 1

    payload = {"action": "get_objects_in_selected", "request_id": str(uuid.uuid4())}
    await sio.emit("request", payload, namespace="/mcp")

    try:
        await asyncio.wait_for(done.wait(), timeout=5.0)
    except asyncio.TimeoutError:
        print("Timeout")
        await sio.disconnect()
        return 1

    await sio.disconnect()
    print(json.dumps(result[0], indent=2))
    return 0

if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
