#!/bin/bash

set -euo pipefail

case "${RUGIX_ARCH}" in
    "amd64")
        TARGET="x86_64-unknown-linux-musl"
        ;;
    "arm64")
        TARGET="aarch64-unknown-linux-musl"
        ;;
    *)
        echo "Unsupported architecture '${RUGIX_ARCH}'."
        exit 1
esac

BASE_URL="https://aqago-agent-and-cli-binaries.s3.us-east-1.amazonaws.com"

LATEST_VERSION=$(curl -sfS "$BASE_URL/latest")
echo "Latest Aqago Version: ${LATEST_VERSION}"

DOWNLOAD_URL="$BASE_URL/$LATEST_VERSION/$TARGET.tar.gz"
echo "downloading Aqago agent from '$DOWNLOAD_URL'"
curl -sfS "$DOWNLOAD_URL" | tar -zxvf - -C /usr/bin aqago-agent
chmod +x /usr/bin/aqago-agent

echo "config/aqago-agent.toml" >> "${LAYER_REBUILD_IF_CHANGED}"
install -D -m 644 "${RUGIX_PROJECT_DIR}/config/aqago-agent.toml" -t /etc/aqago
mv /etc/aqago/aqago-agent.toml /etc/aqago/agent.toml

install -D -m 644 "${RECIPE_DIR}/files/aqago-agent.service" -t /lib/systemd/system
systemctl enable aqago-agent

install -D -m 644 "${RECIPE_DIR}/files/persist-aqago.toml" -t /etc/rugix/state

install -D -m 755 "${RECIPE_DIR}/files/aqago-os-id" -t /usr/bin
