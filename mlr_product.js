"use strict";

// The source workspace remains the integrated development edition. The edition
// builder writes this module into each standalone project before it is opened.
// This is a product capability, never a session or workstation preference.
module.exports = Object.freeze({ id: "rta", name: "ṛta", rta: true });
