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
ExecStep $xv_path/bin/xsim lab1_behav -key {Behavioral:sim_1:Functional:lab1} -tclbatch lab1.tcl -log simulate.log
