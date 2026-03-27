# maxpat JSON Schema

A [JSON Schema](https://json-schema.org/) (Draft-07) for Cycling '74 Max/MSP patcher files (`.maxpat`, `.maxhelp`).

Since there is no official specification for the `.maxpat` format, this schema was reverse-engineered from real-world patches spanning Max 8 and Max 9.

## What it gives you in VS Code / Cursor

- **Validation** — red squiggles on structurally invalid patches
- **Autocomplete** — property name suggestions when editing patch JSON
- **Hover docs** — descriptions of patcher, box, and patchline properties
- **Type checking** — correct types for colors, rects, inlet/outlet counts, etc.

## Setup

### Per-project (`.vscode/settings.json`)

```json
{
  "json.schemas": [
    {
      "fileMatch": ["*.maxpat", "*.maxhelp"],
      "url": "./path/to/maxpat.schema.json"
    }
  ],
  "files.associations": {
    "*.maxpat": "json",
    "*.maxhelp": "json"
  }
}
```

### Global (User Settings)

Add the same `json.schemas` entry to your user `settings.json`, using an absolute path for the `url`.

## Coverage

The schema covers:

- **Patcher** — `fileversion`, `appversion`, `rect`, `gridsize`, `boxes`, `lines`, font defaults, presentation mode, toolbar state, `styles`, `dependency_cache`, and more
- **Box** — all common `maxclass` types (`newobj`, `message`, `comment`, `toggle`, `button`, `number`, `flonum`, `umenu`, `bpatcher`, `panel`, `multislider`, `gain~`, `meter~`, etc.) with their specific attributes
- **Patchline** — `source`, `destination`, `midpoints`, `order`, `color`, `hidden`
- **Nested subpatchers** — recursive `patcher` inside boxes (for `p`, `poly~`, `pfft~`, `gen~`, etc.)
- **Styles** — named style definitions with `bgfillcolor` gradients
- **Dependencies** — `dependency_cache` entries

All definitions use `additionalProperties: true` where appropriate, so the schema won't reject patches that use attributes not yet cataloged.

## Limitations

- This is a community effort, not an official Cycling '74 product
- The `.maxpat` format has no public spec; undocumented attributes may exist
- Object-specific attribute validation (e.g. "a `dial` must have `size`") is not enforced — the schema validates structure, not semantic correctness
- RNBO patchers (`.rnbopat`) share the same skeleton but may have additional properties not yet covered

## Contributing

Found a property that's missing or typed wrong? Open an issue or PR with a sample `.maxpat` that triggers a validation error.
