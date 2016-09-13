`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 545 Mellons 
// Engineer: Steve Jurcsek, Brad Powell, Jason Kim
// 
// Create Date: 09/12/2016 07:12:08 PM
// Design Name: Up/Down Controlled Counter
// Module Name: lab1
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


module lab1(
    input btnCpuReset,
    input btnC,
    input sw[0],
    output Hsync, Vsync,
    output [3:0] vgaRed, vgaBlue, vgaGreen,
    output [7:0] led  
    );
    
    logic [7:0] count;
    
    assign ledCount = count; 
    assign vgaRed = count[3:0];
    assign vgaBlue = count[7:4] + count[3:0];
    assign vgaGreen = count[5:2] - count [7:6] + count[1:0];
    
    always_ff @(posedge btnC, negedge btnCpuReset) begin
        if(~btnCpuReset) begin
            count = 0;
        end
        else if(btnC) begin
            if(sw[0]) begin
                count <= count + 1;
            end
            else begin
                count <= count - 1;
            end
        end
    end
endmodule
