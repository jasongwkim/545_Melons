module demo ();
    logic clk, rst_n;
    logic dtack, uds, lds, rw, intack;
    logic [15:0] M68_data_in, M68_data_out;
    logic [31:0] M68_addr;
    logic [15:0] Z80_addr;
    logic [7:0]  Z80_data;
    
    logic nM1, nMREQ, nIORQ, nRD, nWR, nRFSH, nHALT, nBUSACK; //Outputs from z80
    logic nWAIT, nINT, nNMI, nBUSRQ; //Inputs from z80
    
    //Memory io
    logic ena, wea;
    logic [16:0] addra;
    logic [7:0] dina, douta;
    
    TG68 core (.clk(clk), .reset(rst_n), .clkena_in(1'b1), .data_in(M68_data_in),
                .IPL(3'b111), .dtack(dtack), .addr(M68_addr), .data_out(M68_data_out),
                .as(as), .uds(uds), .lds(lds), .rw(rw), .enaRDreg(1'b1), .enaWRreg(1'b1),
                .intack(intack));
                
    z80_top_direct_n core2 (.CLK(clk), .nRESET(rst_n), .A(Z80_addr), .D(Z80_data),
                            .nM1, .nMREQ, .nIORQ, .nRD, .nWR, .nRFSH, .nHALT, .nBUSACK,
                            .nWAIT, .nINT, .nNMI, .nBUSRQ);
    
    blk_mem_gen_0 mem (.clka(clk), .ena, .wea, .addra, .dina, .douta);
    
    initial begin
        forever #5 clk <= ~clk;
    end
    
    initial begin
        rst_n <= 1'b0;
        nWAIT <= 1'b1;
        nINT <= 1'b1;
        nNMI <= 1'b1;
        nBUSRQ <= 1'b1;
        @(posedge clk);
        rst_n <= 1'b1;
        @(posedge clk);
        //Memory should look like this in Z80 address space
        //0000     0001     0002    
        //3E       9A       77
        //00111110 10011010 01110111
    end
                
endmodule