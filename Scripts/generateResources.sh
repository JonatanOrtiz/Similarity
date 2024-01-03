echo "\nGenerating source files with Swiftgen and Sourcery"

# Cleanup any generated from git index
find . -iname "*.generated.swift" -exec git rm --cached --ignore-unmatch {} \+

# Run on main projects first as their structure is not the same as modules
mkdir -p Similarity/Similarity/Generated
swiftgen config run --config Similarity/swiftgen.yml > /dev/null

# Run on modules
find Modules -name "swiftgen.yml" -print0 |
    while IFS= read -r -d '' path; do
        workingDirectory=$(dirname $path)
        moduleName=$(basename $workingDirectory)

        # Move into directory
        pushd $workingDirectory > /dev/null

        # If project has a pre-script setup on project.yml, run it, otherwise manually run swiftgen
        mkdir -p $moduleName/Generated
        if [ -f pre-generate.sh ]; then
            ./pre-generate.sh > /dev/null
        else
            swiftgen > /dev/null
        fi

        # Get back to root dir
        popd > /dev/null
    done

# Wait on all processes, a process may not exist anymore when getting here, so test for it first
echo "Done"
