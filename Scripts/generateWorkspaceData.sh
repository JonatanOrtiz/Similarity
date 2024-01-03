#!/usr/bin/env bash

openWorkspace() {
    workspace='<?xml version="1.0" encoding="UTF-8"?>
<Workspace
    version = "1.0">'
}

closeWorkspace() {
    workspace+='
</Workspace>'
}

openGroup() {
    local groupName=$1
    workspace+='
    <Group
        location = "container:"
        name = "'$groupName'">'
}

closeGroup() {
    workspace+='
    </Group>'  
}

addFileRef() {
    local fileRef=$1
    workspace+='
        <FileRef
            location = "group:'$fileRef'.xcodeproj">
        </FileRef>'
}

generateTargetsGroup() {
    openGroup "Targets"
    addFileRef "Similarity/Similarity"
    closeGroup
}

generateModulesGroups() {
    for categoryPath in Modules/*; do
        if [[ -d $categoryPath ]]; then
            categoryName=$( basename $categoryPath )
            openGroup $categoryName
            for modulePath in "$categoryPath/"*; do
                moduleName=$( basename $modulePath )
                if [ ! -z "$moduleName" ]; then
                    addFileRef "$modulePath/$moduleName"
                fi
            done
            closeGroup
        fi
    done
}

generatePodGroup() {
   addFileRef "Pods/Pods"
}

generateWorkspaceData() {
    openWorkspace
    generateTargetsGroup
    generateModulesGroups
    generatePodGroup
    closeWorkspace
    
    echo "$workspace" > ./Similarity.xcworkspace/contents.xcworkspacedata
}

generateWorkspaceData