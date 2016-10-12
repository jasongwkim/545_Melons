module demo (
    input logic clk, rst_n,
    input byte in,
    output byte out
    );
    
    assign out = in;
    
    logic dtack, uds, lds, rw, intack;
    logic [15:0] M68_data_in, M68_data_out;
    logic [31:0] M68_addr;
    logic [15:0] Z80_addr;
    logic [7:0]  Z80_data;
    
    TG68 core (.clk(clk), .reset(rst_n), .clkena_in(1'b1), .data_in(M68_data_in),
                .IPL(3'b111), .dtack(dtack), .addr(M68_addr), .data_out(M68_data_out),
                .as(as), .uds(uds), .lds(lds), .rw(rw), .enaRDreg(1'b1), .enaWRreg(1'b1),
                .intack(intack));
                
    z80_top_direct_n core2 (.CLK(clk), .nRESET(rst_n), .A(Z80_addr), .D(Z80_data)
                
endmodule

module z80_top_direct_n(
    output wire nM1,
    output wire nMREQ,
    output wire nIORQ,
    output wire nRD,
    output wire nWR,
    output wire nRFSH,
    output wire nHALT,
    output wire nBUSACK,

    input wire nWAIT,
    input wire nINT,
    input wire nNMI,
    input wire nBUSRQ,
);