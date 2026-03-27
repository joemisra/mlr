autowatch = 1;
inlets = 2;
outlets = 3;

/**
 * Discover Monome grid UDP ports via serialosc (see monome.org/docs/serialosc/osc/).
 *
 * Inlet 0: from [udpreceive] on reply_port — raw OSC (/serialosc/device …) or,
 *           if you use [OSC-route /serialosc/device] first, just id type port (3 atoms).
 * Inlet 1: bang or "query" → send /serialosc/list; "reply_port N"; "reply_host s";
 *          "server_port N" (hint only — change [udpsend] in patch if not 12002).
 *
 * Outlet 0 → [udpsend 127.0.0.1 12002]
 * Outlet 1 → int port for 1st device (grid_composite_2x128 top)
 * Outlet 2 → int port for 2nd device (bottom)
 */

var replyPort = 57888;
var serverPort = 12002;
var serverHost = "127.0.0.1";
var replyHost = "127.0.0.1";
var deviceIndex = 0;
var seenPorts = {};

function postln(s) {
	post("[serialosc_list_devices] " + s + "\n");
}

function resetDisplays() {
	outlet(1, 0);
	outlet(2, 0);
}

function processDevice(id, typ, port) {
	port = port | 0;
	if (seenPorts[port]) {
		return;
	}
	seenPorts[port] = 1;
	postln(String(typ) + "  id=" + String(id) + "  UDP port=" + port);
	if (deviceIndex === 0) {
		outlet(1, port);
	} else if (deviceIndex === 1) {
		outlet(2, port);
	}
	deviceIndex++;
}

function startQuery() {
	deviceIndex = 0;
	seenPorts = {};
	resetDisplays();
	outlet(0, "/serialosc/list", replyHost, replyPort);
	postln("→ /serialosc/list " + replyHost + " " + replyPort + " (serialosc " + serverHost + ":" + serverPort + ")");
}

function bang() {
	if (inlet === 1) {
		startQuery();
	}
}

function msg_int(n) {
	if (inlet === 1) {
		replyPort = n | 0;
		postln("reply_port " + replyPort);
	}
}

function list() {
	var a = arrayfromargs(arguments);
	if (inlet !== 0) {
		return;
	}
	if (a.length === 3) {
		processDevice(a[0], a[1], a[2]);
		return;
	}
	if (a.length >= 4) {
		var path = String(a[0]);
		if (path.indexOf("serialosc/device") >= 0) {
			processDevice(a[1], a[2], a[3]);
		}
	}
}

function anything() {
	if (inlet === 1) {
		if (messagename === "query") {
			startQuery();
		} else if (messagename === "reply_port" && arguments.length) {
			replyPort = parseInt(arguments[0], 10) || replyPort;
			postln("reply_port " + replyPort);
		} else if (messagename === "reply_host" && arguments.length) {
			replyHost = String(arguments[0]);
			postln("reply_host " + replyHost);
		} else if (messagename === "server_port" && arguments.length) {
			serverPort = parseInt(arguments[0], 10) || serverPort;
			postln("server_port " + serverPort + " — edit [udpsend] in this patch if needed");
		}
		return;
	}
	if (inlet === 0) {
		var p = String(messagename);
		if (p.indexOf("serialosc/device") >= 0) {
			var args = arrayfromargs(arguments);
			if (args.length >= 3) {
				processDevice(args[0], args[1], args[2]);
			}
		}
	}
}

function loadbang() {
	postln("Set reply UDP port (number box) to match [udpreceive]; click Query.");
	postln("Ports appear in number boxes + Max console — use with [grid_composite_2x128].");
}
