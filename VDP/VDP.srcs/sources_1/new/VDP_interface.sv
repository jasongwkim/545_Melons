`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2016 11:04:58 AM
// Design Name: 
// Module Name: VDP_interface
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


interface VDP_int (input clk);
    logic [15:0] data;
    logic [15:0] control;
    logic [15:0] HV_counter; 
endinterface: VDP_int


module VDP(VDP_int bus)
    
        enum logic [5:0]
        {
            
        } control_mode;
        
        assign control_mode = control[15:10];
        
        
        
        
        
    
    );
    
    
endmodule
