`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2016 11:23:37 AM
// Design Name: 
// Module Name: ti_top
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

module ti_top(
    input logic nWE, nCE,
    input logic CLK, nRST,
    input logic [7:0] D,
    output logic READY, AOUT);
    
    logic [3:0] vol0, vol1, vol2, vol3;
    logic [9:0] tone0, tone1, tone2;
    logic [2:0] noise;
    logic [1:0] channel;
    logic latch;
    
    logic [5:0] storeD;
    
    enum logic [1:0] {
        INIT, LATCH, DATA
    } state, nextState;
    
    always_ff @(posedge CLK) begin
        if (~nRST) begin
            state <= INIT;
        end
        else begin
            state <= nextState;
        end
    end
    
    always_comb begin
        case (state)
            INIT: begin
                if (~nWE && ~nCE) begin
                    nextState = (D[7] == 1) ? LATCH : DATA;
                end
                else begin
                    nextState = INIT;
                end
            end
            
            LATCH: begin
                nextState = INIT;
            end
            
            DATA: begin
                nextState = INIT;
            end
        endcase
    end
    
    always_comb begin
        case(state)
            INIT: begin
                if (~nWE && ~nCE) begin
                    READY = 0;
                    if (D[7] == 1) begin
                        channel = D[6:5];
                        latch = D[4];
                        storeD[3:0] = D[3:0];
                    end
                    else begin //D[7] == 0
                        storeD[5:0] = D[5:0];
                    end
                end
                else begin
                    READY = 1;
                end
            end
            LATCH: begin
                case(channel)
                    0: vol0 = storeD[3:0];
                    1: vol1 = storeD[3:0];
                    2: vol2 = storeD[3:0];
                    3: vol3 = storeD[3:0];
                endcase
            end
            DATA: begin
                case (channel)
                    0: tone0[3:0] = storeD[3:0];
                    1: tone1[3:0] = storeD[3:0];
                    2: tone2[3:0] = storeD[3:0];
                    3: noise = storeD[2:0];
                endcase    
            end
        endcase
    end
    
endmodule