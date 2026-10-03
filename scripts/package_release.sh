#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
edition="${1:-mlr}"
case "${edition}" in
  mlr|rta) editions=("${edition}") ;;
  all) editions=(mlr rta) ;;
  *) echo "Usage: $0 [mlr|rta|all]" >&2; exit 1 ;;
esac
release_date="${RELEASE_DATE:-$(date +%Y%m%d)}"
commit="$(git -C "${project_dir}" rev-parse --short=12 HEAD)"
release_dir="${project_dir}/release"

if [[ -n "$(git -C "${project_dir}" status --porcelain --untracked-files=no)" ]]; then
  echo "Tracked files have uncommitted changes; commit them before packaging." >&2
  exit 1
fi
# An untracked source dependency must never sneak into a release bearing HEAD.
node - "${project_dir}" <<'JS'
const fs=require('node:fs'),path=require('node:path'),cp=require('node:child_process');
const root=process.argv[2];
for(const id of ['mlr','rta'])for(const file of JSON.parse(fs.readFileSync(path.join(root,'editions',id+'.json'))).files) {
 cp.execFileSync('git',['ls-files','--error-unmatch','--',file],{cwd:root,stdio:'pipe'});
}
JS

npm --prefix "${project_dir}" test
mkdir -p "${release_dir}"
for edition in "${editions[@]}"; do
  bundle_name="${edition}-${release_date}-${commit}"
  bundle_dir="${release_dir}/${bundle_name}"
  archive_path="${bundle_dir}.zip"
  if [[ -e "${bundle_dir}" || -e "${archive_path}" ]]; then
    echo "Release already exists: ${bundle_dir}; keep it or choose another RELEASE_DATE." >&2
    exit 1
  fi
  node "${project_dir}/scripts/build_editions.js" "${edition}" "${bundle_dir}"
  for patch in "${bundle_dir}"/*.maxpat; do jq empty "${patch}"; done
  if [[ -d "${project_dir}/samples" ]]; then
    cp -R "${project_dir}/samples" "${bundle_dir}/samples"
  fi
  git -C "${project_dir}" rev-parse HEAD > "${bundle_dir}/SOURCE-COMMIT.txt"
  (
    cd "${bundle_dir}"
    find . -type f ! -name SHA256SUMS.txt -print0 |
      sort -z | xargs -0 shasum -a 256 > SHA256SUMS.txt
  )
  (
    cd "${release_dir}"
    zip -q -r -X "${archive_path}" "${bundle_name}"
  )
  shasum -a 256 "${archive_path}" > "${archive_path}.sha256"
  echo "Created ${bundle_dir}"
  echo "Created ${archive_path} and SHA-256 checksum"
done
