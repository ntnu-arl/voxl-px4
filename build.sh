#!/bin/bash

echo "*** Starting build ***"

source /home/build-env.sh

cd px4-firmware

echo "*** First describe ***"
git describe --always --tags --dirty
echo "*** First log ***"
git --no-pager log -n 4
echo "*** Grab all tags ***"
git fetch --all --tags
echo "*** Second describe ***"
git describe --always --tags --dirty
echo "*** Second log ***"
git --no-pager log -n 4
echo "*** End git diagnostics ***"

make modalai_rb5-flight_default
make modalai_rb5-flight_qurt

cat build/modalai_rb5-flight_default/src/lib/version/build_git_version.h

cd -

# Fix permissions of PX4 firmware .git entities
USER=$(stat -c '%u' .git/modules/px4-firmware)
echo "User ID is $USER"
chown -R $USER .git/modules/px4-firmware

GROUP=$(stat -c '%g' .git/modules/px4-firmware)
echo "Group ID is $GROUP"
chgrp -R $GROUP .git/modules/px4-firmware

echo "*** End of build ***"
