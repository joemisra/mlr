
autowatch = 1; // 1
inlets = 1; // Receive network messages here
outlets = 2; // For status, responses, etc.

function safe_parse_json(str) {
    try {
        return JSON.parse(str);
    } catch (e) {
        outlet(0, "error", "Invalid JSON: " + e.message);
        return null;
    }
}

function split_long_string(inString, maxLength) {
    // var longString = inString.replace(/\s+/g, "");
    var result = [];
    for (var i = 0; i < inString.length; i += maxLength) {
        result.push(inString.substring(i, i + maxLength));
    }
    return result;
}

function emit_error_response(request_id, message, details) {
    var results = {
        success: false,
        error: message
    };
    if (details !== undefined) {
        results.details = details;
    }
    outlet(1, "response", split_long_string(JSON.stringify({
        request_id: request_id,
        results: results
    }, null, 0), 2500));
}

function anything() {
    var a = arrayfromargs(messagename, arguments);
    switch (messagename) {
        case "add_boxtext":
            if (a.length < 3) {
                post("add_boxtext: need two args: request_id, stringified_patcher_dict \n");
                return;
            }
            add_boxtext(a[1], a.slice(2).join(""));
            break;
        default:
            outlet(1, messagename, a.slice(1).join(""));
    }
}

function add_boxtext(request_id, data){
    // post(patcher_dict + "\n");
    var patcher_dict = safe_parse_json(data);
    var p = this.patcher;

    if (!patcher_dict || typeof patcher_dict !== "object") {
        emit_error_response(request_id, "Invalid add_boxtext payload", {
            payload_length: data ? data.length : 0
        });
        return;
    }

    if (!patcher_dict.boxes || !patcher_dict.boxes.forEach) {
        patcher_dict.boxes = [];
    }

    patcher_dict.boxes.forEach(function (b) {
        var obj = p.getnamed(b.box.varname);
        if (obj) {
            b.box["text"] = obj.boxtext;
        }
    });

    var results = {"request_id": request_id, "results": patcher_dict}
    outlet(1, "response", split_long_string(JSON.stringify(results, null, 0), 2500));
}
