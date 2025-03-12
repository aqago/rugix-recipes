#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

export RUGIX_SYSTEM_BUILD_INFO="$SCRIPT_DIR/_tests/system-build-info.json"
export RUGIX_CTRL="$SCRIPT_DIR/_tests/rugix-ctrl.sh"
export AQAGO_AGENT="$SCRIPT_DIR/_tests/aqago-agent.sh"

./files/system-ota-manager-rugix update-now