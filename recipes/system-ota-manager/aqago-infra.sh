#!/bin/bash

# Configure the cli with aqago-cli configure prior to running this script and
# replace the device id with an actual device id

DEVICE_ID="replace with device id"

aqago-cli applications create system-ota-manager-rugix --artifact rugix-system-bundle:latest
aqago-cli devices add-application $DEVICE_ID system-ota-manager-rugix