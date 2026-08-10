"use strict";

const fs = require("node:fs");
const path = require("node:path");
const os = require("node:os");
const crypto = require("node:crypto");
const Core = require("./mlr_session_core.js");

let maxAPI = null;
try { maxAPI = require("max-api"); } catch (error) { /* Node unit tests */ }

const transactions = new Map();
let currentBundle = "";
let currentDocument = null;

function transactionId(prefix) {
	return `${prefix}-${Date.now()}-${crypto.randomBytes(4).toString("hex")}`;
}

function sessionJsonPath(input) {
	const requested = path.resolve(String(input || ""));
	if (path.basename(requested).toLowerCase() === "session.json") return requested;
	return path.join(requested, "session.json");
}

function bundlePath(input) {
	const requested = path.resolve(String(input || ""));
	if (path.basename(requested).toLowerCase() === "session.json") return path.dirname(requested);
	return Core.withBundleExtension(requested);
}

function readDocument(input) {
	const jsonPath = sessionJsonPath(input);
	const document = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
	const validation = Core.validateDocument(document);
	if (!validation.valid) throw new Error(validation.errors.join(" · "));
	return { document, bundle: path.dirname(jsonPath) };
}

function relativeAssetPaths(document) {
	const assets = [];
	for (let group = 0; group < document.racks.length; group++) {
		const slots = Array.isArray(document.racks[group].slots) ? document.racks[group].slots : [];
		for (let slot = 0; slot < slots.length; slot++) {
			if (slots[slot] && slots[slot].snapshot) assets.push(slots[slot].snapshot);
		}
	}
	for (const recording of document.recordings || []) {
		if (recording.bundlePath) assets.push(recording.bundlePath);
	}
	return assets;
}

function resolveBundleAssets(document, bundle) {
	const resolved = Core.deepClone(document);
	for (const rack of resolved.racks || []) {
		for (const slot of rack.slots || []) {
			if (slot.snapshot && !path.isAbsolute(slot.snapshot)) {
				slot.snapshot = path.join(bundle, slot.snapshot);
			}
		}
	}
	for (const recording of resolved.recordings || []) {
		if (recording.bundlePath && !path.isAbsolute(recording.bundlePath)) {
			recording.resolvedPath = path.join(bundle, recording.bundlePath);
		}
	}
	return resolved;
}

function missingSamples(document) {
	const missing = [];
	const samples = document.bank && Array.isArray(document.bank.samples) ? document.bank.samples : [];
	for (let index = 0; index < samples.length; index++) {
		const value = typeof samples[index] === "string" ? samples[index] : samples[index] && samples[index].path;
		if (value && !fs.existsSync(value)) missing.push({ index, path: String(value), type: "sample" });
	}
	for (const recording of document.recordings || []) {
		if (recording.resolvedPath && !fs.existsSync(recording.resolvedPath)) {
			missing.push({ path: recording.resolvedPath, type: "recording" });
		}
	}
	for (const rack of document.racks || []) {
		for (const slot of rack.slots || []) {
			if (slot.snapshot && path.isAbsolute(slot.snapshot) && !fs.existsSync(slot.snapshot)) {
				missing.push({ path: slot.snapshot, type: "plugin-state" });
			}
		}
	}
	return missing;
}

async function waitForAssets(root, relativePaths, timeoutMs = 3500) {
	const deadline = Date.now() + timeoutMs;
	const expected = relativePaths.map((asset) => path.join(root, asset));
	while (Date.now() <= deadline) {
		const missing = expected.filter((asset) => {
			try { return !fs.statSync(asset).isFile() || fs.statSync(asset).size <= 0; }
			catch (error) { return true; }
		});
		if (!missing.length) return;
		await new Promise((resolve) => setTimeout(resolve, 40));
	}
	const missing = expected.filter((asset) => {
		try { return !fs.statSync(asset).isFile() || fs.statSync(asset).size <= 0; }
		catch (error) { return true; }
	});
	throw new Error(`Timed out waiting for ${missing.map((asset) => path.basename(asset)).join(", ")}`);
}

function atomicInstall(staging, target) {
	if (!/\.mlr-session$/i.test(target)) throw new Error("Refusing to install a non-session directory");
	const backup = `${target}.backup-${crypto.randomBytes(4).toString("hex")}`;
	let movedExisting = false;
	try {
		if (fs.existsSync(target)) {
			fs.renameSync(target, backup);
			movedExisting = true;
		}
		fs.renameSync(staging, target);
		if (movedExisting) fs.rmSync(backup, { recursive: true, force: true });
	} catch (error) {
		if (!fs.existsSync(target) && movedExisting && fs.existsSync(backup)) fs.renameSync(backup, target);
		throw error;
	}
}

function copyRetainedPluginStates(transaction) {
	if (!currentBundle || !currentDocument || !fs.existsSync(currentBundle)) return;
	for (const rack of transaction.document.racks || []) {
		for (const slot of rack.slots || []) {
			if (!slot || !slot.uri || slot.loaded || !slot.snapshot) continue;
			const source = path.join(currentBundle, slot.snapshot);
			const destination = path.join(transaction.staging, slot.snapshot);
			if (!fs.existsSync(source)) continue;
			fs.mkdirSync(path.dirname(destination), { recursive: true });
			fs.copyFileSync(source, destination);
		}
	}
}

async function prepareSave(destination, dictName) {
	if (!maxAPI) throw new Error("Max API unavailable");
	const fragments = await maxAPI.getDict(String(dictName));
	const existing = currentDocument && currentBundle === bundlePath(destination) ? currentDocument : null;
	const document = fragments.format === Core.FORMAT ? fragments : Core.buildDocument(fragments, existing);
	const validation = Core.validateDocument(document);
	if (!validation.valid) throw new Error(validation.errors.join(" · "));
	const target = bundlePath(destination);
	const id = transactionId("save");
	const staging = `${target}.tmp-${id}`;
	fs.mkdirSync(path.join(staging, "plugins"), { recursive: true });
	fs.mkdirSync(path.join(staging, "recordings"), { recursive: true });
	transactions.set(id, { id, target, staging, document, dictName: String(dictName) });
	await maxAPI.outlet("save_assets", id, staging, String(dictName));
	return { id, target, staging, document };
}

async function finalizeSave(id) {
	const transaction = transactions.get(String(id));
	if (!transaction) throw new Error("Unknown save transaction");
	try {
		copyRetainedPluginStates(transaction);
		await waitForAssets(transaction.staging, relativeAssetPaths(transaction.document));
		fs.writeFileSync(path.join(transaction.staging, "session.json"),
			`${JSON.stringify(transaction.document, null, 2)}\n`, "utf8");
		readDocument(transaction.staging);
		atomicInstall(transaction.staging, transaction.target);
		currentBundle = transaction.target;
		currentDocument = transaction.document;
		transactions.delete(transaction.id);
		if (maxAPI) await maxAPI.outlet("save_complete", transaction.target,
			path.basename(transaction.target, ".mlr-session"));
		return transaction.target;
	} catch (error) {
		transactions.delete(transaction.id);
		if (fs.existsSync(transaction.staging)) fs.rmSync(transaction.staging, { recursive: true, force: true });
		throw error;
	}
}

async function openBundle(input) {
	const loaded = readDocument(input);
	const resolved = resolveBundleAssets(loaded.document, loaded.bundle);
	const missing = missingSamples(resolved);
	const dictName = `mlr_session_load_${Date.now()}`;
	if (maxAPI) {
		await maxAPI.setDict(dictName, resolved);
		await maxAPI.outlet("open_ready", dictName, loaded.bundle,
			path.basename(loaded.bundle, ".mlr-session"), JSON.stringify(missing));
	}
	currentBundle = loaded.bundle;
	currentDocument = loaded.document;
	return { document: resolved, bundle: loaded.bundle, missing };
}

function walkAudioFiles(root, maximum = 12000, maximumDepth = 8) {
	const result = [];
	const queue = [{ path: path.resolve(root), depth: 0 }];
	while (queue.length && result.length < maximum) {
		const current = queue.shift();
		let entries = [];
		try { entries = fs.readdirSync(current.path, { withFileTypes: true }); }
		catch (error) { continue; }
		for (const entry of entries) {
			if (entry.name.startsWith(".")) continue;
			const fullPath = path.join(current.path, entry.name);
			if (entry.isDirectory() && current.depth < maximumDepth) queue.push({ path: fullPath, depth: current.depth + 1 });
			else if (entry.isFile() && /\.(?:wav|wave|aif|aiff)$/i.test(entry.name)) result.push(fullPath);
			if (result.length >= maximum) break;
		}
	}
	return result;
}

async function relinkBundle(folder) {
	if (!currentDocument || !currentBundle) throw new Error("Open a session before relinking");
	const files = walkAudioFiles(folder);
	const result = Core.relinkSamples(currentDocument, files, fs.existsSync);
	currentDocument = result.document;
	const resolved = resolveBundleAssets(currentDocument, currentBundle);
	const dictName = `mlr_session_relink_${Date.now()}`;
	if (maxAPI) {
		await maxAPI.setDict(dictName, resolved);
		await maxAPI.outlet("relink_ready", dictName, currentBundle,
			JSON.stringify(result.unresolved), result.relinked.length);
	}
	return result;
}

async function rackMove(group, from, to, fromPayload, toPayload) {
	const id = transactionId("rack-swap");
	const folder = path.join(os.tmpdir(), id);
	fs.mkdirSync(folder, { recursive: true });
	const fromPath = path.join(folder, "from.maxsnap");
	const toPath = path.join(folder, "to.maxsnap");
	const fromDescriptor = JSON.parse(String(fromPayload || "{}"));
	const toDescriptor = JSON.parse(String(toPayload || "{}"));
	if (maxAPI) await maxAPI.outlet("rack_swap_export", group, from, to, fromPath, toPath);
	const expected = [];
	if (fromDescriptor.loaded && fromDescriptor.uri) expected.push("from.maxsnap");
	if (toDescriptor.loaded && toDescriptor.uri) expected.push("to.maxsnap");
	await waitForAssets(folder, expected, 2500);
	if (fromDescriptor.loaded && fromDescriptor.uri) fromDescriptor.snapshot = fromPath;
	if (toDescriptor.loaded && toDescriptor.uri) toDescriptor.snapshot = toPath;
	if (maxAPI) await maxAPI.outlet("rack_swap_load", group, from, to,
		JSON.stringify(fromDescriptor), JSON.stringify(toDescriptor));
}

function reportError(operation, error) {
	const message = error && error.message ? error.message : String(error);
	if (maxAPI) maxAPI.outlet("session_error", String(operation), message);
}

if (maxAPI) {
	maxAPI.addHandler("save_bundle", (destination, dictName) =>
		prepareSave(destination, dictName).catch((error) => reportError("save", error)));
	maxAPI.addHandler("finalize_save", (id) =>
		finalizeSave(id).catch((error) => reportError("save", error)));
	maxAPI.addHandler("open_bundle", (input) =>
		openBundle(input).catch((error) => reportError("open", error)));
	maxAPI.addHandler("relink_bundle", (folder) =>
		relinkBundle(folder).catch((error) => reportError("relink", error)));
	maxAPI.addHandler("rack_move", (group, from, to, fromPayload, toPayload) =>
		rackMove(group, from, to, fromPayload, toPayload).catch((error) => reportError("rack move", error)));
	maxAPI.addHandler("status", () => maxAPI.outlet("manager_status", currentBundle || ""));
}

module.exports = {
	sessionJsonPath,
	bundlePath,
	readDocument,
	relativeAssetPaths,
	resolveBundleAssets,
	missingSamples,
	waitForAssets,
	atomicInstall,
	copyRetainedPluginStates,
	walkAudioFiles,
	prepareSave,
	finalizeSave,
	openBundle,
	relinkBundle,
	rackMove
};
