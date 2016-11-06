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
    input logic Z80_rd, Z80_wr, Z80_mreq,
    input logic M68_rw, M68_as, M68_lds, M68_uds,   
    input logic [7:0] RAM_8_data_out,
    input logic [15:0] RAM_16_data_out, Z80_addr, M68_data_out,
    input logic [31:0] M68_addr,
    output logic M68_dtack, Z80_busack, RAM_8_en, RAM_16_en, RAM_8_we, RAM_16_we, VDP_data_rw, VDP_control_rw,
    output logic [7:0] RAM_8_data_in, VDP_data, VDP_control,
    output logic [9:0] RAM_8_addr,
    output logic [11:0] RAM_16_addr,
    output logic [15:0] RAM_16_data_in, M68_data_in,
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
                        RAM_16_addr <= M68_addr[16:0];
                        M68_dtack <= 1;
                        if(M68_rw) begin
                            RAM_16_en <= 1;
                            RAM_16_we <= 0;
                            state <= M68_READ;    
                        end
                        else begin
                            if(M68_addr == 24'hC00000) begin
                                VDP_data_rw <= 0;
                                VDP_data <= M68_data_out;
                            end
                            else if(M68_addr == 24'hC00004) begin
                                VDP_control <= 0;
                                VDP_control <= M68_data_out;
                            end
                            else begin
                                RAM_16_en <= 1;
                                RAM_16_we <= 1;
                                RAM_16_data_in <= M68_data_out;
                                RAM_16_addr <= M68_addr;
                            end 
                            state <= M68_WRITE;    
                        end
                    end
                    if(!Z80_mreq) begin
                        if(!Z80_rd) begin
                            RAM_8_en <= 1;
                            RAM_8_we <= 0;
                            RAM_8_addr <= Z80_addr;
                            state <= Z80_READ;  
                        end
                        else if(!Z80_wr) begin
                            if(M68_addr == 24'hC00000) begin
                                VDP_data_rw <= 0;
                                VDP_data <= Z80_data;
                            end
                            else if(M68_addr == 24'hC00004) begin
                                VDP_control_rw <= 0;
                                VDP_control <= Z80_data;
                            end
                            else begin
                                RAM_8_en <= 1;
                                RAM_8_we <= 1;
                                RAM_8_data_in <= Z80_data;
                                RAM_8_addr <= Z80_addr;
                            end
                            state <= Z80_WRITE;
                        end
                    end
                end
                M68_READ: begin
                    VDP_data_rw <= 1;
                    VDP_control_rw <= 1;
                    M68_data_in <= RAM_16_data_out;
                    RAM_16_en <= 0;
                    state <= HOLD;
                end    
                M68_WRITE: begin
                    RAM_16_en <= 0;
                    state <= HOLD;
                end    
                Z80_READ: begin
                    VDP_data_rw <= 1;
                    VDP_control_rw <= 1;
                    Z80_local <= RAM_8_data_out;
                    RAM_8_en <= 0;
                    state <= IDLE;
                end    
                Z80_WRITE: begin
                    RAM_8_en <= 0;
                    state <= IDLE;
                end    
                HOLD: begin
                    M68_dtack <= 0;
                    state <= IDLE;
                end
            endcase
            
        end
    end
    
endmodule
