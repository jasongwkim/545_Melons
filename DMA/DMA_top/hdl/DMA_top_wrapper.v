//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Sun Dec 04 13:18:38 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target DMA_top_wrapper.bd
//Design      : DMA_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module DMA_top_wrapper
   (HINT,
    HINT_ACK,
    HV_count,
    M68_addr,
    M68_as,
    M68_data_in,
    M68_data_out,
    M68_dtack,
    M68_lds,
    M68_rw,
    M68_uds,
    VDP_A,
    VDP_DI,
    VDP_DO,
    VDP_DTACK_N,
    VDP_LDS_N,
    VDP_RNW,
    VDP_SEL,
    VDP_UDS_N,
    VDP_VBUS_DATA,
    VDP_VBUS_DTACK_N,
    VDP_VBUS_SEL,
    VINT_T80,
    VINT_TG68,
    VINT_TG68_ACK,
    Z80_addr,
    Z80_data,
    Z80_mreq,
    Z80_rd,
    Z80_wr,
    clk,
    rst_n);
  input HINT;
  output HINT_ACK;
  input [15:0]HV_count;
  input [31:0]M68_addr;
  input M68_as;
  output [15:0]M68_data_in;
  input [15:0]M68_data_out;
  output M68_dtack;
  input M68_lds;
  input M68_rw;
  input M68_uds;
  output [4:0]VDP_A;
  output [15:0]VDP_DI;
  input [15:0]VDP_DO;
  input VDP_DTACK_N;
  output VDP_LDS_N;
  output VDP_RNW;
  output VDP_SEL;
  output VDP_UDS_N;
  output [15:0]VDP_VBUS_DATA;
  output VDP_VBUS_DTACK_N;
  input VDP_VBUS_SEL;
  input VINT_T80;
  input VINT_TG68;
  output VINT_TG68_ACK;
  input [15:0]Z80_addr;
  inout [7:0]Z80_data;
  input Z80_mreq;
  input Z80_rd;
  input Z80_wr;
  input clk;
  input rst_n;

  wire HINT;
  wire HINT_ACK;
  wire [15:0]HV_count;
  wire [31:0]M68_addr;
  wire M68_as;
  wire [15:0]M68_data_in;
  wire [15:0]M68_data_out;
  wire M68_dtack;
  wire M68_lds;
  wire M68_rw;
  wire M68_uds;
  wire [4:0]VDP_A;
  wire [15:0]VDP_DI;
  wire [15:0]VDP_DO;
  wire VDP_DTACK_N;
  wire VDP_LDS_N;
  wire VDP_RNW;
  wire VDP_SEL;
  wire VDP_UDS_N;
  wire [15:0]VDP_VBUS_DATA;
  wire VDP_VBUS_DTACK_N;
  wire VDP_VBUS_SEL;
  wire VINT_T80;
  wire VINT_TG68;
  wire VINT_TG68_ACK;
  wire [15:0]Z80_addr;
  wire [7:0]Z80_data;
  wire Z80_mreq;
  wire Z80_rd;
  wire Z80_wr;
  wire clk;
  wire rst_n;

  DMA_top DMA_top_i
       (.HINT(HINT),
        .HINT_ACK(HINT_ACK),
        .HV_count(HV_count),
        .M68_addr(M68_addr),
        .M68_as(M68_as),
        .M68_data_in(M68_data_in),
        .M68_data_out(M68_data_out),
        .M68_dtack(M68_dtack),
        .M68_lds(M68_lds),
        .M68_rw(M68_rw),
        .M68_uds(M68_uds),
        .VDP_A(VDP_A),
        .VDP_DI(VDP_DI),
        .VDP_DO(VDP_DO),
        .VDP_DTACK_N(VDP_DTACK_N),
        .VDP_LDS_N(VDP_LDS_N),
        .VDP_RNW(VDP_RNW),
        .VDP_SEL(VDP_SEL),
        .VDP_UDS_N(VDP_UDS_N),
        .VDP_VBUS_DATA(VDP_VBUS_DATA),
        .VDP_VBUS_DTACK_N(VDP_VBUS_DTACK_N),
        .VDP_VBUS_SEL(VDP_VBUS_SEL),
        .VINT_T80(VINT_T80),
        .VINT_TG68(VINT_TG68),
        .VINT_TG68_ACK(VINT_TG68_ACK),
        .Z80_addr(Z80_addr),
        .Z80_data(Z80_data),
        .Z80_mreq(Z80_mreq),
        .Z80_rd(Z80_rd),
        .Z80_wr(Z80_wr),
        .clk(clk),
        .rst_n(rst_n));
endmodule
