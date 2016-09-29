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

// A module that, given an 8 bit PCM input, will output a 255-scale PWM. 
// Protocol:
// Pulse rst at the beginning to configure PCM_ack.
// User should push data to PCM_data, then activate PCM_valid.
// On next clock cycle, user should receive PCM_ack. 
// User must then de activate PCM_valid.
// Justification: This allows the user to set their own sample rate.
// To output silence, use the protocol to push 0x00.


module PCMtoPWM(
    input CLK100MHZ, rst,
    input PCM_valid,
    input [7:0] PCM_data,
    output PCM_ack,
    output PWM
    );
    
    logic [7:0] PCM_reg;
    logic [7:0] PCM_ctr;
    logic ack;
    logic out;
    
    assign PCM_ack = ack;
    assign PWM=out;
    
    always_ff@(posedge CLK100MHZ, posedge PCM_valid, negedge rst) begin
        //reset configures ack to 0 ,sets silence
        if(~rst) begin
            ack <= 1'b0;
            PCM_reg <= 8'b0;
        end
        //received valid pcm signal anc we haven't acknowledged it
        else if (PCM_valid && !ack) begin
            ack <=1'b1;
            PCM_reg <= PCM_data;
            PCM_ctr <= 0;
        end
        //outputting pwm
        //Z activates the PWM, 0 deactivates
        //note this isn't connected directly to the chip output
        else begin
            ack <= 1'b0;
            PCM_ctr <= PCM_ctr + 1;
            if(PCM_ctr < PCM_reg) begin
                out <= 1'bz;
            end
            else begin
                out <= 1'b0;
            end
        end
    end            

endmodule
