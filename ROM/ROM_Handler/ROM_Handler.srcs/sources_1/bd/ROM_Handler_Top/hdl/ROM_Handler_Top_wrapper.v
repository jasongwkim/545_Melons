//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Sun Dec 04 14:22:52 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target ROM_Handler_Top_wrapper.bd
//Design      : ROM_Handler_Top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ROM_Handler_Top_wrapper
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

  wire ack;
  wire [23:0]addr;
  wire clk;
  wire mem_rq;
  wire rst_n;
  wire word;

  ROM_Handler_Top ROM_Handler_Top_i
       (.ack(ack),
        .addr(addr),
        .clk(clk),
        .mem_rq(mem_rq),
        .rst_n(rst_n),
        .word(word));
endmodule
