# Release procedure

- On voxl-dev branch in submodule px4-firmware
- Commit and push everything
- tag it and push tag
  - Tag format: vX.Y.Z-X.Y.Z-<type>
    - First X.Y.Z is for PX4 version number
    - Second X.Y.Z is for our ModalAI vendor version number
    - Type: dev, alpha<number>, beta<number>, rc<number>

- On dev branch
- Add release notes to this document
- Add release notes to the CHANGELOG
- Bump package version number in debian/control
- ./clean.sh (in Docker)
- ./build.sh (in Docker)
- ./make_package.sh
- deploy / validate
- Commit and push everything
- Merge dev into master
- Add version tag
- Commit and push everything
- post package to cloud bucket

# Releases

## 1.14.0-2.0.53

- Add microdds_client for ROS2 support
- Remove bad characters from postinst causing installation errors
- Added new voxl-configure-px4 options
- Remove prepare-fc-image.sh, not needed anymore

## 1.14.0-2.0.52

- Add modal_io_bridge to postinst
- Add daemon restart attempt to postinst
- Compensate for queueing delays in GPS and RC input
- Add modal_io_bridge to allow raw UART commands to be passed to modal_io endpoints

## 1.14.0-2.0.51

- Reduce mavlink barometer updates from 20Hz to 10Hz
- Add onboard mavlink stream to HITL start file for MAVSDK interface

## 1.14.0-2.0.50

- Updated to 1.14.0-2.0.50 firmware
- Updated the voxl-configure-px4 script to reflect new options in the firmware

## 1.14.0-2.0.49

- Updated to 1.14.0-2.0.49 firmware
- Added new elrs_led driver to allow setting LED based on button presses coming from ground control station

## 1.14.0-2.0.48

- Updated to 1.14.0-2.0.48 firmware
- Updated the rate for onboard consumers of the SCALED_PRESSURE Mavlink message

## 1.14.0-2.0.47

- Updated to 1.14.0-2.0.47 firmware
- Added new configuration option for mRo GPS unit

## 1.14.0-2.0.46

- Updated to 1.14.0-2.0.46 firmware
- Added support for the Lightware SF000 distance laser sensor

## 1.14.0-2.0.45

- Updated to 1.14.0-2.0.45 firmware
- add MC_THR_CURVE_ACR to specify throttle curve behavior in Acro mode

## 1.14.0-2.0.44

- Updated to 1.14.0-2.0.44 firmware
- Add M0065 SBUS support with new dsp_sbus driver

## 1.14.0-2.0.43

- Updated to 1.14.0-2.0.43 firmware
- Add HITL
- Add param to control publishing of battery_status from mini esc
- Update logic to only process most recent update in manual_control module
- Add ist8308 magnetometer driver to SLPI build

## 1.14.0-2.0.42

- Updated to 1.14.0-2.0.41 firmware
- Changes default commander mode to manual

## 1.14.0-2.0.41

- Updated to 1.14.0-2.0.41 firmware
- Fixes SITL

## 1.14.0-2.0.40

- Updated to 1.14.0-2.0.40 firmware
- Added restart on fail to voxl-px4 service file

## 1.14.0-2.0.39

- Updated to 1.14.0-2.0.39 firmware
- Fixes to the GPS devices submodule to help with reliable M10 UBX startup

## 1.14.0-2.0.38

- Updated to 1.14.0-2.0.38 firmware
- Added parameters to control timeouts on external vision measurements

## 1.14.0-2.0.37

- Updated to 1.14.0-2.0.37 firmware
- Changed amps in voxlpm to signed int to account for reverse current

## 1.14.0-2.0.36

- Updated to 1.14.0-2.0.36 firmware
- Reverted: "Fixed offboard flight mode transition" because it didn't really work
- Added install dependency on rb5-system-image OR voxl2-system-image

## 1.14.0-2.0.35

- Updated to 1.14.0-2.0.35 firmware
- Fixed offboard flight mode transition

## 1.14.0-2.0.34

- Updated to 1.14.0-2.0.34 firmware
- Fixed delayed flight mode transitions in outgoing mavlink heartbeat messages

## 1.14.0-2.0.33

- Updated to 1.14.0-2.0.33 firmware
- Disabled arming check for missing Open Drone ID by default
- Fixed GPS UTC time reporting from DSP based GPS driver

## 1.14.0-2.0.32

- Updated to 1.14.0-2.0.32 firmware
- Added arming check for missing Open Drone ID

## 1.14.0-2.0.31

- Updated to 1.14.0-2.0.31 firmware
- Merged in fcv2 board specific changes and modalai systemcmd
- Added scripts to build fcv1, fcv2 and fcv2_bootloader

## 1.14.0-2.0.30

- Updated to 1.14.0-2.0.30 firmware
- Added ability to build fcv2 and fcv2_bootloader

## 1.14.0-2.0.29

- Updated to 1.14.0-2.0.29 firmware
- Implemented a scheme to save calibration parameters to separate named files for backup

## 1.14.0-2.0.28

- Updated to 1.14.0-2.0.28 firmware
- Change default for SENS_MAG_AUTOROT and SENS_MAG_AUTOCAL to be disabled

## 1.14.0-2.0.27

- Updated to 1.14.0-2.0.27 firmware
- Change default for SENS_IMU_AUTOCAL to be disabled
- Removed IMU rotation as a configuration item during startup. It is set by
  determining board type and by SENS_BOARD_ROT parameter now

## 1.14.0-2.0.26

- Updated to 1.14.0-2.0.26 firmware
- voxlpm doesn't send any battery status reports unless device probe succeeds
- modal_io battery status moved to Battery class
- modal_io battery reports throttled to 100ms interval

## 1.14.0-2.0.25

- Updated to 1.14.0-2.0.25 firmware
- Add support for RB5 IMU server
- Add support for RB5 GPS / RC

## 1.14.0-2.0.24

- Updated to 1.14.0-2.0.24 firmware
- Updated to PX4 mainline as of May 1
- Modal IO added support for M0129 battery status
- Added MODALAI_CONFIG param to isolate non-mainline features

## 1.14.0-2.0.22

- Updated to 1.14.0-2.0.22 firmware
- Remove hardcoded GPS UART baudrate
- Flight mode manager module moved to SLPI side
- Fixes for remote topic subscription process
- Added a second Mavlink instance to differentiate QGC and onboard traffic

## 1.14.0-2.0.20

- Updated to 1.14.0-2.0.20 firmware
- Changed package numbering to match px4 firmware version

## 1.14.0-2.0.19

- Changed the startup scripts. voxl-px4 now uses /usr/bin/voxl-px4-start instead
  of /etc/modalai/voxl-px4.config. There is also support for an optional configuration
  file that can be created by scripts/voxl-configure-px4

## 1.14.0-2.0.18

- Updated to latest PX4 mainline
- Revert "Hacks to allow thermal optical flow to work"
- Enabled a fourth i2c bus for the spare i2c port on VOXL2

## 1.14.0-2.0.17

- Merged in hacks for thermal optic flow operation

## 1.14.0-2.0.16

- Added support for ublox MAX-M10S GPS receiver

## 1.14.0-2.0.15

- Moved CRSF default baudrate back to 420000
- Updated logged topics to include all optical flow topics at full rate
- Updated time to consider range data recent in optical flow to account for slower update rate

## 1.14.0-2.0.14

- Added radio status publication to mavlink rc driver

## 1.14.0-2.0.13

- Fix for mag calibration crash. malloc and free were not implemented on Qurt!
- Optic flow fixes
- Position hold state initialization fix (NAN issue)

## 1.14.0-2.0.12

- Updated px4 to latest mainline
- Moved from custom CRSF driver to standard PX4 CRSF driver
- Fixed calibration failures with commander running on DSP
- Added multicopter autotune updates to allow choice of axes

## 1.14.0-2.0.11

- Add voxl-configure-px4
- Firmware is still v2.0.10!!!

## 1.14.0-2.0.10

- Fixes for the Qurt spektrum RC driver

## 1.14.0-2.0.9

- Moved commander module to the DSP side to avoid erroneous timeouts and failsafes on RC control
- Moved rc_input back to SLPI side since we have increased the amount of available memory
- Added ESC verbose logging and always send esc_status message
- Fixed missing parts of QGC actuator tab support
- Fixed argument handling for px4 tasks in Qurt

## 1.14.0-2.0.8

- Moved rc_input back to apps side. SLPI side is out of memory!

## 1.14.0-2.0.7

- Merged in latest PX4 mainline changes
- Moved rc_input, manual_control, and control_allocator modules from apps side to slpi side

## 1.14.0-2.0.6

- Add component metadata file to installation to enable actuators tab in QGC

## 1.14.0-2.0.5

- Updated sleep in service file to prevent segfault on startup
- Fixed some benign error conditions causing distracting reports
- Merged in latest PX4 mainline changes

## 1.14.0-2.0.4

- Added Spektrum RC driver
- Changed voxl-px4 options so that GPS has to be specified

## 1.14.0-2.0.3

- Fixed a couple of benign error conditions
- Added GPS driver
- Added transport of raw info logs from SLPI to apps for display

## 1.14.0-2.0.2

- Added in Daniel Mellinger's system id changes

## 1.14.0-2.0.1

- Merged in latest mainline from PX4
    - This changes modalai_esc to modal_io (All parameter names change)
- Enabled magnetometer drivers

## 1.14.0-2.0.0

- First version that uses mainline PX4 code

## 1.14.0-2.0.0

- First version that uses mainline PX4 code

## 1.12.24beta

- Add system ID feature

## 1.12.33beta

- Add generic uORB topic aggregator to SLPI to apps link
- Change IMU to 8 kHz ODR and 800 Hz sample rate

## 1.12.32beta

- Improvements to PWM calibration and PWM parameter settings

## 1.12.31beta

- Add raw CRSF capability to TBS Crossfire driver for ExpressLRS support

## 1.12.30beta

- Open DroneID initial support

## 1.12.29beta

- ModalAI ESC MR1 backport from px4:main (Enhanced ESC logging)

## 1.12.28beta

- update version from 1.4* to 1.12* to match PX4 version
- Turtle mode support in ModalAI ESC driver
- Enhanced ESC feedback logging for ModalAI ESC driver

## 1.4.27beta

- Initial PX4 remote id support integrated
- Here3 GPS unit integration

## 1.4.26beta

- Changes to pwm system command to support PWM ESC calibration

## 1.4.25beta

- Skip parameters that change every flight in hash calculation

## 1.4.24beta

- Added new TBS Crossfire configuration option for mavlink

## 1.4.23beta

- Added new flight mode ManualAltitudeCommandVel

## 1.4.22beta

- Added support for MSP OSD protocol to support DJI goggles on M0054 only

## 1.4.21beta

- Added support for mavlink telemetry using TBS Crossfire nano rx receivers
- Fixed execute privilege on voxl-px4-hitl script
- Added startup option to rotate IMU by yaw 180

## 1.4.20beta

- Added support for PWM outputs on M0054 using the external M0065 (PX4IO) module

## 1.4.19beta

- Removed debug statement in IMU driver that had a bug in it that caused a crash

## 1.4.18beta

- Fixed flaky UART performance with M0065 (aka px4io) on apps proc for M0052

## 1.4.17beta

- Fixed multiple bugs and tuned M0065 (px4io) for both M0052 and M0054
- Added mixer support for M0065 (px4io) to enable PWM outputs

## 1.4.16alpha

- Added support for qmc5883l magnetometer in Matek Sys M8Q-5883 module
- Added auto baud rate support in GPS to UBX on Qurt (Matek)
- Added support for TBS Crossfire receivers on VOXL 2 (RC only, no telemetry)
- Updated support for M0065 (aka px4io) on M0054
- Added decreased timeout for vision system odometry loss

## 1.4.15beta

- Release is now considered beta
- Added optional GPS start line in config file for use with Matek Systems M8Q-5883 module
- Remove hard coded baudrate for qurt in gps module and use configured rate instead
- Added initial support for M0065 IO expander (px4io) on VOXL 2
- Moved logger start after param load to make sure any parameters that control logging are loaded
- Changed px4io baud rate to 921600 for RB5
- Added new GPS timer module to set system time based on GPS time
- Renaming some scripts to match voxl naming standards
- Move parameters and logs to /data partition which is preserved across system image updates

## 1.4.14alpha

- HITL now supports both VIO and GPS modes.
- HITL now integrated with voxl-vision-px4 and voxl-mavlink-server
- Renaming some scripts to match voxl naming standards
- Move parameters and logs to /data partition which is preserved across system image updates

## 1.4.13alpha

- N/A

## 1.4.12alpha

- Added support for HITL using the Gazebo simulator

## 1.4.11alpha

- Changed Mavlink configuration method. All communication now goes through voxl-mavlink-server and voxl-vision-px4

## 1.4.10alpha

- Fixed bug in barometer temperature calculation. Register value is unsigned, not signed!

## 1.4.9alpha

- Some minor DSP test signature related changes

## 1.4.8alpha

- Added voxl-px4.service to autostart px4
- Added call to generate a SLPI DSP test signature in postinst
- Added a check in the voxl.config startup script to make sure test signature is available
- Consolidating m0052 / m0054 into single voxl structure with automatic platform configuration

## 1.4.7alpha

- Decreased the polling rate of UART drivers running on Qurt to avoid starving the OS services
- Improve comms error counting in icp10100 barometer driver
- Added a set command to the rgbled_ncp5623c driver
- Added a performance counter to rgbled_ncp5623c to count bad i2c transfers
- Changed qshell on apps side to return the value received from the DSP instead of 0

## 1.4.6alpha

- Fixed typo in qgc-ip.cfg

## 1.4.5alpha

- Fixed default value of MPC_THR_HOVER to 0.42
- Removed the -e logger option from m0054
- Added ability to configure QGC port number

## 1.4.4alpha

- Improved the bad packet detection in the Spektrum RC driver

## 1.4.3alpha

- Moved logger start to beginning of sequence to capture driver and module startup messages
- Fixed the QGC address script to allow blank lines

## 1.4.2alpha

- Fixed some Voxl2 startup script errors

## 1.4.1alpha

- Fixed packaging and installed scripts for Voxl2

## 1.4.0alpha

- Updated Spektrum RC and GPS drivers to work on QURT to support Voxl2

## 1.1.9alpha

- Updated barometer driver calculations to exactly match original TDK driver for icp10100

## 1.1.8alpha

- Added more default parameters. They are set up for indoor flights
- Removed hard-coded baud rate configuration of the gps. It will now auto-detect the rate.
- Enabled the LED on the GPS unit
- Added a new feature to allow choice of QGC IP address via configuration file
- Auto detect presence of M0065 (PX4IO). Start px4io if detected, spektrum rc driver otherwise

## 1.1.7alpha

- Completed the mechanism to allow sending debug messages from SLPI to Apps for logging

## 1.1.6alpha

- Added a mechanism to allow sending debug messages from SLPI to Apps for logging

## 1.1.5alpha

- Fixed casting error for icp10100 barometer otp data
- Create log file names without the time in the name unless we have GPS time
- Fixed BAT default parameter setting to use BAT instead of BAT1

## 1.1.4alpha

- Added default battery parameter settings to m0052-set-default-parameters.config
- Clean up I2C and SPI device id creation to zero out unused bits

## 1.1.3alpha

- Modified icm42688p driver such that flight control gets 500Hz IMU samples and
  VIO (via imu_server) gets 1kHz samples in a batch of 10 every 100ms.
- icm42688p driver is now configured for anti-alias and UI filtering

## 1.1.2alpha

- Moved from TDK icp10100 barometer driver to new px4 icp10100 barometer driver.

## 1.1.1alpha

- Changed IMU server from using raw sensor data to using calibrated / filtered sensor data

## 1.1.0alpha

- Moved from Invensense IMU driver to PX4 IMU driver
- Bumped minor revision number since the IMU change is quite significant

## 1.0.20alpha

- Added pwm_out_sim driver to qurt build to support HIL testing
- Add rc_update start back into startup configuration

## 1.0.19alpha

- Added fsync on log file close

## 1.0.18alpha

- Spektrum RC driver throws out first packet if it is too small. Prevents
  the loss of RC when the occasional first packet is a "runt" and corrupts DSM parser.

## 1.0.17alpha

- Removed the -e option from logger start
- Upped default MAX RPM to 10500
- Moved sensor driver start before the modules that rely on them to prevent timeouts

## 1.0.16alpha

- Add imu_server start to default configuration

## 1.0.15alpha

- Added method to update the time offset on SLPI
- Changed motor mappings to match default for seeker drone
- Changed RC parameters to no longer assume joystick

## 1.0.14alpha

- Added module starts for the flight_mode_manager and mc_hover_thrust_estimator

## 1.0.13alpha

- Added mc_hover_thrust_estimator module into qurt build

## 1.0.12alpha

- Set COM_ARM_WO_GPS to 0 to prevent QGC showing GPS as disabled
- Added flight_mode_manager module into apps (default) build

## 1.0.11alpha

- Touch SYS_AUTOCONFIG to make QGC missing parameter error message go away
- Remove annoying preflight fail debug messages
- Remove IMU server high frequency debug messages

## 1.0.10alpha

- Fixed orientation of magnetometer
- Added an IMU server for integration with VIO. It isn't started by default.
- Changed the way that parameters are loaded so that any changes won't get overwritten on the next reboot
- Moved some of the drone specific scripts and startup service files out of this project

## 1.0.9alpha

- Changed voxlpm to only support AN231 on Qurt PX4 to avoid the issues with slave address reconfiguration

## 1.0.8dev

- Do not hardcode Qurt I2C devices to be "internal". Experimental.

## 1.0.7alpha

- Added verbose mode to Spektrum RC driver
- Fixed serial port numbers for GPS and Spektrum RC

## 1.0.6alpha

- Added support for Spektrum RC

## 1.0.5alpha

- Support for new 9.1 based SLPI release

## 1.0.4alpha

- First functional release
