`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 12:16:09 PM
// Design Name: 
// Module Name: DMA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DMA(
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
    
    reg [7:0] Z80_local;
    
    assign Z80_data = Z80_local;
    
    enum {IDLE, M68_READ, M68_WRITE, Z80_READ, Z80_WRITE, HOLD} state;
    
    always_ff @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            state <= IDLE;    
        end
        else begin
            case(state)
                IDLE: begin
                    if(!M68_as) begin
                        RAM_addr <= M68_addr;
                        M68_dtack <= 1;
                        if(M68_rw) begin
                            RAM_en <= 1;
                            RAM_we <= 0;
                            state <= M68_READ;    
                        end
                        else begin
                            RAM_en <= 1;
                            RAM_we <= 1;
                            state <= M68_WRITE;    
                        end
                    end
                    else if(!Z80_rd) begin
                        RAM_en <= 1;
                        RAM_we <= 0;
                        RAM_addr <= Z80_addr;
                        state <= Z80_READ;  
                    end
                    else if(!Z80_wr) begin
                        RAM_en <= 1;
                        RAM_we <= 1;
                        RAM_addr <= Z80_addr;
                        state <= Z80_WRITE;
                    end
                end
                M68_READ: begin
                    M68_data_in <= RAM_data_out;
                    RAM_en <= 0;
                    state <= HOLD;
                end    
                M68_WRITE: begin
                    RAM_en <= 0;
                    state <= HOLD;
                end    
                Z80_READ: begin
                    Z80_local <= RAM_data_out;
                    RAM_en <= 0;
                end    
                Z80_WRITE: begin
                    RAM_en <= 0;
                end    
            endcase
            
        end
    end
    
endmodule
