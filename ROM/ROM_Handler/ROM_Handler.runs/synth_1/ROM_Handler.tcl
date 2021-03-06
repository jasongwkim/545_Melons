# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/bradp/OneDrive/Documents/College/18-545/ROM_Handler/ROM_Handler.cache/wt [current_project]
set_property parent.project_path C:/Users/bradp/OneDrive/Documents/College/18-545/ROM_Handler/ROM_Handler.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib C:/Users/bradp/OneDrive/Documents/College/18-545/ROM_Handler/ROM_Handler.srcs/sources_1/new/ROM_Handler.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top ROM_Handler -part xc7a100tcsg324-1


write_checkpoint -force -noxdef ROM_Handler.dcp

catch { report_utilization -file ROM_Handler_utilization_synth.rpt -pb ROM_Handler_utilization_synth.pb }
