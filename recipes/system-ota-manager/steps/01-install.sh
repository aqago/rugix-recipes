#!/bin/bash

set -euo pipefail

install -D -m 755 "${RECIPE_DIR}/files/system-ota-manager-rugix" -t /usr/bin
install -D -m 644 "${RECIPE_DIR}/files/system-ota-manager-rugix.service" -t /lib/systemd/system
install -D -m 644 "${RECIPE_DIR}/files/system-ota-manager-rugix.timer" -t /lib/systemd/system

systemctl enable system-ota-manager-rugix.timer