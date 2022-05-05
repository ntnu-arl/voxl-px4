#!/bin/bash

echo "*** Starting build ***"

source /home/build-env.sh

cd px4-firmware

echo "*** First describe ***"
git describe --always --tags --dirty
echo "*** First log ***"
git --no-pager log -n 5
echo "*** pull ***"
git pull
echo "*** Second describe ***"
git describe --always --tags --dirty
echo "*** Second log ***"
git --no-pager log -n 5
echo "*** End git diagnostics ***"

make modalai_rb5-flight_default
make modalai_rb5-flight_qurt

cat build/modalai_rb5-flight_default/src/lib/version/build_git_version.h

cd -

echo "*** End of build ***"
