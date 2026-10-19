#!/bin/sh
# Regenerates MODULE_GRAPH.md and checks the module graph (rules: module-rules.json5). Fails on violations.
#
#   Scripts/module-graph.sh                    check the repo and update MODULE_GRAPH.md
#   Scripts/module-graph.sh --ci               the same, and fail when the committed MODULE_GRAPH.md is out of date
#   Scripts/module-graph.sh <root> [<output>]  check another folder (the pre-commit hook passes its snapshot)
#
# module-graph comes from the Tools package (Tools/Package.swift); SwiftPM rebuilds it only when it changed.
set -eu

repo=$(cd "$(dirname "$0")/.." && pwd)
binary="$repo/Tools/.build/release/module-graph"
ci=false
if [ "${1:-}" = "--ci" ]; then
    ci=true
    shift
fi

[ -x "$binary" ] || echo "[ModuleGraph] Building module-graph (the first build takes a few minutes)..." >&2
swift build --quiet --configuration release --package-path "$repo/Tools" --product module-graph >&2

cd "$repo"
"$binary" "$@"

# The hook keeps MODULE_GRAPH.md in sync; on CI a difference means a commit skipped it (`git commit --no-verify`).
if $ci && { ! git ls-files --error-unmatch MODULE_GRAPH.md >/dev/null 2>&1 || ! git diff --exit-code -- MODULE_GRAPH.md; }; then
    echo "error: [ModuleGraph] MODULE_GRAPH.md is out of date. Run Scripts/module-graph.sh and commit it, or enable the hook: git config core.hooksPath .githooks" >&2
    exit 1
fi
