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
    input logic [15:0] VDP_DO, HV_count,
    input logic VDP_DTACK_N, HINT, VINT_TG68, VINT_T80, VDP_VBUS_SEL,
    output logic M68_dtack, Z80_busack, RAM_8_en, RAM_16_en, RAM_8_we, RAM_16_we, 
    output logic [7:0] RAM_8_data_in, 
    output logic [15:0] VDP_DI, VDP_VBUS_DATA,
    output logic VDP_RNW, VDP_UDS_N, VDP_LDS_N, VDP_SEL, HINT_ACK, VINT_TG68_ACK, VDP_VBUS_DTACK_N,
    output logic [4:0]VDP_A,
    output logic [9:0] RAM_8_addr,
    output logic [11:0] RAM_16_addr,
    output logic [15:0] RAM_16_data_in, M68_data_in,
    inout reg [7:0] Z80_data
    );
    
    reg [7:0] Z80_local;


    
    assign Z80_data = Z80_local;
    
    enum {IDLE, M68_READ, M68_WRITE, Z80_READ, Z80_WRITE, VDP_READ, VDP_WRITE, VDP_DMA_WRITE, M68_READ_DTACKHOLD1, M68_READ_DTACKHOLD2, HOLD} state;
    
    always_ff @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            state <= IDLE;    
        end
        else begin
            case(state)
                IDLE: begin
                    if(!M68_as) begin
                        RAM_16_addr <= M68_addr[16:0];
                        M68_dtack <= 1'b1;
                        if(M68_rw) begin // read states
                            if(M68_addr == 24'hC00000) begin
                                //data port read
                                VDP_SEL <= 1'b1;
                                VDP_RNW <= 1'b1;
                                VDP_A <= 5'b00000;
                                state <= VDP_READ;
                            end
                            else if(M68_addr == 24'hC00004) begin
                                //control port read- status reg
                                VDP_SEL <= 1'b1;
                                VDP_RNW <= 1'b1;
                                VDP_A <= 5'b00100;
                                state <= VDP_READ;
                            end
                            else if(M68_addr == 24'hC00008) begin
                                //HV counter read
                                VDP_SEL <= 1'b1;
                                VDP_RNW <= 1'b1;
                                VDP_A <= 5'b01000;
                                state <= VDP_READ;
                            end
                            else begin
                                VDP_SEL <= 1'b0;
                                RAM_16_en <= 1;
                                RAM_16_we <= 0;
                                state <= M68_READ;    
                            end
                        end
                        else begin // write states
                            if(VDP_VBUS_SEL) begin
                                VDP_SEL <= 1'b1;
                                VDP_RNW <= 1'b0;
                                VDP_VBUS_DATA <= M68_data_out;
                                VDP_VBUS_DTACK_N <= 1'b0;
                                state <= VDP_DMA_WRITE;
                            end
                            if(M68_addr == 24'hC00000) begin
                                //data port write
                                VDP_SEL <= 1'b1;
                                VDP_RNW <= 1'b0;
                                VDP_DI <= M68_data_out;
                                VDP_A <= 5'b00000;
                                state <= VDP_WRITE;
                            end
                            else if(M68_addr == 24'hC00004) begin
                                //control port write
                                VDP_SEL <= 1'b1;
                                VDP_RNW <= 1'b0;
                                VDP_DI <= M68_data_out;
                                VDP_A <= 5'b00100;
                                state <= VDP_WRITE;
                            end
                            else begin
                                VDP_SEL <= 1'b0;
                                RAM_16_en <= 1;
                                RAM_16_we <= 1;
                                RAM_16_data_in <= M68_data_out;
                                RAM_16_addr <= M68_addr;
                                state <= M68_WRITE;    //TODO check this with brad.
                            end 
                        end
                    end
                    if(!Z80_mreq) begin     //TODO investigate if Z80 RW will happen.
                        if(!Z80_rd) begin
                            RAM_8_en <= 1;
                            RAM_8_we <= 0;
                            RAM_8_addr <= Z80_addr;
                            state <= Z80_READ;  
                        end
                        else if(!Z80_wr) begin
                            if(M68_addr == 24'hC00000) begin
                                VDP_SEL <= 1;
                                VDP_RNW <= 0;
                                VDP_DI <= Z80_data;
                            end
                            else if(M68_addr == 24'hC00004) begin
                                VDP_RNW <= 0;
                                VDP_DI <= Z80_data;
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
                    M68_data_in <= RAM_16_data_out;
                    M68_dtack <= 1'b0;
                    RAM_16_en <= 0;
                    state <= M68_READ_DTACKHOLD1;
                end    
                M68_WRITE: begin //check the cycle timing for this
                    RAM_16_en <= 0;
                    state <= HOLD;
                end    
                Z80_READ: begin
                    VDP_RNW <= 1;
                    Z80_local <= RAM_8_data_out;
                    RAM_8_en <= 0;
                    state <= IDLE;
                end    
                Z80_WRITE: begin
                    RAM_8_en <= 0;
                    state <= IDLE;
                end
                VDP_WRITE: begin
                    if(!VDP_DTACK_N) begin
                        VDP_SEL <= 1'b0;
                        M68_dtack <= 1'b0;
                        state <= HOLD;
                    end
                    else begin
                        state <= VDP_WRITE;
                    end
                end
                VDP_READ: begin
                    if(!VDP_DTACK_N) begin
                        VDP_SEL <= 1'b0;
                        M68_data_in <= VDP_DO;
                        M68_dtack <= 1'b0;
                        state <= VDP_READ_DTACKHOLD1;
                    end
                    else begin
                        state <= VDP_READ;
                    end
                end
                VDP_DMA_WRITE: begin
                    if(!VDP_VBUS_SEL) begin
                        VDP_SEL <=1'b0; // this could become a bug source. is this necessary??
                        M68_dtack <= 1'b0;
                        state <= HOLD;
                    end
                    else begin
                        state <= VDP_DMA_WRITE;
                    end
                end
                M68_READ_DTACKHOLD1: begin
                    state <= M68_READ_DTACKHOLD2; //just holds data on line for another cycle
                end
                M68_READ_DTACKHOLD2: begin
                    state <= HOLD; //just holds data on line for another cycle
                end    
                HOLD: begin
                    M68_dtack <= 1'b1;
                    state <= IDLE;
                end
            endcase
            
        end
    end
    
endmodule