//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Sun Dec 04 16:56:20 2016
//Host        : DESKTOP-4Q1GBRI running 64-bit major release  (build 9200)
//Command     : generate_target ROM_Handler_Top_wrapper.bd
//Design      : ROM_Handler_Top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ROM_Handler_Top_wrapper
   (addr,
    as,
    clk,
    data,
    dtack,
    rst_n);
  input [23:0]addr;
  input as;
  input clk;
  output [15:0]data;
  output dtack;
  input rst_n;

  wire [23:0]addr;
  wire as;
  wire clk;
  wire [15:0]data;
  wire dtack;
  wire rst_n;

  ROM_Handler_Top ROM_Handler_Top_i
       (.addr(addr),
        .as(as),
        .clk(clk),
        .data(data),
        .dtack(dtack),
        .rst_n(rst_n));
endmodule
