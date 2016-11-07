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
  RAM_8_data_out,
  RAM_16_data_out,
  Z80_addr,
  M68_data_out,
  M68_addr,
  M68_dtack,
  Z80_busack,
  RAM_8_en,
  RAM_16_en,
  RAM_8_we,
  RAM_16_we,
  VDP_data_rw,
  VDP_control_rw,
  RAM_8_data_in,
  VDP_data,
  VDP_control,
  RAM_8_addr,
  RAM_16_addr,
  RAM_16_data_in,
  M68_data_in,
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
input wire [7 : 0] RAM_8_data_out;
input wire [15 : 0] RAM_16_data_out;
input wire [15 : 0] Z80_addr;
input wire [15 : 0] M68_data_out;
input wire [31 : 0] M68_addr;
output wire M68_dtack;
output wire Z80_busack;
output wire RAM_8_en;
output wire RAM_16_en;
output wire RAM_8_we;
output wire RAM_16_we;
output wire VDP_data_rw;
output wire VDP_control_rw;
output wire [7 : 0] RAM_8_data_in;
output wire [7 : 0] VDP_data;
output wire [7 : 0] VDP_control;
output wire [9 : 0] RAM_8_addr;
output wire [11 : 0] RAM_16_addr;
output wire [15 : 0] RAM_16_data_in;
output wire [15 : 0] M68_data_in;
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
    .RAM_8_data_out(RAM_8_data_out),
    .RAM_16_data_out(RAM_16_data_out),
    .Z80_addr(Z80_addr),
    .M68_data_out(M68_data_out),
    .M68_addr(M68_addr),
    .M68_dtack(M68_dtack),
    .Z80_busack(Z80_busack),
    .RAM_8_en(RAM_8_en),
    .RAM_16_en(RAM_16_en),
    .RAM_8_we(RAM_8_we),
    .RAM_16_we(RAM_16_we),
    .VDP_data_rw(VDP_data_rw),
    .VDP_control_rw(VDP_control_rw),
    .RAM_8_data_in(RAM_8_data_in),
    .VDP_data(VDP_data),
    .VDP_control(VDP_control),
    .RAM_8_addr(RAM_8_addr),
    .RAM_16_addr(RAM_16_addr),
    .RAM_16_data_in(RAM_16_data_in),
    .M68_data_in(M68_data_in),
    .Z80_data(Z80_data)
  );
endmodule
