autowatch = 1;
inlets = 2;
outlets = 4;

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
var deviceSettleTask = new Task(announceDevicesReady, this);

function postln(s) {
	post("[serialosc_list_devices] " + s + "\n");
}

function resetDisplays() {
	outlet(1, 0);
	outlet(2, 0);
}

function announceDevicesReady() {
	// The parent patch waits for this before restoring the complete hardware
	// frame. By now grid_composite_2x128 has reapplied /sys host/port/prefix.
	outlet(3, "bang");
}

function scheduleDevicesReady() {
	deviceSettleTask.cancel();
	deviceSettleTask.schedule(200);
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
	scheduleDevicesReady();
}

function startQuery() {
	deviceIndex = 0;
	seenPorts = {};
	deviceSettleTask.cancel();
	resetDisplays();
	// /serialosc/notify is one-shot. Re-registering on every notification keeps
	// hot-plug detection alive; older serialosc versions may safely ignore it.
	outlet(0, "/serialosc/notify", replyHost, replyPort);
	outlet(0, "/serialosc/list", replyHost, replyPort);
	postln("→ /serialosc/notify + /serialosc/list " + replyHost + " " + replyPort +
		" (serialosc " + serverHost + ":" + serverPort + ")");
}

function processServerMessage(path, args) {
	if (path.indexOf("serialosc/device") >= 0 && args.length >= 3) {
		processDevice(args[0], args[1], args[2]);
		return true;
	}
	if (path.indexOf("serialosc/add") >= 0 || path.indexOf("serialosc/remove") >= 0) {
		postln(path.indexOf("/add") >= 0 ? "device added; refreshing ports" :
			"device removed; refreshing ports");
		startQuery();
		return true;
	}
	return false;
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
		processServerMessage(path, a.slice(1));
	} else if (a.length >= 1) {
		processServerMessage(String(a[0]), a.slice(1));
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
		processServerMessage(p, arrayfromargs(arguments));
	}
}

function loadbang() {
	postln("Set reply UDP port (number box) to match [udpreceive]; click Query.");
	postln("Ports appear in number boxes + Max console — use with [grid_composite_2x128].");
}
