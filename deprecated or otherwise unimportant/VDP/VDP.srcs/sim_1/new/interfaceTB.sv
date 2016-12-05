`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2016 03:31:04 PM
// Design Name: 
// Module Name: interfaceTB
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


module interfaceTB();
    
    logic clk;
    logic srst;
    
    VDP_int VDPbus(clk, srst); 
    VDP dut (VDPbus);
    
    initial begin
    clk = 1'b1;
    forever #5 clk = ~clk;
    end
    
    enum logic [5:0] {VRAM_W=6'b000001, CRAM_W=6'b000011,
                            VSRAM_W=6'b000101, VRAM_R=6'b000000,
                            CRAM_R=6'b001000, VSRAM_R=6'b000100} mode;
    
    
     
    
    task writeRegister(input logic [4:0] regNo,
                       input logic [7:0] data);
           VDPbus.controlRW_ <= 1'b0;                       
           VDPbus.control[15:13] <= 3'b100;
           VDPbus.control[12:8] <= regNo;
           VDPbus.control[7:0] <= data;
           @(posedge clk);
           VDPbus.controlRW_ <=1'b1;
    endtask 
                
                
    
    task accessRAM (input logic [5:0] operation,
                    input logic [15:0] addr,
                    input logic [15:0] data);
            VDPbus.controlRW_ <= 1'b0;
            VDPbus.dataRW_ <= 1'b0;
            VDPbus.control[15:14] <= operation[1:0];
            VDPbus.control[13:0] <= addr[13:0];
            VDPbus.data <= data;
            @(posedge clk);
            VDPbus.control[15:8] <= 8'h00;
            VDPbus.control[7:4] <= operation[5:2];
            VDPbus.control[15:8] <= 2'b00;
            VDPbus.control[15:8] <= addr[15:14];
            @(posedge clk);
            VDPbus.controlRW_ <= 1'b1;
            VDPbus.dataRW_ <= 1'b1;
    endtask
    
    initial begin
        @(posedge clk);
        writeRegister(5'b00111, 8'hBE);
        mode <= CRAM_W;
        @(posedge clk);
        accessRAM(mode, 16'hDEAD, 16'hBEEF);
        accessRAM(mode, 16'hBEEF, 16'hBEEF);
        mode <= VSRAM_R;
        @(posedge clk);
        accessRAM(mode, 16'hC0FF, 16'hEE00);
        
        
        $finish;
    end
    
endmodule
