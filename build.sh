#!/bin/bash

echo "*** Starting build ***"

source /home/build-env.sh

APPS_BUILD="ON"
SLPI_BUILD="ON"

while getopts "as" flag
do
    case "${flag}" in
        # Use -a to force apps only build
        a) SLPI_BUILD="OFF";;
        # Use -s to force SLPI only build
        s) APPS_BUILD="OFF";;
    esac
done

cd px4-firmware

if [ "$APPS_BUILD" == "ON" ]; then
    echo "*** Starting apps processor build ***"
    make modalai_voxl2
    cat build/modalai_voxl2_default/src/lib/version/build_git_version.h
    echo "*** End of apps processor build ***"
fi

if [ "$SLPI_BUILD" == "ON" ]; then
    echo "*** Starting qurt slpi build ***"
    make modalai_voxl2-slpi
    echo "*** End of qurt slpi build ***"
fi

cd -

# Fix permissions of PX4 firmware .git entities
USER=$(stat -c '%u' .git/modules/px4-firmware)
echo "User ID is $USER"
chown -R $USER .git/modules/px4-firmware

GROUP=$(stat -c '%g' .git/modules/px4-firmware)
echo "Group ID is $GROUP"
chgrp -R $GROUP .git/modules/px4-firmware

echo "*** End of build ***"
