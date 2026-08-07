#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd -- "$script_dir/.." && pwd)"
tmp_dir="$repo_dir/build/render"
output_dir="$script_dir"
source_md="$script_dir/collatz_first_passage_natural_density.md"
style_css="$script_dir/first_passage_v2_print.css"
version_css="$script_dir/first_passage_v3_print.css"
html_file="$tmp_dir/collatz_first_passage_natural_density_v3.html"
output_pdf="$output_dir/collatz_first_passage_natural_density_v3.pdf"
mathjax_file="$tmp_dir/mathjax3-tex-chtml.js"
chrome_bin="${CHROME_BIN:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"

mkdir -p "$tmp_dir" "$output_dir"

if [[ ! -s "$mathjax_file" ]]; then
  curl -sS -L -o "$mathjax_file" \
    https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js
fi

pandoc \
  --from=markdown+tex_math_single_backslash \
  --standalone \
  --mathjax=mathjax3-tex-chtml.js \
  --embed-resources \
  --metadata lang=en \
  --metadata pagetitle='Fixed-Polylogarithmic Natural-Density Descent for the Collatz Map' \
  --css="$style_css" \
  --css="$version_css" \
  --resource-path="$script_dir:$tmp_dir" \
  "$source_md" \
  -o "$html_file"

chrome_profile="$(mktemp -d /tmp/collatz-first-passage-v3-chrome.XXXXXX)"
pdf_tmp="$(mktemp /tmp/collatz-first-passage-v3.XXXXXX)"
chrome_log="$(mktemp /tmp/collatz-first-passage-v3-chrome-log.XXXXXX)"
chrome_pid=""
cleanup() {
  if [[ -n "${chrome_pid:-}" ]]; then
    kill "$chrome_pid" 2>/dev/null || true
    wait "$chrome_pid" 2>/dev/null || true
  fi
  if [[ -n "${chrome_profile:-}" && "$chrome_profile" == /tmp/collatz-first-passage-v3-chrome.* ]]; then
    rm -rf -- "$chrome_profile"
  fi
  if [[ -n "${pdf_tmp:-}" && "$pdf_tmp" == /tmp/collatz-first-passage-v3.* ]]; then
    rm -f -- "$pdf_tmp"
  fi
  if [[ -n "${chrome_log:-}" && "$chrome_log" == /tmp/collatz-first-passage-v3-chrome-log.* ]]; then
    rm -f -- "$chrome_log"
  fi
}
trap cleanup EXIT

"$chrome_bin" \
  --headless=new \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --disable-background-networking \
  --disable-component-update \
  --disable-extensions \
  --no-first-run \
  --user-data-dir="$chrome_profile" \
  --allow-file-access-from-files \
  --no-pdf-header-footer \
  --print-to-pdf="$pdf_tmp" \
  "file://$html_file" \
  >"$chrome_log" 2>&1 &
chrome_pid="$!"

previous_size=0
stable_polls=0
for _ in {1..240}; do
  current_size="$(stat -f '%z' "$pdf_tmp")"
  if [[ "$current_size" -gt 0 && "$current_size" -eq "$previous_size" ]] && \
     pdfinfo "$pdf_tmp" >/dev/null 2>&1; then
    stable_polls=$((stable_polls + 1))
  else
    stable_polls=0
  fi
  if [[ "$stable_polls" -ge 4 ]]; then
    break
  fi
  previous_size="$current_size"
  sleep 0.25
done

if [[ "$stable_polls" -lt 4 ]]; then
  sed -n '1,160p' "$chrome_log" >&2
  echo "Chrome did not produce a stable PDF within 60 seconds" >&2
  exit 1
fi

kill "$chrome_pid" 2>/dev/null || true
wait "$chrome_pid" 2>/dev/null || true
chrome_pid=""

cp "$pdf_tmp" "$output_pdf"
pdfinfo "$output_pdf"
shasum -a 256 "$source_md" "$style_css" "$version_css" "$output_pdf"
