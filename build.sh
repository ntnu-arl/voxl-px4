#!/bin/bash

source /home/build-env.sh

cd px4-firmware

make modalai_rb5-flight_default
make modalai_rb5-flight_qurt

cd -
