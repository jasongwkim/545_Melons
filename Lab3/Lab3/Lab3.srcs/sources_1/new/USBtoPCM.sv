`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2016 05:13:29 PM
// Design Name: 
// Module Name: USBtoPCM
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


module USBtoPCM(
    input clk,
    input UART_TXD_IN,
    output UART_RXD_OUT,
    input UART_CTS,
    output UART_RTS,
    output PCM_valid,
    output [7:0] PCM_data
    );
    
endmodule
