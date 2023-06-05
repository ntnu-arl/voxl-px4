#!/bin/bash

################################################################################
# Copyright (c) 2023 ModalAI, Inc. All rights reserved.
#
# Script to add version number and timestamp to flight core px4 images for deployment
#
# author: eric.katzfey@modalai.com
################################################################################

set -e # exit on error to prevent bad image from being deployed

VERSION=$(cat pkg/control/control | grep "Version" | cut -d' ' -f 2)

dts=$(date +"%Y%m%d%H%M")
VERSION="${VERSION}_${dts}"
NEW_IMAGE_NAME=modalai_fc-v2_${VERSION}.px4
mv px4-firmware/build/modalai_fc-v2_default/modalai_fc-v2_default.px4 \
   px4-firmware/build/modalai_fc-v2_default/${NEW_IMAGE_NAME}

echo "DONE"
