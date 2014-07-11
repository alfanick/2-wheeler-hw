# The TARGET variable determines what target system the application is
# compiled for. It either refers to an XN file in the source directories
# or a valid argument for the --target option when compiling
TARGET = STARTKIT

# The APP_NAME variable determines the name of the final .xe file. It should
# not include the .xe postfix. If left blank the name will default to
# the project name
APP_NAME = app_balancer

# The USED_MODULES variable lists other module used by the application.
USED_MODULES = module_logging module_distance_sensor module_lsm303d module_i2c_master module_startkit_adc module_motor_pair module_uart_fast_tx module_uart_fast_rx module_bluetooth module_config

# The flags passed to xcc when building the application
# You can also set the following to override flags for a particular language:
# XCC_XC_FLAGS, XCC_C_FLAGS, XCC_ASM_FLAGS, XCC_CPP_FLAGS
# If the variable XCC_MAP_FLAGS is set it overrides the flags passed to
# xcc for the final link (mapping) stage.
XCC_FLAGS_Debug   ?= -O0 -report -g -fxscope -lflash
XCC_FLAGS_Release ?= -O3 -report -g -fxscope -lflash

# The VERBOSE variable, if set to 1, enables verbose output from the make system.
VERBOSE = 0

XMOS_MAKE_PATH ?= ../..
-include $(XMOS_MAKE_PATH)/xcommon/module_xcommon/build/Makefile.common

APP_VERSION = $(shell git rev-parse --short HEAD)

flash_flags:
	$(eval XCC_FLAGS_Debug := -O3 -report -DAPP_VERSION=\"$(APP_VERSION)\" -lflash)
	$(eval XCC_FLAGS_Release := -O3 -report -DAPP_VERSION=\"$(APP_VERSION)\" -lflash)

connect:
	@picocom -b 9600 -fn -pn -d8 -c -i -r -l --imap crcrlf --omap lfcr -e c /dev/tty.TwoWheeler-SPP

run: clean all
	@xrun --verbose --io --xscope bin/Release/$(APP_NAME).xe

runonce: clean all
	@xrun --verbose bin/Release/$(APP_NAME).xe

flash: flash_flags clean
	@xmake all
	@xflash --boot-partition-size 65536 bin/Release/$(APP_NAME).xe
	@xmake clean > /dev/null
