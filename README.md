# voxl-px4

High level PX4 wrapper project for CI and configuration with PX4 firmware as a submodule

## Prerequisites

This build requires the rb5-flight-px4-build-docker docker image

## Getting started

This project contains the px4-firmware as a submodule, which itself contains nested submodules. After cloning this project, all of these submodules need to be initialized.

- ```git submodule update --init --recursive```

## Build instructions

Launch the build docker:

- ```./run-docker.sh```

In the docker:

- ```./clean.sh```
- ```./build.sh```
