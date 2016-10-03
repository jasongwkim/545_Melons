`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2016 12:19:16 AM
// Design Name: 
// Module Name: chipInterface
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


module chipInterface(
    input CLK100MHZ,
    input CPU_RESETN,
    input BTNC,
    input BTNU,
    input BTND,
    output AUD_PWM,
    output AUD_SD
    );
    
    
    logic [15:0] PCM_reg;
    logic PCM_ack;
    assign AUD_SD = 1'b1;
    
        
    
    PCMtoPWM mod (.clk(CLK100MHZ), .rst(CPU_RESETN), .PCM_valid(BTNC), .PCM_data(PCM_reg), .PCM_ack(PCM_ack), 
        .PWM(AUD_PWM)); 
        
    always_ff @(posedge CLK100MHZ) begin
        if(BTNU)
            PCM_reg <= 16'b1001000110111111;
        else if (BTND)
            PCM_reg <= 16'b0101010101111111;
    end
        
endmodule
