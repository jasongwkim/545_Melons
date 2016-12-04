//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Sun Dec 04 14:22:52 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target ROM_Handler_Top.bd
//Design      : ROM_Handler_Top
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ROM_Handler_Top,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ROM_Handler_Top,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "ROM_Handler_Top.hwdef" *) 
module ROM_Handler_Top
   (ack,
    addr,
    clk,
    mem_rq,
    rst_n,
    word);
  output ack;
  input [23:0]addr;
  input clk;
  input mem_rq;
  input rst_n;
  input word;

  wire [18:0]ROM_Handler_0_ROM_addr_1;
  wire [18:0]ROM_Handler_0_ROM_addr_2;
  wire ROM_Handler_0_ack;
  wire ROM_Handler_0_rd_en_1;
  wire ROM_Handler_0_rd_en_2;
  wire [23:0]addr_1;
  wire [7:0]blk_mem_gen_0_douta;
  wire [7:0]blk_mem_gen_0_doutb;
  wire clk_1;
  wire mem_rq_1;
  wire rst_n_1;
  wire word_1;

  assign ack = ROM_Handler_0_ack;
  assign addr_1 = addr[23:0];
  assign clk_1 = clk;
  assign mem_rq_1 = mem_rq;
  assign rst_n_1 = rst_n;
  assign word_1 = word;
  ROM_Handler_Top_ROM_Handler_0_1 ROM_Handler_0
       (.ROM_addr_1(ROM_Handler_0_ROM_addr_1),
        .ROM_addr_2(ROM_Handler_0_ROM_addr_2),
        .ROM_data_1(blk_mem_gen_0_douta),
        .ROM_data_2(blk_mem_gen_0_doutb),
        .ack(ROM_Handler_0_ack),
        .addr(addr_1),
        .clk(clk_1),
        .mem_rq(mem_rq_1),
        .rd_en_1(ROM_Handler_0_rd_en_1),
        .rd_en_2(ROM_Handler_0_rd_en_2),
        .rst_n(rst_n_1),
        .word(word_1));
  ROM_Handler_Top_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(ROM_Handler_0_ROM_addr_1),
        .addrb(ROM_Handler_0_ROM_addr_2),
        .clka(clk_1),
        .clkb(clk_1),
        .douta(blk_mem_gen_0_douta),
        .doutb(blk_mem_gen_0_doutb),
        .ena(ROM_Handler_0_rd_en_1),
        .enb(ROM_Handler_0_rd_en_2),
        .rsta(rst_n_1),
        .rstb(rst_n_1));
endmodule
