#!/usr/bin/env python3
"""
Test expand_selection via Socket.IO (bypasses MCP tool cache).
Requires: Max running with _mlr.maxpat open, some objects selected.
"""
import asyncio
import json
import sys
import uuid

sys.path.insert(0, "/Users/jm/Projects/MaxMSP-MCP-Server")
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
        result_container[0] = data
        response_received.set()

    try:
        await sio.connect(URL, namespaces=[NAMESPACE], wait_timeout=3)
    except Exception as e:
        print(f"Cannot connect: {e}")
        return 1

    request_id = str(uuid.uuid4())
    payload = {"action": "expand_selection", "request_id": request_id, "hops": 1}
    await sio.emit("request", payload, namespace=NAMESPACE)

    try:
        await asyncio.wait_for(response_received.wait(), timeout=5.0)
    except asyncio.TimeoutError:
        print("Timeout")
        await sio.disconnect()
        return 1

    await sio.disconnect()
    data = result_container[0]
    print(json.dumps(data, indent=2))
    return 0

if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
