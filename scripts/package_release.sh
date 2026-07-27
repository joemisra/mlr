#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
release_date="${RELEASE_DATE:-$(date +%Y%m%d)}"
commit="$(git -C "${project_dir}" rev-parse --short=12 HEAD)"
bundle_name="mlr-${release_date}-${commit}"
release_dir="${project_dir}/release"
archive_path="${release_dir}/${bundle_name}.zip"
stage_root="$(mktemp -d "${TMPDIR:-/tmp}/mlr-release.XXXXXX")"
bundle_dir="${stage_root}/${bundle_name}"

cleanup() {
  case "${stage_root}" in
    "${TMPDIR:-/tmp}"/mlr-release.*) rm -rf "${stage_root}" ;;
  esac
}
trap cleanup EXIT

if [[ -n "$(git -C "${project_dir}" status --porcelain --untracked-files=no)" ]]; then
  echo "Tracked files have uncommitted changes; commit them before packaging." >&2
  exit 1
fi

echo "Running MLR tests..."
node --test "${project_dir}"/tests/*.test.js

echo "Validating Max patch JSON..."
for patch in "${project_dir}"/*.maxpat; do
  jq empty "${patch}"
done

mkdir -p "${bundle_dir}"
git -C "${project_dir}" archive --format=tar HEAD | tar -xf - -C "${bundle_dir}"

# Development-only content is useful in Git, but not needed to run MLR in Max.
rm -rf \
  "${bundle_dir}/.cursor" \
  "${bundle_dir}/.vscode" \
  "${bundle_dir}/MaxMSP_Agent" \
  "${bundle_dir}/maxpat-jsonschema" \
  "${bundle_dir}/node_modules" \
  "${bundle_dir}/scripts" \
  "${bundle_dir}/tests"
rm -f \
  "${bundle_dir}/.gitignore" \
  "${bundle_dir}/max_mcp.js" \
  "${bundle_dir}/max_mcp_node.js" \
  "${bundle_dir}/max_mcp_v8_add_on.js" \
  "${bundle_dir}/package.json" \
  "${bundle_dir}/package-lock.json" \
  "${bundle_dir}"/summary*.md

cat > "${bundle_dir}/START-HERE.txt" <<EOF
MLR Max/MSP handoff
===================

Release date: ${release_date}
Git commit:   ${commit}

Open _mlr.maxpat in Max/MSP.

This bundle contains the runtime patchers, abstractions, JavaScript, presets,
images, and user documentation. Development-only tests, MCP helpers,
node_modules, editor settings, and Git metadata are intentionally omitted.

See README.md for the dual-grid, Sequence64, MechaTrellis color, and serialosc
setup notes.
EOF

(
  cd "${bundle_dir}"
  find . -type f ! -name SHA256SUMS.txt -print0 |
    sort -z |
    xargs -0 shasum -a 256 > SHA256SUMS.txt
)

mkdir -p "${release_dir}"
rm -f "${archive_path}"
(
  cd "${stage_root}"
  zip -q -r -X "${archive_path}" "${bundle_name}"
)

shasum -a 256 "${archive_path}" > "${archive_path}.sha256"
echo "MLR release created:"
echo "  ${archive_path}"
echo "  ${archive_path}.sha256"
