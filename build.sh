#!/bin/bash

echo "*** Starting build ***"

source /home/build-env.sh

cd px4-firmware

echo "*** Starting apps processor build ***"

make modalai_voxl2

cat build/modalai_voxl2_default/src/lib/version/build_git_version.h

echo "*** End of apps processor build ***"

echo "*** Starting qurt slpi build ***"

make modalai_voxl2-slpi

cat build/modalai_voxl2-slpi_default/src/lib/version/build_git_version.h

echo "*** End of qurt slpi build ***"

cd -

# Fix permissions of PX4 firmware .git entities
USER=$(stat -c '%u' .git/modules/px4-firmware)
echo "User ID is $USER"
chown -R $USER .git/modules/px4-firmware

GROUP=$(stat -c '%g' .git/modules/px4-firmware)
echo "Group ID is $GROUP"
chgrp -R $GROUP .git/modules/px4-firmware

echo "*** End of build ***"
