module demo (
    input logic clk, rst_n,
    input byte in,
    output byte out
    );
    
    assign out = in;
    
    logic dtack, uds, lds, rw, intack;
    logic [15:0] M68_data_in, M68_data_out;
    logic [31:0] M68_addr;
    
    TG68 core (.clk(clk), .reset(rst_n), .clkena_in(1'b1), .data_in(M68_data_in),
                .IPL(3'b111), .dtack(dtack), .addr(M68_addr), .data_out(M68_data_out),
                .as(as), .uds(uds), .lds(lds), .rw(rw), .enaRDreg(1'b1), .enaWRreg(1'b1),
                .intack(intack));
                
endmodule