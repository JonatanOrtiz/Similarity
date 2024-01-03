#!/bin/sh

set -e 

source Scripts/envVariables.sh
source Scripts/ToolsHelper.sh

echo "\nGenerating main/modules projects"

check_program_installed "yq"
ROOT="$(git rev-parse --show-toplevel)"
VISITED=$(mktemp)
DEBUG='1' # Colocar 1 aqui pra imprimir o caminho

visit() {
    [[ $DEBUG ]] && echo "NEXT: $1"

    local config="$1"
    echo "$config" >> "$VISITED"
    
    local refs="$(yq -r '.projectReferences.[].path' $config | xargs -I {} dirname {})"
    if [[ -n "$refs" ]]; then
        # This guy points to another one. Add then to the top of stack
        while IFS= read -r -d $'\n' ref ; do
            local relativePath="$(dirname $config)/$ref/project.yml"
            local absolutePath="$(readlink -f $relativePath)"
            
            # If visited skip
            if ! grep -q "$absolutePath" "$VISITED"; then
                visit "$absolutePath"
            fi
        done <<<"$refs"
    fi

    local d="$(dirname $config)"
    [ ! -f "${d}/schemes.yml" ] && touch "${d}/schemes.yml" ;
    xcodegen -qs "$config"
}

find "$ROOT" -type f -name "project.yml" -not -path "*ModuleTemplates*" -print0 |
    while IFS= read -r -d '' config; do
        # Skip visited
        if ! grep -q "$config" "$VISITED" ; then
            visit "$config"
        fi
    done
echo "Done"
exit 0
