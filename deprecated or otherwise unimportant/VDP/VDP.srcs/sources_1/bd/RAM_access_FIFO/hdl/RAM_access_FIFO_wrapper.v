//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Sun Oct 16 17:27:29 2016
//Host        : columbus.andrew.cmu.edu running 64-bit Red Hat Enterprise Linux Server release 7.2 (Maipo)
//Command     : generate_target RAM_access_FIFO_wrapper.bd
//Design      : RAM_access_FIFO_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module RAM_access_FIFO_wrapper
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

  wire clk;
  wire [37:0]din;
  wire [37:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire srst;
  wire valid;
  wire wr_en;

  RAM_access_FIFO RAM_access_FIFO_i
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_en(rd_en),
        .srst(srst),
        .valid(valid),
        .wr_en(wr_en));
endmodule
