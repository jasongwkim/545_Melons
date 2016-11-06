//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Sun Nov 06 17:46:12 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target DMA_top.bd
//Design      : DMA_top
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "DMA_top,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=DMA_top,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "DMA_top.hwdef" *) 
module DMA_top
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

  wire [15:0]DMA_wrapper_0_M68_data_in;
  wire DMA_wrapper_0_M68_dtack;
  wire [11:0]DMA_wrapper_0_RAM_16_addr;
  wire [15:0]DMA_wrapper_0_RAM_16_data_in;
  wire DMA_wrapper_0_RAM_16_en;
  wire DMA_wrapper_0_RAM_16_we;
  wire [9:0]DMA_wrapper_0_RAM_8_addr;
  wire [7:0]DMA_wrapper_0_RAM_8_data_in;
  wire DMA_wrapper_0_RAM_8_en;
  wire DMA_wrapper_0_RAM_8_we;
  wire [7:0]DMA_wrapper_0_VDP_control;
  wire DMA_wrapper_0_VDP_control_rw;
  wire [7:0]DMA_wrapper_0_VDP_data;
  wire DMA_wrapper_0_VDP_data_rw;
  wire DMA_wrapper_0_Z80_busack;
  wire [31:0]M68_addr_1;
  wire M68_as_1;
  wire [15:0]M68_data_out_1;
  wire M68_lds_1;
  wire M68_rw_1;
  wire M68_uds_1;
  wire [7:0]Net;
  wire [15:0]Z80_addr_1;
  wire Z80_mreq_1;
  wire Z80_rd_1;
  wire Z80_wr_1;
  wire [15:0]blk_mem_gen_0_douta;
  wire [7:0]blk_mem_gen_1_douta;
  wire clk_1;
  wire rst_n_1;

  assign M68_addr_1 = M68_addr[31:0];
  assign M68_as_1 = M68_as;
  assign M68_data_in[15:0] = DMA_wrapper_0_M68_data_in;
  assign M68_data_out_1 = M68_data_out[15:0];
  assign M68_dtack = DMA_wrapper_0_M68_dtack;
  assign M68_lds_1 = M68_lds;
  assign M68_rw_1 = M68_rw;
  assign M68_uds_1 = M68_uds;
  assign VDP_control[7:0] = DMA_wrapper_0_VDP_control;
  assign VDP_control_rw = DMA_wrapper_0_VDP_control_rw;
  assign VDP_data[7:0] = DMA_wrapper_0_VDP_data;
  assign VDP_data_rw = DMA_wrapper_0_VDP_data_rw;
  assign Z80_addr_1 = Z80_addr[15:0];
  assign Z80_busack = DMA_wrapper_0_Z80_busack;
  assign Z80_mreq_1 = Z80_mreq;
  assign Z80_rd_1 = Z80_rd;
  assign Z80_wr_1 = Z80_wr;
  assign clk_1 = clk;
  assign rst_n_1 = rst_n;
  DMA_top_DMA_wrapper_0_0 DMA_wrapper_0
       (.M68_addr(M68_addr_1),
        .M68_as(M68_as_1),
        .M68_data_in(DMA_wrapper_0_M68_data_in),
        .M68_data_out(M68_data_out_1),
        .M68_dtack(DMA_wrapper_0_M68_dtack),
        .M68_lds(M68_lds_1),
        .M68_rw(M68_rw_1),
        .M68_uds(M68_uds_1),
        .RAM_16_addr(DMA_wrapper_0_RAM_16_addr),
        .RAM_16_data_in(DMA_wrapper_0_RAM_16_data_in),
        .RAM_16_data_out(blk_mem_gen_0_douta),
        .RAM_16_en(DMA_wrapper_0_RAM_16_en),
        .RAM_16_we(DMA_wrapper_0_RAM_16_we),
        .RAM_8_addr(DMA_wrapper_0_RAM_8_addr),
        .RAM_8_data_in(DMA_wrapper_0_RAM_8_data_in),
        .RAM_8_data_out(blk_mem_gen_1_douta),
        .RAM_8_en(DMA_wrapper_0_RAM_8_en),
        .RAM_8_we(DMA_wrapper_0_RAM_8_we),
        .VDP_control(DMA_wrapper_0_VDP_control),
        .VDP_control_rw(DMA_wrapper_0_VDP_control_rw),
        .VDP_data(DMA_wrapper_0_VDP_data),
        .VDP_data_rw(DMA_wrapper_0_VDP_data_rw),
        .Z80_addr(Z80_addr_1),
        .Z80_busack(DMA_wrapper_0_Z80_busack),
        .Z80_data(Z80_data[7:0]),
        .Z80_mreq(Z80_mreq_1),
        .Z80_rd(Z80_rd_1),
        .Z80_wr(Z80_wr_1),
        .clk(clk_1),
        .rst_n(rst_n_1));
  DMA_top_blk_mem_gen_0_3 blk_mem_gen_0
       (.addra(DMA_wrapper_0_RAM_16_addr),
        .clka(clk_1),
        .dina(DMA_wrapper_0_RAM_16_data_in),
        .douta(blk_mem_gen_0_douta),
        .ena(DMA_wrapper_0_RAM_16_en),
        .rsta(rst_n_1),
        .wea(DMA_wrapper_0_RAM_16_we));
  DMA_top_blk_mem_gen_1_0 blk_mem_gen_1
       (.addra(DMA_wrapper_0_RAM_8_addr),
        .clka(clk_1),
        .dina(DMA_wrapper_0_RAM_8_data_in),
        .douta(blk_mem_gen_1_douta),
        .ena(DMA_wrapper_0_RAM_8_en),
        .rsta(rst_n_1),
        .wea(DMA_wrapper_0_RAM_8_we));
endmodule
