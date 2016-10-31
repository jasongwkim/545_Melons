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
    logic [9:0] tone0, tone1, tone2, tone3;
    logic [2:0] noise;
    logic latch;
    
    enum logic [1:0] {
        INIT, etc
    } state, nextState;
    
    always_ff @(posedge CLK) begin
        if (~nRST) begin
            state <= INIT;
        end
    end
    
endmodule