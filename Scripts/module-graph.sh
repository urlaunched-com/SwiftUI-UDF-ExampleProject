#!/bin/sh
# Export local Tuist modules to Mermaid and open the interactive HTML viewer.
set -eu

# Required command-line tools:
# - tuist: exports the dependency graph as JSON.
# - jq: processes the JSON and generates Mermaid.
# - open: opens the HTML viewer in the default browser on macOS.
check_dependencies() {
    for tool in tuist jq open; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            echo "error: [ModuleGraph] $tool is not installed or is not available in PATH" >&2
            exit 1
        fi
    done
}

cleanup() {
    rm -rf "$temporary"
}

# Set the repository and HTML viewer paths, create a unique temporary directory,
# and register cleanup to remove that directory when the script exits.
prepare_workspace() {
    repo=$(cd "$(dirname "$0")/.." && pwd)
    viewer="$repo/Derived/ModuleGraph/MODULE_GRAPH.html"
    temporary=$(mktemp -d "${TMPDIR:-/tmp}/tuist-graph.XXXXXX")
    trap cleanup EXIT
}

# Export the repository's Tuist dependency graph as graph.json in the temporary
export_graph() {
    tuist graph --format json --no-open --path "$repo" --output-path "$temporary"
}

# Select local modules and build the dependency lookup used by Mermaid generation.
# Example output written to "$temporary/local-graph.json":
# {
#   "targets": [
#     {
#       "key": "[\"/repo/Flick\",\"Common\"]",
#       "path": "/repo/Flick",
#       "name": "Common",
#       "project": "Flick"
#     },
#     {
#       "key": "[\"/repo/Flick\",\"Home\"]",
#       "path": "/repo/Flick",
#       "name": "Home",
#       "project": "Flick"
#     }
#   ],
#   "dependencies": {
#     "[\"/repo/Flick\",\"Home\"]": ["[\"/repo/Flick\",\"Common\"]"]
#   }
# }
# local_module_targets builds "targets"; dependency_lookup builds "dependencies".
# Each target key is a JSON-encoded [project path, target name] string.
select_local_targets() {
    jq -e '
        # Tuist exports these dictionaries as alternating key/value arrays
        def dictionary_entries:
            if type == "array" and length % 2 == 0 then
                [
                    range(0; length; 2) as $index
                    | {
                        key: .[$index],
                        value: .[$index + 1]
                    }
                ]
            else
                error("Expected Tuist alternating key/value JSON dictionary")
            end;

        def target_key:
            [.path, .name] | tojson;

        def local_module_targets:
            [
                .projects
                | dictionary_entries[]
                | .key as $project_path
                | .value as $project
                | select($project.type | has("local"))
                | $project.targets
                | to_entries[]
                | .key as $target_name
                | .value as $target
                | select($target.product != "unit_tests")
                | select($target.product != "ui_tests")
                | select($target_name | contains("SnapshotTests") | not)
                | {
                    key: ({path: $project_path, name: $target_name} | target_key),
                    path: $project_path,
                    name: $target_name,
                    project: $project.name
                }
            ]
            | sort_by(.name, .path);

        def dependency_lookup:
            .dependencies
            | dictionary_entries
            | map(
                select(.key.target != null)
                | {
                    key: (.key.target | target_key),
                    value: [
                        .value[]
                        | select(.target != null)
                        | .target
                        | target_key
                    ]
                }
            )
            | from_entries;

        {
            targets: local_module_targets,
            dependencies: dependency_lookup
        }
    ' "$temporary/graph.json" > "$temporary/local-graph.json"
}

# Generate the diagram with target names and dependency arrows.
generate_mermaid() {
    jq -er '
        # Make target names display correctly in the diagram.
        def mermaid_label:
            gsub("&"; "#38;")
            | gsub("\""; "#34;")
            | gsub("<"; "#60;")
            | gsub(">"; "#62;")
            | gsub("\n"; " ");

        # Build Mermaid IDs directly from target names.
        def assign_target_ids:
            map({
                key: .key,
                value: ("target_" + (.name | gsub("[^A-Za-z0-9_]"; "_")))
            })
            | from_entries;

        # Define the name displayed for each target in the diagram.
        # Example: target_Home["Home"]
        def node_lines($target_ids):
            .[] as $target
            | ($target.name | mermaid_label) as $label
            | "  \($target_ids[$target.key])[\"\($label)\"]";

        # Create arrows from each target to its dependencies included in the diagram.
        def edge_lines($target_ids; $dependencies):
            .[] as $source
            | [
                $dependencies[$source.key][]?
                | select($target_ids[.] != null)
                | $target_ids[.]
            ]
            | unique as $dependency_ids
            | if ($dependency_ids | length) > 0 then
                "",
                ($dependency_ids[] | "  \($target_ids[$source.key]) --> \(.)")
              else
                empty
              end;

        .targets as $targets
        | .dependencies as $dependencies
        | ($targets | assign_target_ids) as $target_ids
        | [
            "graph TD",
            ($targets | node_lines($target_ids)),
            ($targets | edge_lines($target_ids; $dependencies))
        ]
        | join("\n")
    ' "$temporary/local-graph.json" > "$temporary/graph.mmd"
}

# Prepare graph text so special characters display correctly in the HTML viewer.
escape_html() {
    sed -e 's/\&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
        -e 's/"/\&quot;/g' -e "s/'/\\&#x27;/g" "$1"
}

generate_viewer() {
    if [ "$(sed -n '/^__MODULE_GRAPH__$/p' "$repo/mermaid-viewer.html" | wc -l | tr -d ' ')" -ne 1 ]; then
        echo "error: [ModuleGraph] Expected one __MODULE_GRAPH__ placeholder in mermaid-viewer.html" >&2
        exit 1
    fi

    escape_html "$temporary/graph.mmd" > "$temporary/escaped-graph.txt"
    (
        cd "$temporary"
        sed '/^__MODULE_GRAPH__$/ {
            r escaped-graph.txt
            d
        }' "$repo/mermaid-viewer.html" > MODULE_GRAPH.html
    )
}

publish_outputs() {
    mkdir -p "$(dirname "$viewer")"
    cp "$temporary/MODULE_GRAPH.html" "$viewer"
    echo "[ModuleGraph] Viewer: $viewer"
}

open_viewer() {
    open "$viewer"
}

main() {
    check_dependencies
    prepare_workspace
    export_graph
    select_local_targets
    generate_mermaid
    generate_viewer
    publish_outputs
    open_viewer
}

main
