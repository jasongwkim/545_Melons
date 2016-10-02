`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2016 02:45:14 PM
// Design Name: 
// Module Name: PCMtoPWM
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

// A module that, given a 16 bit PCM input, will output a 255-scale PWM. 
// Protocol:
// Pulse rst at the beginning to configure PCM_ack.
// User should push data to PCM_data, then activate PCM_valid.
// On next clock cycle, user should receive PCM_ack. 
// User must then de activate PCM_valid.
// Justification: This allows the user to set their own sample rate.
// To output silence, use the protocol to push 0x00.


module PCMtoPWM(
    input clk, rst,
    input PCM_valid,
    input [15:0] PCM_data,
    output PCM_ack,
    output PWM
    );
    
    logic signed [15:0] PCM_reg;
    logic signed [15:0] PCM_ctr;
    logic ack;
    logic out;
    
    assign PCM_ack = ack;
    assign PWM=out;
    
    enum{RST, SET_PWM, OUT_PWM} state, nextState;
    
    always_comb begin
        if(~rst) begin
            nextState = RST;
        end
        //received valid pcm signal anc we haven't acknowledged it
        else if(PCM_valid) begin
            nextState = SET_PWM;
        end 
        //outputting pwm
        //Z activates the PWM, 0 deactivates
        //note this isn't connected directly to the chip output
        else begin
            nextState = OUT_PWM;
        end
    end 
    
    always_ff@(posedge clk, posedge PCM_valid, negedge rst) begin
        //reset configures ack to 0 ,sets silence
        state <= nextState;
        case(state)
            OUT_PWM: begin
                ack <= 1'b0;
                PCM_ctr <= PCM_ctr + 16'd1;
                if(PCM_ctr < PCM_reg) begin
                    out <= 1'bz;
                end
                else begin
                    out <= 1'b0;
                end
            end
            SET_PWM: begin
                ack<=1'b1;
                PCM_ctr <= 16'b1000000000000000;
                PCM_reg <= PCM_data;
            end
            RST: begin
                ack <= 1'b0;
                PCM_reg <= 16'b1000000000000000;
                PCM_ctr <= 16'b1000000000000000;
            end
            default: begin
                ack <= 1'b0;
                PCM_reg <= 16'b1000000000000000;
                PCM_ctr <= 16'b1000000000000000;
            end
        endcase
    end
endmodule
