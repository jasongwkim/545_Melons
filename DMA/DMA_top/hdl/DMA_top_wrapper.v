//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Sun Nov 06 17:46:12 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target DMA_top_wrapper.bd
//Design      : DMA_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module DMA_top_wrapper
   (M68_addr,
    M68_as,
    M68_data_in,
    M68_data_out,
    M68_dtack,
    M68_lds,
    M68_rw,
    M68_uds,
    VDP_control,
    VDP_control_rw,
    VDP_data,
    VDP_data_rw,
    Z80_addr,
    Z80_busack,
    Z80_data,
    Z80_mreq,
    Z80_rd,
    Z80_wr,
    clk,
    rst_n);
  input [31:0]M68_addr;
  input M68_as;
  output [15:0]M68_data_in;
  input [15:0]M68_data_out;
  output M68_dtack;
  input M68_lds;
  input M68_rw;
  input M68_uds;
  output [7:0]VDP_control;
  output VDP_control_rw;
  output [7:0]VDP_data;
  output VDP_data_rw;
  input [15:0]Z80_addr;
  output Z80_busack;
  inout [7:0]Z80_data;
  input Z80_mreq;
  input Z80_rd;
  input Z80_wr;
  input clk;
  input rst_n;

  wire [31:0]M68_addr;
  wire M68_as;
  wire [15:0]M68_data_in;
  wire [15:0]M68_data_out;
  wire M68_dtack;
  wire M68_lds;
  wire M68_rw;
  wire M68_uds;
  wire [7:0]VDP_control;
  wire VDP_control_rw;
  wire [7:0]VDP_data;
  wire VDP_data_rw;
  wire [15:0]Z80_addr;
  wire Z80_busack;
  wire [7:0]Z80_data;
  wire Z80_mreq;
  wire Z80_rd;
  wire Z80_wr;
  wire clk;
  wire rst_n;

  DMA_top DMA_top_i
       (.M68_addr(M68_addr),
        .M68_as(M68_as),
        .M68_data_in(M68_data_in),
        .M68_data_out(M68_data_out),
        .M68_dtack(M68_dtack),
        .M68_lds(M68_lds),
        .M68_rw(M68_rw),
        .M68_uds(M68_uds),
        .VDP_control(VDP_control),
        .VDP_control_rw(VDP_control_rw),
        .VDP_data(VDP_data),
        .VDP_data_rw(VDP_data_rw),
        .Z80_addr(Z80_addr),
        .Z80_busack(Z80_busack),
        .Z80_data(Z80_data),
        .Z80_mreq(Z80_mreq),
        .Z80_rd(Z80_rd),
        .Z80_wr(Z80_wr),
        .clk(clk),
        .rst_n(rst_n));
endmodule
