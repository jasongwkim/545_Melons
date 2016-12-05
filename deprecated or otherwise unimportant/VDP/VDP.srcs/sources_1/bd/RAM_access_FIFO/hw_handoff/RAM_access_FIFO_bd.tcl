
################################################################
# This is a generated script based on design: RAM_access_FIFO
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source RAM_access_FIFO_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7a100tcsg324-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name RAM_access_FIFO

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

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set FIFO_READ [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:fifo_read_rtl:1.0 FIFO_READ ]
  set FIFO_WRITE [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:fifo_write_rtl:1.0 FIFO_WRITE ]

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set din [ create_bd_port -dir I -from 37 -to 0 din ]
  set dout [ create_bd_port -dir O -from 37 -to 0 dout ]
  set empty [ create_bd_port -dir O empty ]
  set full [ create_bd_port -dir O full ]
  set rd_en [ create_bd_port -dir I rd_en ]
  set srst [ create_bd_port -dir I srst ]
  set valid [ create_bd_port -dir O valid ]
  set wr_en [ create_bd_port -dir I wr_en ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:12.0 fifo_generator_0 ]
  set_property -dict [ list CONFIG.Almost_Full_Flag {false} CONFIG.Data_Count_Width {9} CONFIG.Full_Flags_Reset_Value {0} CONFIG.Full_Threshold_Assert_Value {510} CONFIG.Full_Threshold_Negate_Value {509} CONFIG.Input_Data_Width {38} CONFIG.Input_Depth {512} CONFIG.Output_Data_Width {38} CONFIG.Output_Depth {512} CONFIG.Read_Data_Count_Width {9} CONFIG.Reset_Type {Synchronous_Reset} CONFIG.Valid_Flag {true} CONFIG.Write_Data_Count_Width {9}  ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net FIFO_READ_1 [get_bd_intf_ports FIFO_READ] [get_bd_intf_pins fifo_generator_0/FIFO_READ]
  connect_bd_intf_net -intf_net FIFO_WRITE_1 [get_bd_intf_ports FIFO_WRITE] [get_bd_intf_pins fifo_generator_0/FIFO_WRITE]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins fifo_generator_0/clk]
  connect_bd_net -net din_1 [get_bd_ports din] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net fifo_generator_0_dout [get_bd_ports dout] [get_bd_pins fifo_generator_0/dout]
  connect_bd_net -net fifo_generator_0_empty [get_bd_ports empty] [get_bd_pins fifo_generator_0/empty]
  connect_bd_net -net fifo_generator_0_full [get_bd_ports full] [get_bd_pins fifo_generator_0/full]
  connect_bd_net -net fifo_generator_0_valid [get_bd_ports valid] [get_bd_pins fifo_generator_0/valid]
  connect_bd_net -net rd_en_1 [get_bd_ports rd_en] [get_bd_pins fifo_generator_0/rd_en]
  connect_bd_net -net srst_1 [get_bd_ports srst] [get_bd_pins fifo_generator_0/srst]
  connect_bd_net -net wr_en_1 [get_bd_ports wr_en] [get_bd_pins fifo_generator_0/wr_en]

  # Create address segments
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


