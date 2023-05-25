#!/bin/bash

echo "*** Starting flight core build ***"

FCV1_BUILD="ON"
FCV2_BUILD="ON"
FCV2_BOOTLOADER_BUILD="ON"

while getopts "12b" flag
do
    case "${flag}" in
        # Use -a to force apps only build
        1) FCV2_BUILD="OFF"
           FCV2_BOOTLOADER_BUILD="OFF";;
        2) FCV1_BUILD="OFF"
           FCV2_BOOTLOADER_BUILD="OFF";;
        b) FCV1_BUILD="OFF"
           FCV2_BUILD="OFF";;
    esac
done

cd px4-firmware

if [ "$FCV1_BUILD" == "ON" ]; then
    echo "*** Starting fcv1 build ***"
    make modalai_fc-v1
    echo "*** End of fcv1 build ***"
fi

if [ "$FCV2_BOOTLOADER_BUILD" == "ON" ]; then
    echo "*** Starting fcv2 bootloader build ***"
    make modalai_fc-v2_bootloader
    echo "*** End of fcv2 bootloader build ***"
fi

if [ "$FCV2_BUILD" == "ON" ]; then
    echo "*** Starting fcv2 build ***"
    make modalai_fc-v2
    echo "*** End of fcv2 build ***"
fi

cd -

# Fix permissions of PX4 firmware .git entities
USER=$(stat -c '%u' .git/modules/px4-firmware)
echo "User ID is $USER"
chown -R $USER .git/modules/px4-firmware

GROUP=$(stat -c '%g' .git/modules/px4-firmware)
echo "Group ID is $GROUP"
chgrp -R $GROUP .git/modules/px4-firmware

echo "*** End of flight core build ***"
