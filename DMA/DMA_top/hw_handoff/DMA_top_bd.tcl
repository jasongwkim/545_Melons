
################################################################
# This is a generated script based on design: DMA_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source DMA_top_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# DMA_wrapper

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
set design_name DMA_top

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  set str_bd_folder C:/Users/bradp/OneDrive/Documents/GitHub/545_Melons/DMA
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set M68_addr [ create_bd_port -dir I -from 31 -to 0 M68_addr ]
  set M68_as [ create_bd_port -dir I M68_as ]
  set M68_data_in [ create_bd_port -dir O -from 15 -to 0 M68_data_in ]
  set M68_data_out [ create_bd_port -dir I -from 15 -to 0 M68_data_out ]
  set M68_dtack [ create_bd_port -dir O M68_dtack ]
  set M68_lds [ create_bd_port -dir I M68_lds ]
  set M68_rw [ create_bd_port -dir I M68_rw ]
  set M68_uds [ create_bd_port -dir I M68_uds ]
  set VDP_control [ create_bd_port -dir O -from 7 -to 0 VDP_control ]
  set VDP_control_rw [ create_bd_port -dir O VDP_control_rw ]
  set VDP_data [ create_bd_port -dir O -from 7 -to 0 VDP_data ]
  set VDP_data_rw [ create_bd_port -dir O VDP_data_rw ]
  set Z80_addr [ create_bd_port -dir I -from 15 -to 0 Z80_addr ]
  set Z80_busack [ create_bd_port -dir O Z80_busack ]
  set Z80_data [ create_bd_port -dir IO -from 7 -to 0 Z80_data ]
  set Z80_mreq [ create_bd_port -dir I Z80_mreq ]
  set Z80_rd [ create_bd_port -dir I Z80_rd ]
  set Z80_wr [ create_bd_port -dir I Z80_wr ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
 ] $clk
  set rst_n [ create_bd_port -dir I -type rst rst_n ]

  # Create instance: DMA_wrapper_0, and set properties
  set block_name DMA_wrapper
  set block_cell_name DMA_wrapper_0
  if { [catch {set DMA_wrapper_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $DMA_wrapper_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Read_Width_A {16} \
CONFIG.Read_Width_B {16} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {true} \
CONFIG.Write_Depth_A {4096} \
CONFIG.Write_Width_A {16} \
CONFIG.Write_Width_B {16} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_1 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Read_Width_A {8} \
CONFIG.Read_Width_B {8} \
CONFIG.Register_PortA_Output_of_Memory_Core {false} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {true} \
CONFIG.Write_Depth_A {1024} \
CONFIG.Write_Width_A {8} \
CONFIG.Write_Width_B {8} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_1

  # Create port connections
  connect_bd_net -net DMA_wrapper_0_M68_data_in [get_bd_ports M68_data_in] [get_bd_pins DMA_wrapper_0/M68_data_in]
  connect_bd_net -net DMA_wrapper_0_M68_dtack [get_bd_ports M68_dtack] [get_bd_pins DMA_wrapper_0/M68_dtack]
  connect_bd_net -net DMA_wrapper_0_RAM_16_addr [get_bd_pins DMA_wrapper_0/RAM_16_addr] [get_bd_pins blk_mem_gen_0/addra]
  connect_bd_net -net DMA_wrapper_0_RAM_16_data_in [get_bd_pins DMA_wrapper_0/RAM_16_data_in] [get_bd_pins blk_mem_gen_0/dina]
  connect_bd_net -net DMA_wrapper_0_RAM_16_en [get_bd_pins DMA_wrapper_0/RAM_16_en] [get_bd_pins blk_mem_gen_0/ena]
  connect_bd_net -net DMA_wrapper_0_RAM_16_we [get_bd_pins DMA_wrapper_0/RAM_16_we] [get_bd_pins blk_mem_gen_0/wea]
  connect_bd_net -net DMA_wrapper_0_RAM_8_addr [get_bd_pins DMA_wrapper_0/RAM_8_addr] [get_bd_pins blk_mem_gen_1/addra]
  connect_bd_net -net DMA_wrapper_0_RAM_8_data_in [get_bd_pins DMA_wrapper_0/RAM_8_data_in] [get_bd_pins blk_mem_gen_1/dina]
  connect_bd_net -net DMA_wrapper_0_RAM_8_en [get_bd_pins DMA_wrapper_0/RAM_8_en] [get_bd_pins blk_mem_gen_1/ena]
  connect_bd_net -net DMA_wrapper_0_RAM_8_we [get_bd_pins DMA_wrapper_0/RAM_8_we] [get_bd_pins blk_mem_gen_1/wea]
  connect_bd_net -net DMA_wrapper_0_VDP_control [get_bd_ports VDP_control] [get_bd_pins DMA_wrapper_0/VDP_control]
  connect_bd_net -net DMA_wrapper_0_VDP_control_rw [get_bd_ports VDP_control_rw] [get_bd_pins DMA_wrapper_0/VDP_control_rw]
  connect_bd_net -net DMA_wrapper_0_VDP_data [get_bd_ports VDP_data] [get_bd_pins DMA_wrapper_0/VDP_data]
  connect_bd_net -net DMA_wrapper_0_VDP_data_rw [get_bd_ports VDP_data_rw] [get_bd_pins DMA_wrapper_0/VDP_data_rw]
  connect_bd_net -net DMA_wrapper_0_Z80_busack [get_bd_ports Z80_busack] [get_bd_pins DMA_wrapper_0/Z80_busack]
  connect_bd_net -net M68_addr_1 [get_bd_ports M68_addr] [get_bd_pins DMA_wrapper_0/M68_addr]
  connect_bd_net -net M68_as_1 [get_bd_ports M68_as] [get_bd_pins DMA_wrapper_0/M68_as]
  connect_bd_net -net M68_data_out_1 [get_bd_ports M68_data_out] [get_bd_pins DMA_wrapper_0/M68_data_out]
  connect_bd_net -net M68_lds_1 [get_bd_ports M68_lds] [get_bd_pins DMA_wrapper_0/M68_lds]
  connect_bd_net -net M68_rw_1 [get_bd_ports M68_rw] [get_bd_pins DMA_wrapper_0/M68_rw]
  connect_bd_net -net M68_uds_1 [get_bd_ports M68_uds] [get_bd_pins DMA_wrapper_0/M68_uds]
  connect_bd_net -net Net [get_bd_ports Z80_data] [get_bd_pins DMA_wrapper_0/Z80_data]
  connect_bd_net -net Z80_addr_1 [get_bd_ports Z80_addr] [get_bd_pins DMA_wrapper_0/Z80_addr]
  connect_bd_net -net Z80_mreq_1 [get_bd_ports Z80_mreq] [get_bd_pins DMA_wrapper_0/Z80_mreq]
  connect_bd_net -net Z80_rd_1 [get_bd_ports Z80_rd] [get_bd_pins DMA_wrapper_0/Z80_rd]
  connect_bd_net -net Z80_wr_1 [get_bd_ports Z80_wr] [get_bd_pins DMA_wrapper_0/Z80_wr]
  connect_bd_net -net blk_mem_gen_0_douta [get_bd_pins DMA_wrapper_0/RAM_16_data_out] [get_bd_pins blk_mem_gen_0/douta]
  connect_bd_net -net blk_mem_gen_1_douta [get_bd_pins DMA_wrapper_0/RAM_8_data_out] [get_bd_pins blk_mem_gen_1/douta]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins DMA_wrapper_0/clk] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_1/clka]
  connect_bd_net -net rst_n_1 [get_bd_ports rst_n] [get_bd_pins DMA_wrapper_0/rst_n] [get_bd_pins blk_mem_gen_0/rsta] [get_bd_pins blk_mem_gen_1/rsta]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port Z80_busack -pg 1 -y 70 -defaultsOSRD
preplace port Z80_wr -pg 1 -y 130 -defaultsOSRD
preplace port M68_as -pg 1 -y 190 -defaultsOSRD
preplace port Z80_mreq -pg 1 -y 150 -defaultsOSRD
preplace port M68_dtack -pg 1 -y 50 -defaultsOSRD
preplace port M68_rw -pg 1 -y 170 -defaultsOSRD
preplace port VDP_control_rw -pg 1 -y 190 -defaultsOSRD
preplace port Z80_rd -pg 1 -y 110 -defaultsOSRD
preplace port M68_uds -pg 1 -y 230 -defaultsOSRD
preplace port M68_lds -pg 1 -y 210 -defaultsOSRD
preplace port clk -pg 1 -y -70 -defaultsOSRD
preplace port VDP_data_rw -pg 1 -y 170 -defaultsOSRD
preplace port rst_n -pg 1 -y -50 -defaultsOSRD
preplace portBus M68_addr -pg 1 -y 330 -defaultsOSRD
preplace portBus M68_data_out -pg 1 -y 310 -defaultsOSRD
preplace portBus VDP_data -pg 1 -y 230 -defaultsOSRD
preplace portBus Z80_data -pg 1 -y 350 -defaultsOSRD
preplace portBus M68_data_in -pg 1 -y 330 -defaultsOSRD
preplace portBus VDP_control -pg 1 -y 250 -defaultsOSRD
preplace portBus Z80_addr -pg 1 -y 290 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 1 -y 540 -defaultsOSRD
preplace inst blk_mem_gen_1 -pg 1 -lvl 1 -y 760 -defaultsOSRD
preplace inst DMA_wrapper_0 -pg 1 -lvl 1 -y 200 -defaultsOSRD
preplace netloc Z80_addr_1 1 0 1 N
preplace netloc blk_mem_gen_1_douta 1 0 1 70
preplace netloc DMA_wrapper_0_Z80_busack 1 1 1 N
preplace netloc DMA_wrapper_0_RAM_16_en 1 0 2 50 -50 790
preplace netloc Z80_mreq_1 1 0 1 N
preplace netloc DMA_wrapper_0_RAM_8_addr 1 0 2 90 400 750
preplace netloc M68_lds_1 1 0 1 N
preplace netloc DMA_wrapper_0_RAM_8_en 1 0 2 80 420 810
preplace netloc DMA_wrapper_0_RAM_16_addr 1 0 2 110 -10 780
preplace netloc DMA_wrapper_0_VDP_control_rw 1 1 1 N
preplace netloc Z80_rd_1 1 0 1 N
preplace netloc M68_data_out_1 1 0 1 N
preplace netloc rst_n_1 1 0 1 20
preplace netloc DMA_wrapper_0_VDP_data_rw 1 1 1 N
preplace netloc DMA_wrapper_0_VDP_control 1 1 1 N
preplace netloc M68_uds_1 1 0 1 N
preplace netloc DMA_wrapper_0_RAM_16_we 1 0 2 60 -40 800
preplace netloc DMA_wrapper_0_RAM_16_data_in 1 0 2 120 0 770
preplace netloc clk_1 1 0 1 30
preplace netloc DMA_wrapper_0_M68_data_in 1 1 1 N
preplace netloc M68_rw_1 1 0 1 N
preplace netloc DMA_wrapper_0_RAM_8_we 1 0 2 40 -20 750
preplace netloc blk_mem_gen_0_douta 1 0 1 130
preplace netloc DMA_wrapper_0_VDP_data 1 1 1 N
preplace netloc Net 1 1 1 N
preplace netloc M68_as_1 1 0 1 N
preplace netloc Z80_wr_1 1 0 1 N
preplace netloc DMA_wrapper_0_M68_dtack 1 1 1 N
preplace netloc M68_addr_1 1 0 1 N
preplace netloc DMA_wrapper_0_RAM_8_data_in 1 0 2 100 410 760
levelinfo -pg 1 0 570 900 -top -90 -bot 880
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


