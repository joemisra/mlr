#!/usr/bin/env node
/**
 * Quick test: is the MCP Socket.IO server (from Max) reachable?
 * Run: node test-mcp-connection.js
 *
 * Prerequisite: Open _mlr.maxpat in Max first so node.script starts the server.
 */

const net = require("net");

const PORT = 5002;

const socket = new net.Socket();
socket.setTimeout(2000);

socket.connect(PORT, "127.0.0.1", () => {
  console.log("✓ Port 5002 is open - MCP Socket.IO server is likely running.");
  socket.destroy();
  process.exit(0);
});

socket.on("error", (err) => {
  console.log("✗ Cannot connect to port 5002:", err.message);
  console.log("\nMake sure:");
  console.log("  1. Max is running with _mlr.maxpat open");
  console.log("  2. The MCP subpatch/copied content has node.script running");
  process.exit(1);
});

socket.on("timeout", () => {
  console.log("✗ Timeout. Is Max open with the patch?");
  socket.destroy();
  process.exit(1);
});
