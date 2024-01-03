#!/bin/bash
set -euo pipefail

PROCESS="Xcode"
CLOSE=${1:-yes}

if [ "${CLOSE}" != "no" ]; then
    if [ "$(pgrep -xu "$USER" "$PROCESS")" ]; then
        echo "Force-quitting ${PROCESS}..."
        killall "$PROCESS"
    else
        echo "${PROCESS} is already closed"
    fi
fi
