//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Sun Oct 16 17:27:29 2016
//Host        : columbus.andrew.cmu.edu running 64-bit Red Hat Enterprise Linux Server release 7.2 (Maipo)
//Command     : generate_target RAM_access_FIFO.bd
//Design      : RAM_access_FIFO
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "RAM_access_FIFO,IP_Integrator,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=RAM_access_FIFO,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,synth_mode=Global}" *) (* HW_HANDOFF = "RAM_access_FIFO.hwdef" *) 
module RAM_access_FIFO
   (clk,
    din,
    dout,
    empty,
    full,
    rd_en,
    srst,
    valid,
    wr_en);
  input clk;
  input [37:0]din;
  output [37:0]dout;
  output empty;
  output full;
  input rd_en;
  input srst;
  output valid;
  input wr_en;

  wire clk_1;
  wire [37:0]din_1;
  wire [37:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire fifo_generator_0_full;
  wire fifo_generator_0_valid;
  wire rd_en_1;
  wire srst_1;
  wire wr_en_1;

  assign clk_1 = clk;
  assign din_1 = din[37:0];
  assign dout[37:0] = fifo_generator_0_dout;
  assign empty = fifo_generator_0_empty;
  assign full = fifo_generator_0_full;
  assign rd_en_1 = rd_en;
  assign srst_1 = srst;
  assign valid = fifo_generator_0_valid;
  assign wr_en_1 = wr_en;
  RAM_access_FIFO_fifo_generator_0_0 fifo_generator_0
       (.clk(clk_1),
        .din(din_1),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .full(fifo_generator_0_full),
        .rd_en(rd_en_1),
        .srst(srst_1),
        .valid(fifo_generator_0_valid),
        .wr_en(wr_en_1));
endmodule
