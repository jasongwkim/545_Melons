
################################################################
# This is a generated script based on design: ROM_Handler_Top
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
# source ROM_Handler_Top_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ROM_Handler

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
set design_name ROM_Handler_Top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

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
  set addr [ create_bd_port -dir I -from 23 -to 0 -type data addr ]
  set as [ create_bd_port -dir I as ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set dtack [ create_bd_port -dir O dtack ]
  set rst_n [ create_bd_port -dir I rst_n ]

  # Create instance: ROM_Handler_0, and set properties
  set block_name ROM_Handler
  set block_cell_name ROM_Handler_0
  if { [catch {set ROM_Handler_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ROM_Handler_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Assume_Synchronous_Clk {true} \
CONFIG.Byte_Size {9} \
CONFIG.Coe_File {../../../../../../../Sonic the Hedgehog.bin.coe} \
CONFIG.Disable_Collision_Warnings {false} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Fill_Remaining_Memory_Locations {true} \
CONFIG.Load_Init_File {true} \
CONFIG.Memory_Type {Dual_Port_ROM} \
CONFIG.Port_A_Write_Rate {0} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Read_Width_A {8} \
CONFIG.Read_Width_B {8} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {true} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {true} \
CONFIG.Use_RSTB_Pin {true} \
CONFIG.Write_Depth_A {524288} \
CONFIG.Write_Width_A {8} \
CONFIG.Write_Width_B {8} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create port connections
  connect_bd_net -net ROM_Handler_0_ROM_addr_1 [get_bd_pins ROM_Handler_0/ROM_addr_1] [get_bd_pins blk_mem_gen_0/addra]
  connect_bd_net -net ROM_Handler_0_ROM_addr_2 [get_bd_pins ROM_Handler_0/ROM_addr_2] [get_bd_pins blk_mem_gen_0/addrb]
  connect_bd_net -net ROM_Handler_0_dtack [get_bd_ports dtack] [get_bd_pins ROM_Handler_0/dtack]
  connect_bd_net -net ROM_Handler_0_rd_en_1 [get_bd_pins ROM_Handler_0/rd_en_1] [get_bd_pins blk_mem_gen_0/ena]
  connect_bd_net -net ROM_Handler_0_rd_en_2 [get_bd_pins ROM_Handler_0/rd_en_2] [get_bd_pins blk_mem_gen_0/enb]
  connect_bd_net -net addr_1 [get_bd_ports addr] [get_bd_pins ROM_Handler_0/addr]
  connect_bd_net -net as_1 [get_bd_ports as] [get_bd_pins ROM_Handler_0/as]
  connect_bd_net -net blk_mem_gen_0_douta [get_bd_pins ROM_Handler_0/ROM_data_1] [get_bd_pins blk_mem_gen_0/douta]
  connect_bd_net -net blk_mem_gen_0_doutb [get_bd_pins ROM_Handler_0/ROM_data_2] [get_bd_pins blk_mem_gen_0/doutb]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins ROM_Handler_0/clk] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_0/clkb]
  connect_bd_net -net rst_n_1 [get_bd_ports rst_n] [get_bd_pins ROM_Handler_0/rst_n] [get_bd_pins blk_mem_gen_0/rsta] [get_bd_pins blk_mem_gen_0/rstb]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port dtack -pg 1 -y 210 -defaultsOSRD
preplace port as -pg 1 -y 210 -defaultsOSRD
preplace port clk -pg 1 -y -150 -defaultsOSRD
preplace port rst_n -pg 1 -y -110 -defaultsOSRD
preplace portBus addr -pg 1 -y 190 -defaultsOSRD
preplace inst ROM_Handler_0 -pg 1 -lvl 1 -y 160 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 1 -y 570 -defaultsOSRD
preplace netloc addr_1 1 0 1 N
preplace netloc ROM_Handler_0_ROM_addr_1 1 0 2 20 60 680
preplace netloc ROM_Handler_0_ROM_addr_2 1 0 2 40 260 690
preplace netloc as_1 1 0 1 N
preplace netloc rst_n_1 1 0 1 -20
preplace netloc clk_1 1 0 1 -10
preplace netloc ROM_Handler_0_dtack 1 1 1 N
preplace netloc blk_mem_gen_0_douta 1 0 1 30
preplace netloc blk_mem_gen_0_doutb 1 0 1 10
preplace netloc ROM_Handler_0_rd_en_1 1 0 2 50 270 680
preplace netloc ROM_Handler_0_rd_en_2 1 0 2 0 40 700
levelinfo -pg 1 -40 530 740 -top -170 -bot 730
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


