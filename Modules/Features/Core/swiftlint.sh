
LINTABLE_PATHS=()
are_there_valid_lintable_files() {
    [ ${#LINTABLE_PATHS[@]} -ne 0 ]
}
file_exists() {
    local file="$1"
    [[ -f "$file" ]] && return 0 || return 1
}
is_in_merge_state() {
    file_exists "$(git rev-parse --git-dir)/MERGE_HEAD"
}
is_swift_file() {
    local filename="${1}"
    [[ "${filename##*.}" == "swift" ]]
}
filter_valid_files() {
    local filename="${1}"
    if is_swift_file "$filename" && file_exists "$filename"; then
        LINTABLE_PATHS+=( "${filename}" )
    fi
}
retrieve_local_diff() {
    unstaged_files=$(git diff --name-only --relative --diff-filter=d)
    staged_files=$(git diff --cached --name-only --relative --diff-filter=d)
    for filename in $unstaged_files $staged_files
    do  
        filter_valid_files "${filename}";
    done
}
run_swiftlint() {
    if /opt/homebrew/bin/swiftlint >/dev/null; then
        SWIFTLINT_YML_PATH="$(git rev-parse --show-toplevel)/.swiftlint.yml"
        /opt/homebrew/bin/swiftlint --config "${SWIFTLINT_YML_PATH}" -- ${LINTABLE_PATHS[@]};
    else
        echo "error: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
}
run_swiftlint_on_valid_local_diff() {
    retrieve_local_diff
    if are_there_valid_lintable_files; then
        run_swiftlint
    fi
}
validate_use_of_interface_modules() {
    if ! is_in_merge_state; then
        run_swiftlint_on_valid_local_diff
    fi
}
validate_use_of_interface_modules
