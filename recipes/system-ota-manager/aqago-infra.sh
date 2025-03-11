#!/bin/bash

# Configure the cli with aqago-cli configure prior to running this script and
# replace the device id with an actual device id

DEVICE_ID=$1

./aqago-cli applications create system-ota-manager-rugix\
    --artifact rugix-os-bundle:latest~efi-arm64\
    --artifact rugix-os-bundle:latest~efi-amd64\
    --artifact rugix-os-bundle:latest~pi4\
    --artifact rugix-os-bundle:latest~pi5\
    --configuration ./configuration/default.json\
    --configuration-schema ./configuration/schema.json

if [ $? -ne 0 ]; then
    echo "Failed to create application"
    exit 1
fi
if [ -z "$DEVICE_ID" ]; then
    exit 0
fi
./aqago-cli devices add-application $DEVICE_ID system-ota-manager-rugix
