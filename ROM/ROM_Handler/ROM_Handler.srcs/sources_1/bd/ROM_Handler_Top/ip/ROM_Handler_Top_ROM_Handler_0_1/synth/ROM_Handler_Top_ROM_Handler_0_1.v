// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:ROM_Handler:1.0
// IP Revision: 1

(* X_CORE_INFO = "ROM_Handler,Vivado 2016.2" *)
(* CHECK_LICENSE_TYPE = "ROM_Handler_Top_ROM_Handler_0_1,ROM_Handler,{}" *)
(* CORE_GENERATION_INFO = "ROM_Handler_Top_ROM_Handler_0_1,ROM_Handler,{x_ipProduct=Vivado 2016.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=ROM_Handler,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module ROM_Handler_Top_ROM_Handler_0_1 (
  clk,
  rst_n,
  ROM_data_1,
  ROM_data_2,
  addr,
  as,
  data,
  ROM_addr_1,
  ROM_addr_2,
  rd_en_1,
  rd_en_2,
  dtack
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
input wire rst_n;
input wire [7 : 0] ROM_data_1;
input wire [7 : 0] ROM_data_2;
input wire [23 : 0] addr;
input wire as;
output wire [15 : 0] data;
output wire [18 : 0] ROM_addr_1;
output wire [18 : 0] ROM_addr_2;
output wire rd_en_1;
output wire rd_en_2;
output wire dtack;

  ROM_Handler inst (
    .clk(clk),
    .rst_n(rst_n),
    .ROM_data_1(ROM_data_1),
    .ROM_data_2(ROM_data_2),
    .addr(addr),
    .as(as),
    .data(data),
    .ROM_addr_1(ROM_addr_1),
    .ROM_addr_2(ROM_addr_2),
    .rd_en_1(rd_en_1),
    .rd_en_2(rd_en_2),
    .dtack(dtack)
  );
endmodule
