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


interface VDP_int (input clk, srst);
    logic [15:0] data;
    logic [15:0] control;
    logic [15:0] HV_counter;
    logic dataRW_, controlRW_; 
endinterface


module VDP(
    input  logic clk, srst,
    input  logic [15:0] data,
    input  logic [15:0] control,
    output logic [15:0] HV_counter,
    input  logic dataRW_, controlRW);
    
    enum logic [3:0] {READ, WRITE1, WRITE2_1,WRITE2_2, WRITE2_3} control_state, next_control_state;
    //Note: Write1 is reg. Write2 is memory
    
    logic [7:0] register[25]; //0-23 are write only, 24 is read only (control) 
    
    
    //CONTROL state 
    always_comb begin
        if (control_state == WRITE2_1) begin
            next_control_state <= WRITE2_2;
        end
        else if(control_state == WRITE2_2) begin
            next_control_state <= WRITE2_3;
        end
        else if (bus.control[15:13] == 3'b100) begin
            next_control_state <= WRITE1;
        end
        else if(~bus.controlRW_) begin
            next_control_state <= WRITE2_1;
        end
        else begin
            next_control_state <= READ;
        end
    end
    
    always_ff@(posedge bus.clk) begin
        control_state <= next_control_state;
    end
    
    
    //Write1 aka Register Write    
    logic [12:8] reg_no;
    assign reg_no = bus.data[12:8];
    
    always_ff @(posedge bus.clk) begin
        if(control_state == WRITE1 && reg_no != 5'b11001) begin
            register[reg_no] <= bus.data[7:0];
        end
    end
    
    //Write2 aka RAM read/write
    enum logic [5:0] {VRAM_W=6'b000001, CRAM_W=6'b000011,
                        VSRAM_W=6'b000101, VRAM_R=6'b000000,
                        CRAM_R=6'b001000, VSRAM_R=6'b000100} mode;
    enum logic {RAM_WRITE=1'b1, RAM_READ=1'b0} RAMrW;
    logic [15:0] addr, RAM_write_buf;
    
    
    logic [37:0] RAM_access_input_frame;
    logic [37:0] RAM_access_output_frame;
    logic FIFO_read, FIFO_write, FIFO_full, FIFO_empty, FIFO_valid;
    
    RAM_access_FIFO fifo(.clk(bus.clk), .srst(bus.srst), .din(RAM_access_input_frame),
        .dout(RAM_access_output_frame), .full(FIFO_full), .empty(FIFO_empty),
        .valid(FIFO_valid), .rd_en(FIFO_read), .wr_en(FIFO_write));
        
    assign RAM_access_input_frame[37:32] = mode;
    assign RAM_access_input_frame[32:16] = addr;
    assign RAM_access_input_frame[15:0] = RAM_write_buf;    
        
    
    always_ff @(posedge bus.clk) begin
        if(control_state == WRITE2_1) begin
            mode[1:0] <= bus.control[15:14];
            addr[13:0] <= bus.control[13:0];
            RAM_write_buf <= bus.data;
        end
        else if (control_state == WRITE2_2) begin
            mode[5:2] <= bus.control[7:4];
            addr[15:14] <= bus.control[1:0];
            FIFO_write <= 1'b1;   
        end
        else if(control_state == WRITE2_3) begin
            FIFO_write <= 1'b0; 
        end
    end
        
endmodule