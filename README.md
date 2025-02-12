# CBF Safety Filter

This fork contains the implementation of the embedded CBF safety filter for multirotors. We refer the user to the documentation in [the dedicated github](https://github.com/ntnu-arl/PX4-CBF), and leave the remainder of the voxl-px4 firmware README untouched.

# voxl-px4

High level PX4 wrapper project for CI and configuration with VOXL2 PX4 firmware as a
git submodule

## Prerequisites

This build requires the rb5-flight-px4-build-docker docker image. The docker image
contains the Hexagon SDK needed to build the SLPI DSP portion of the code base and
a Linaro ARM SDK to build the applications processor portion of the code base. The
Hexagon SDK software license does not allow redistribution of any kind so it has
to be downloaded by each user individually and then built into a Docker. The instructions
for this process are in the following link: https://gitlab.com/voxl-public/rb5-flight/rb5-flight-px4-build-docker

## Getting started

This project contains the VOXL2 px4-firmware as a submodule, which itself contains nested submodules. After cloning this project, all of these submodules need to be initialized. But before doing this make sure that
you are on the desired branch of voxl-px4. For example, to work with the dev branch use:

- ``` git clone git@gitlab.com:voxl-public/voxl-sdk/services/voxl-px4.git```
- ```cd voxl-px4```
- ```git checkout dev```
- ```git submodule update --init --recursive```

## Build instructions

Launch the build docker:

- ```./run-docker.sh```

In the docker:

- ```./clean.sh```
- ```./build.sh```

The build script builds both the applications processor code and the SLPI DSP code.
In order to just build for one of these processors the appropriate helper script
can be used instead.

- ```./build-apps.sh```
- ```./build-slpi.sh```

## Packaging

Once both of the application images have been successfully built and linked the
output can be packaged into a Debian package for easy distribution and installation.
Simply run the packaging script, but not in the Docker.

- ```./make_package.sh```

This will produce a Debian package in the top level directory.

## Deployment

There are a couple of different ways to deploy the code. Usually the Debian package
is installed on target. 

```
~/development/modalai/voxl-px4$ adb push voxl-px4_2.0.0_arm64.deb /home/root
~/development/modalai/voxl-px4$ adb shell
root@m0054:/# cd /home/root
root@m0054:/home/root# dpkg -i voxl-px4_2.0.0_arm64.deb 
(Reading database ... 79293 files and directories currently installed.)
Preparing to unpack voxl-px4_2.0.0_arm64.deb ...
Unpacking voxl-px4 (2.0.0) over (2.0.0) ...
Setting up voxl-px4 (2.0.0) ...
Created symlink /etc/systemd/system/multi-user.target.wants/voxl-px4.service → /etc/systemd/system/voxl-px4.service.
Found DSP signature file
```

Please note that when the Debian package is installed it will also enable
the system service to automatically start px4 on system boot up. To disable this use:

```
root@m0054:/home/root# systemctl disable voxl-px4
Removed /etc/systemd/system/multi-user.target.wants/voxl-px4.service.
root@m0054:/home/root# sync
```

For development purposes the Debian package deployment method can be cumbersome. For
that reason there is a simple helper script to simply push the needed files over to
the target from their build locations.

```
~/development/modalai/voxl-px4$ cd px4-firmware/
~/development/modalai/voxl-px4/px4-firmware$ boards/modalai/voxl2/scripts/install-voxl.sh 
build/modalai_voxl2-slpi_default/platforms/qurt/libpx4.so: 1 file pushed. 6.0 MB/s (4962824 bytes in 0.786s)
build/modalai_voxl2_default/bin/px4: 1 file pushed. 6.0 MB/s (18508376 bytes in 2.946s)
build/modalai_voxl2_default/bin/px4-alias.sh: 1 file pushed. 0.6 MB/s (1529 bytes in 0.002s)
boards/modalai/voxl2/target/voxl-px4: 1 file pushed. 0.9 MB/s (1958 bytes in 0.002s)
boards/modalai/voxl2/target/voxl-px4.config: 1 file pushed. 1.0 MB/s (3295 bytes in 0.003s)
boards/modalai/voxl2/target/voxl-px4-set-default-parameters.config: 1 file pushed. 1.0 MB/s (4556 bytes in 0.004s)
boards/modalai/voxl2/target/voxl-px4-fake-imu-calibration.config: 1 file pushed. 0.3 MB/s (851 bytes in 0.003s)
```

## Running PX4

Once VOXL2 PX4 has been installed on target it can be run. But before that there are
a few considerations to be taken care of.

### Starting point

It's best to start with the latest VOXL2 platform release. This will include
all of the required software to use VOXL2 PX4 most effectively. These platform
releases can be downloaded from the ModalAI developer website at https://developer.modalai.com

### SLPI DSP image

It's required to have at least version ```1.1.4``` of the SLPI DSP image running to support
PX4. When the platform release is installed it will place the SLPI DSP image version
in the file ```/dsp/sdsp/modalai_slpi_version.txt```. If a newer version of the SLPI DSP image
is subsequently installed via Debian package that file will be deleted and the proper
way to check for the version is to use ```apt```.

```
root@m0054:/# apt list | grep modalai-slpi

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

modalai-slpi/now 1.1-4 arm64 [installed,local]
```

Important note: It is required to power cycle VOXL2 after updating the SLPI DSP image
as it gets loaded during initial system boot up.

### Starting PX4

PX4 is usually started as a service using systemd. The Debian package will set this
up when it is installed. The service file is ```/etc/systemd/system/voxl-px4.service```.
This file can be modified to change the startup behavior of PX4.

The convenience script ```/usr/bin/voxl-px4``` is used to start PX4. There are a few
command line options that can be used to customize the launching of PX4. When launched
using systemd PX4 needs to be started as a daemon to run in the background. This is
done with the ```-d``` option of ```voxl-px4```.

PX4 can also be started directly from the command line with ```/usr/bin/voxl-px4```.
When started in this manner it is possible to interact directly with the PX4 shell.

### PX4 Parameters

PX4 must be setup and tuned for each drone. There are a large number of parameters
that control the operation of PX4. Default values of all parameters are built into
the PX4 application but all non-default values are stored in the file ```/data/px4/param/parameters```.
Unless that file exists from a previous installation it will be absent after installing
PX4 on target. When PX4 is launched the first time it will look for the parameters file.
If it does not exist it will create one using ```/etc/modalai/voxl-px4-set-default-parameters.config```.

### Startup script

The ```/usr/bin/voxl-px4``` script utilizes ```/etc/modalal/voxl-px4.config``` for
the startup process. This file contains the start commands for all desired PX4
drivers and modules. Just like ```/usr/bin/voxl-px4``` it is a shell script and
can be modified using standard bash script syntax.

### Checking PX4 version

The PX4 version can be queried in a number of ways. If PX4 is running on target then
adb can be used to get the PX4 version information directly from PX4.

```
~/development/modalai/voxl-px4/px4-firmware$ adb shell px4-ver all
INFO  [ver] HW arch: MODALAI_VOXL2
INFO  [ver] PX4 git-hash: 61d2aad536dd697c211defb9a612224992464651
INFO  [ver] PX4 version: 1.14.0 0 (17694720)
INFO  [ver] PX4 git-branch: voxl2_main_dev
INFO  [ver] Vendor version: 2.0.0 0 (33554432)
INFO  [ver] OS: Linux
INFO  [ver] OS version: Release 4.19.125 (68386303)
INFO  [ver] Build datetime: Jan 23 2023 23:59:12
INFO  [ver] Build uri: localhost
INFO  [ver] Build variant: default
INFO  [ver] Toolchain: GNU GCC, 7.5.0
INFO  [ver] PX4GUID: 100a41444f4d5649414c324c584f30303030
INFO  [ver] UNKNOWN MCU
```

PX4 and related application version information is provided by the ```px4-versions``` command.

```
~/development/modalai/voxl-px4/px4-firmware$ adb shell px4-versions
modalai-slpi/now 1.1-4 arm64 [installed,local]
px4-support/now 1.0-5 arm64 [installed,local]
python3-px4sitl/bionic,bionic 0.0.2-100 all
ros-crystal-px4-msgs/bionic 2.0.1-1bionic.20191028.195201 arm64
ros-crystal-px4-msgs-dbgsym/bionic 2.0.1-1bionic.20191028.195201 arm64
ros-dashing-px4-msgs/bionic 2.0.1-1bionic.20210226.173711 arm64
ros-dashing-px4-msgs-dbgsym/bionic 2.0.1-1bionic.20210226.173711 arm64
ros-eloquent-px4-msgs/bionic 2.0.1-1bionic.20201208.010429 arm64
ros-eloquent-px4-msgs-dbgsym/bionic 2.0.1-1bionic.20201208.010429 arm64
ros-melodic-px4-msgs/bionic 1.0.0-1bionic.20210505.094529 arm64
voxl-px4/now 2.0.0 arm64 [installed,local]
libfc-sensor/now 1.0-2 arm64 [installed,local]
1.4.1-M0054-14.1a-perf
```

Both methods produce useful version information that needs to be provided when
requesting support.
