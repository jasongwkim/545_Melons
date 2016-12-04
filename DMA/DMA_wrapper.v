//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Mon Oct 31 11:53:19 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target DMA_top_wrapper.bd
//Design      : DMA_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module DMA_wrapper (
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
output wire [4 : 0]VDP_A;
output wire [7 : 0] RAM_8_data_in;
output wire [9 : 0] RAM_8_addr;
output wire [11 : 0] RAM_16_addr;
output wire [15 : 0] RAM_16_data_in;
output wire [15 : 0] M68_data_in;
output wire [15 : 0] VDP_DI;
output wire [15 : 0] VDP_VBUS_DATA;
inout wire [7 : 0] Z80_data;

  DMA inst (
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
