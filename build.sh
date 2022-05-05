#!/bin/bash

source /home/build-env.sh

cd px4-firmware

make modalai_rb5-flight_default
make modalai_rb5-flight_qurt

cat build/modalai_rb5-flight_default/src/lib/version/build_git_version.h

cd -
