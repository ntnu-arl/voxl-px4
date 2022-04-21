#!/bin/bash

# Clean out the build artifacts
source /home/build-env.sh
cd px4-firmware
make clean
cd -

# Clean out all of the packaging artifacts
sudo rm -rf pkg/control.tar.gz
sudo rm -rf pkg/data/
sudo rm -rf pkg/data.tar.gz
sudo rm -rf pkg/DEB/
sudo rm -rf pkg/IPK/
sudo rm -rf *.ipk
sudo rm -rf *.deb

# Miscellaneous artifacts
sudo rm -rf .bash_history
