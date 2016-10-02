`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2016 03:21:10 PM
// Design Name: 
// Module Name: PCM_PWM_Testbench
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


module PCM_PWM_Testbench(
    output logic clk,
    output logic rst,
    output logic PCM_valid,
    output logic signed [15:0] PCM_data,
    input logic PCM_ack,
    input logic PWM
    );
    
    PCMtoPWM dut(.*);
    
    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
     end
     
     initial begin
        rst <= 1'b0;
        PCM_data <= 16'b1000000000000011;
        PCM_valid <= 1'b0;
        @(posedge clk);
        rst <= 1'b1;
        PCM_valid =1'b1;
        @(posedge clk);
        PCM_valid =1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        PCM_data <= 16'b1000000000001000;
        PCM_valid<= 1'b1;
        @(posedge clk);
        PCM_valid<=1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);                        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
     end  
       
endmodule
