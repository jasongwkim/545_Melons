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


// IP VLNV: xilinx.com:module_ref:DMA_wrapper:1.0
// IP Revision: 1

(* X_CORE_INFO = "DMA_wrapper,Vivado 2016.2" *)
(* CHECK_LICENSE_TYPE = "DMA_top_DMA_wrapper_0_0,DMA_wrapper,{}" *)
(* CORE_GENERATION_INFO = "DMA_top_DMA_wrapper_0_0,DMA_wrapper,{x_ipProduct=Vivado 2016.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=DMA_wrapper,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module DMA_top_DMA_wrapper_0_0 (
  clk,
  rst_n,
  Z80_rd,
  Z80_wr,
  Z80_mreq,
  M68_rw,
  M68_as,
  M68_lds,
  M68_uds,
  VDP_DTACK_N,
  HINT,
  VINT_TG68,
  VINT_T80,
  VDP_VBUS_SEL,
  RAM_8_data_out,
  RAM_16_data_out,
  Z80_addr,
  M68_data_out,
  VDP_DO,
  HV_count,
  M68_addr,
  M68_dtack,
  RAM_8_en,
  RAM_16_en,
  RAM_8_we,
  RAM_16_we,
  VDP_RNW,
  VDP_UDS_N,
  VDP_LDS_N,
  VDP_SEL,
  HINT_ACK,
  VINT_TG68_ACK,
  VDP_VBUS_DTACK_N,
  VDP_A,
  RAM_8_data_in,
  RAM_8_addr,
  RAM_16_addr,
  RAM_16_data_in,
  M68_data_in,
  VDP_DI,
  VDP_VBUS_DATA,
  Z80_data
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
input wire rst_n;
input wire Z80_rd;
input wire Z80_wr;
input wire Z80_mreq;
input wire M68_rw;
input wire M68_as;
input wire M68_lds;
input wire M68_uds;
input wire VDP_DTACK_N;
input wire HINT;
input wire VINT_TG68;
input wire VINT_T80;
input wire VDP_VBUS_SEL;
input wire [7 : 0] RAM_8_data_out;
input wire [15 : 0] RAM_16_data_out;
input wire [15 : 0] Z80_addr;
input wire [15 : 0] M68_data_out;
input wire [15 : 0] VDP_DO;
input wire [15 : 0] HV_count;
input wire [31 : 0] M68_addr;
output wire M68_dtack;
output wire RAM_8_en;
output wire RAM_16_en;
output wire RAM_8_we;
output wire RAM_16_we;
output wire VDP_RNW;
output wire VDP_UDS_N;
output wire VDP_LDS_N;
output wire VDP_SEL;
output wire HINT_ACK;
output wire VINT_TG68_ACK;
output wire VDP_VBUS_DTACK_N;
output wire [4 : 0] VDP_A;
output wire [7 : 0] RAM_8_data_in;
output wire [9 : 0] RAM_8_addr;
output wire [11 : 0] RAM_16_addr;
output wire [15 : 0] RAM_16_data_in;
output wire [15 : 0] M68_data_in;
output wire [15 : 0] VDP_DI;
output wire [15 : 0] VDP_VBUS_DATA;
inout wire [7 : 0] Z80_data;

  DMA_wrapper inst (
    .clk(clk),
    .rst_n(rst_n),
    .Z80_rd(Z80_rd),
    .Z80_wr(Z80_wr),
    .Z80_mreq(Z80_mreq),
    .M68_rw(M68_rw),
    .M68_as(M68_as),
    .M68_lds(M68_lds),
    .M68_uds(M68_uds),
    .VDP_DTACK_N(VDP_DTACK_N),
    .HINT(HINT),
    .VINT_TG68(VINT_TG68),
    .VINT_T80(VINT_T80),
    .VDP_VBUS_SEL(VDP_VBUS_SEL),
    .RAM_8_data_out(RAM_8_data_out),
    .RAM_16_data_out(RAM_16_data_out),
    .Z80_addr(Z80_addr),
    .M68_data_out(M68_data_out),
    .VDP_DO(VDP_DO),
    .HV_count(HV_count),
    .M68_addr(M68_addr),
    .M68_dtack(M68_dtack),
    .RAM_8_en(RAM_8_en),
    .RAM_16_en(RAM_16_en),
    .RAM_8_we(RAM_8_we),
    .RAM_16_we(RAM_16_we),
    .VDP_RNW(VDP_RNW),
    .VDP_UDS_N(VDP_UDS_N),
    .VDP_LDS_N(VDP_LDS_N),
    .VDP_SEL(VDP_SEL),
    .HINT_ACK(HINT_ACK),
    .VINT_TG68_ACK(VINT_TG68_ACK),
    .VDP_VBUS_DTACK_N(VDP_VBUS_DTACK_N),
    .VDP_A(VDP_A),
    .RAM_8_data_in(RAM_8_data_in),
    .RAM_8_addr(RAM_8_addr),
    .RAM_16_addr(RAM_16_addr),
    .RAM_16_data_in(RAM_16_data_in),
    .M68_data_in(M68_data_in),
    .VDP_DI(VDP_DI),
    .VDP_VBUS_DATA(VDP_VBUS_DATA),
    .Z80_data(Z80_data)
  );
endmodule
