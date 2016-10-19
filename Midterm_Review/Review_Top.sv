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
    
    //DMA io
    logic clk, rst_n;
    logic Z80_rd, Z80_wr, Z80_mreq;
    logic M68_rw, M68_as, M68_lds, M68_uds;   
    logic [7:0] RAM_data_out;
    logic [15:0] Z80_addr, M68_data_out;
    logic [31:0] M68_addr;
    logic M68_dtack, Z80_busack, RAM_en, RAM_we, VDP_data_rw, VDP_control_rw;
    logic [7:0] RAM_data_in, VDP_data, VDP_control;
    logic [15:0] M68_data_in;
    logic [16:0] RAM_addr;
    reg [7:0] Z80_data;
    
    TG68 core (.clk(clk), .reset(rst_n), .clkena_in(1'b1), .data_in(M68_data_in),
                .IPL(3'b111), .dtack(dtack), .addr(M68_addr), .data_out(M68_data_out),
                .as(as), .uds(uds), .lds(lds), .rw(rw), .enaRDreg(1'b1), .enaWRreg(1'b1),
                .intack(intack));
                
    z80_top_direct_n core2 (.CLK(clk), .nRESET(rst_n), .A(Z80_addr), .D(Z80_data),
                            .nM1, .nMREQ, .nIORQ, .nRD, .nWR, .nRFSH, .nHALT, .nBUSACK,
                            .nWAIT, .nINT, .nNMI, .nBUSRQ);
    
    blk_mem_gen_0 mem (.clka(clk), .ena, .wea, .addra, .dina, .douta);
    
    DMA d (.clk, .rst_n, .Z80_rd, .Z80_wr, .Z80_mreq, .M68_rw, .M68_as, .M68_lds, .M68_uds,
           .RAM_data_out, .Z80_addr, .M68_data_out, .M68_addr, .M68_dtack, .Z80_busack, .RAM_en, .RAM_we, .VDP_data_rw, .VDP_control_rw,
           .RAM_data_in, .VDP_data, .VDP_control, .M68_data_in, .RAM_addr, .Z80_data);
    
    initial begin
        forever #5 clk <= ~clk;
    end
    
    initial begin
        rst_n <= 1'b0;
        Z80_rd <= 1'b1;
        Z80_wr <= 1'b1;
        M68_rw <= 1'b1;
        M68_as <= 1'b1;
        M68_lds <= 1'b1;
        M68_uds <= 1'b1;
        RAM_data_out <= 0;
        Z80_addr <= 0;
        M68_data_out <= 0;
        M68_addr <= 0;
        Z80_data <= 0;
        @(posedge clk);
        rst_n <= 1'b1;
        Z80_mreq <= 1'b0;
        Z80_wr <= 1'b0;
        Z80_addr <= 16'b0000000000001110;
        Z80_data <= 8'b11110000;
        @(posedge clk);
        Z80_mreq <= 1'b1;
        @(posedge clk);
        M68_as <= 1'b0;
        M68_addr <= 32'b00000000000000000000000000001110;
        M68_rw <= 1'b1;
        @(posedge clk);
        M68_as <= 1'b1;
        @(posedge clk);
        M68_data_out <= 8'b11110000;
        M68_as <= 1'b0;
        M68_rw <= 1'b0;
        M68_addr <= 24'hC00000;
        @(posedge clk);
        
    end
    /*
        input logic clk, rst_n,
            input logic Z80_rd, Z80_wr,
            input logic M68_rw, M68_as, M68_lds, M68_uds,   
            input logic [7:0] RAM_data_out,
            input logic [15:0] Z80_addr, M68_data_out,
            input logic [31:0] M68_addr,
            output logic M68_dtack, Z80_busack, RAM_en, RAM_we, VDP_data_rw, VDP_control_rw,
            output logic [7:0] RAM_data_in, VDP_data, VDP_control,
            output logic [15:0] M68_data_in,
            output logic [16:0] RAM_addr,
            inout reg [7:0] Z80_data
            );
        */       
endmodule