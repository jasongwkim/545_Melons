#!/bin/sh -f
xv_path="/afs/ece/support/xilinx/xilinx.release/Vivado"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 2707cc89a5184832af9afff666a7374f -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot lab1_behav xil_defaultlib.lab1 xil_defaultlib.glbl -log elaborate.log
