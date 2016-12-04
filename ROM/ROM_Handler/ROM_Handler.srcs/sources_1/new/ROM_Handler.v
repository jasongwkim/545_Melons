`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2016 09:14:07 AM
// Design Name: 
// Module Name: ROM_Handler
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


module ROM_Handler(
    input wire clk, rst_n,
    input wire [7:0] ROM_data_1, ROM_data_2,
    input wire [23:0] addr, 
    input wire as,
    output wire [15:0] data, 
    output wire [18:0] ROM_addr_1, ROM_addr_2,
    output wire rd_en_1, rd_en_2, dtack
    );
    
    reg rq_flag;
    reg access_count;
    wire as;
    
    assign ROM_addr_1 = addr[18:0];
    assign ROM_addr_2 = addr[18:0]+1;
    
    assign rd_en_1 = as;
    assign rd_en_2 = as;
    
    assign data = {ROM_data_2, ROM_data_1};
    
    assign dtack = rq_flag;
        
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            access_count <= 0;
            rq_flag <= 0;
        end   
        else begin
            if(as) begin
                rq_flag <= 1;
                access_count <= 1;
            end
            else if(rq_flag) begin
                if (access_count == 3) begin
                    access_count <= 0;
                    rq_flag <= 0;
                end
                else begin
                    access_count <= access_count + 1;
                end    
            end
        end 
    end    
    
endmodule
