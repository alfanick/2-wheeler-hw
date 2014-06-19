#!/bin/bash
export XMOS_TOOL_PATH=/Applications/XMOS_xTIMEcomposer_Community_13.1.0;
export installpath=$XMOS_TOOL_PATH # Deprecated, please use XMOS_TOOL_PATH
export XMOS_HOME=$HOME/.xmos
export PATH=$XMOS_TOOL_PATH/bin:$XMOS_TOOL_PATH/xtimecomposer_bin/xtimecomposer.app/Contents/MacOS:$XMOS_TOOL_PATH/arm_toolchain/bin:$PATH;
export LD_LIBRARY_PATH=$XMOS_TOOL_PATH/lib:$LD_LIBRARY_PATH;
export DYLD_LIBRARY_PATH=$XMOS_TOOL_PATH/lib:$DYLD_LIBRARY_PATH;
export XCC_C_INCLUDE_PATH=$XMOS_TOOL_PATH/target/include:$XMOS_TOOL_PATH/target/include/gcc
export XCC_XC_INCLUDE_PATH=$XMOS_TOOL_PATH/target/include/xc:$XCC_C_INCLUDE_PATH
export XCC_CPLUS_INCLUDE_PATH=$XCC_C_INCLUDE_PATH:$XMOS_TOOL_PATH/target/include/c++/4.2.1
export XCC_CPLUS_INCLUDE_PATH=$XCC_CPLUS_INCLUDE_PATH:$XMOS_TOOL_PATH/target/include/c++/4.2.1/xcore-xmos-elf
export XCC_ASSEMBLER_INCLUDE_PATH=$XCC_C_INCLUDE_PATH
export XCC_LIBRARY_PATH=$XMOS_TOOL_PATH/target/lib
export XCC_DEVICE_PATH=$XMOS_TOOL_PATH/configs:$XMOS_TOOL_PATH/configs/.deprecated
export XCC_TARGET_PATH=$XMOS_HOME/targets:$XMOS_TOOL_PATH/targets:$XMOS_TOOL_PATH/targets/.deprecated
export XCC_EXEC_PREFIX=$XMOS_TOOL_PATH/libexec/
export XMOS_DOC_PATH=$XMOS_TOOL_PATH/doc
export PYTHON_HOME="$XMOS_TOOL_PATH/lib/jython"
export PYTHON_VERBOSE="warning"
export XMOS_CACHE_PATH=$XMOS_HOME/cache
export XMOS_REPO_PATH=$XMOS_HOME/repos
export XMOS_MAKE_PATH=${XMOS_TOOL_PATH// /\\ }/build
export XCC_EFM32GG_C_INCLUDE_PATH=$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/emlib/inc:$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/Device/EnergyMicro/EFM32GG/Include/:$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/CMSIS/Include/
export XCC_EFM32GG_XC_INCLUDE_PATH=$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/emlib/inc:$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/Device/EnergyMicro/EFM32GG/Include/:$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/CMSIS/Include/
export XCC_EFM32GG_CPLUS_INCLUDE_PATH=$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/emlib/inc:$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/Device/EnergyMicro/EFM32GG/Include/:$XMOS_TOOL_PATH/arm_toolchain/arm-none-eabi/opt/CMSIS/Include/

