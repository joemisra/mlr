var catalog; try { catalog = require("synth_engine_catalog.js"); } catch (error) { catalog = require("./synth_engine_catalog.js"); }
var factory; try { factory = require("instrument_parameter_model.js"); } catch (error) { factory = require("./instrument_parameter_model.js"); }
var model = factory.create(catalog.engines.filter(function (e) { return e.id === "rim"; })[0]);
Object.keys(model).forEach(function (key) { exports[key] = model[key]; });
