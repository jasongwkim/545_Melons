module test_z80();
`include "z80_top_direct_n.v"

wire nM1,
wire nMREQ,
wire nIORQ,
wire nRD,
wire nWR,
wire nRFSH,
wire nHALT,
wire nBUSACK,

wire nWAIT,
wire nINT,
wire nNMI,
wire nRESET,
wire nBUSRQ,

wire CLK,
wire [15:0] A,
wire [7:0] D

initial begin
    CLK = 0;
    nRESET = 1;
    #5 nRESET = 0;
    #5 nRESET = 1;
end

always #5 clk = ~clk;

z80_top_direct_n z80(
    .nM1,
    .nMREQ,
    .nIORQ,
    .nRD,
    .nWR,
    .nRFSH,
    .nHALT,
    .nBUSACK,
    .nWAIT,
    .nINT,
    .nNMI,
    .nRESET,
    .nBUSRQ,
    .CLK,
    .A,
    .D)

