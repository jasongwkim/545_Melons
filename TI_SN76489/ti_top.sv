`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2016 11:23:37 AM
// Design Name: 
// Module Name: ti_top
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

module ti_top(
    input logic nWE, nCE,
    input logic CLK, nRST,
    input logic [7:0] D,
    output logic READY, AOUT);
    
    logic [3:0] clkDivider;
    logic [3:0] vol0, vol1, vol2, vol3;
    logic [9:0] tone0, tone1, tone2;
    logic [2:0] noise;
    logic [1:0] channel;
    logic latch;
    
    logic [5:0] storeD;
    
    logic [9:0] counter0, counter1, counter2, counter3;
    logic ch0out, ch1out, ch2out, ch3out;
    logic [7:0] shiftRegister;
    logic shift_data_in, shift_data_out;
    logic [14:0] digital_out;
    logic [5:0] digital_storage, pwm_counter;
    
    enum logic [1:0] {
        INIT, LATCH, DATA
    } state, nextState;
    
    right_shift_register rsr(.CLK(ch3out), .nRST, .DATA_IN(shift_data_in), .BIT_OUT(shift_data_out), .bitShiftReg(shiftRegister));
    
    ti_mixer mix(.CLK, .nRST, .vol0, .vol1, .vol2, .vol3, .ch0out, .ch1out,
                 .ch2out, .ch3out(shift_data_out), .digital_out);
    
    assign shift_data_in = noise[2] ? (shiftRegister[3] ^ shiftRegister[0]) : shiftRegister[0]; 
    
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            state <= INIT;
            clkDivider <= 0;
            counter0 <= 0;
            counter1 <= 0;
            counter2 <= 0;
            counter3 <= 0;
            pwm_counter <= 0;
            ch0out <= 0;
            ch1out <= 0;
            ch2out <= 0;
            ch3out <= 0;
            vol0 <= 4'b1111;
            vol1 <= 4'b1111;
            vol2 <= 4'b1111;
            vol3 <= 4'b1111;
            tone0 <= 10'b1111111111;
            tone1 <= 10'b1111111111;
            tone2 <= 10'b1111111111;
            noise <= 3'b111;
        end
        else begin
            if (pwm_counter == 0) begin
                digital_storage <= digital_out[14:9];
                AOUT <= 1;
            end
            else if (pwm_counter == digital_storage) begin
                AOUT <= 0;
            end
            pwm_counter <= pwm_counter + 1;
            state <= nextState;
            if (clkDivider == 0) begin
                if (counter0 == 0) begin
                    counter0 <= tone0;
                    ch0out <= ~ch0out;
                end
                else begin
                    counter0 <= counter0 - 1;
                end
                if (counter1 == 0) begin
                    counter1 <= tone1;
                    ch1out <= ~ch1out;
                end
                else begin
                    counter1 <= counter1 - 1;
                end
                if (counter2 == 0) begin
                    counter2 <= tone2;
                    ch2out <= ~ch2out;
                end
                else begin
                    counter2 <= counter2 - 1;
                end
                if (counter3 == 0) begin
                    case (noise[1:0])
                        2'b00: counter3 <= 10'b0000010000;
                        2'b01: counter3 <= 10'b0000100000;
                        2'b10: counter3 <= 10'b0001000000;
                        2'b11: counter3 <= tone2;
                    endcase
                    ch3out <= ~ch3out;
                end
                else begin
                    counter3 <= counter3 - 1;
                end
            end
            clkDivider <= clkDivider + 1;
        end
    end
    
    always_comb begin
        case (state)
            INIT: begin
                if (~nWE && ~nCE) begin
                    nextState = (D[7] == 1) ? LATCH : DATA;
                end
                else begin
                    nextState = INIT;
                end
            end
            
            LATCH: begin
                nextState = INIT;
            end
            
            DATA: begin
                nextState = INIT;
            end
        endcase
    end
    
    always_comb begin
        case(state)
            INIT: begin
                if (~nWE && ~nCE) begin
                    READY = 0;
                    if (D[7] == 1) begin
                        channel = D[6:5];
                        latch = D[4];
                        storeD[3:0] = D[3:0];
                    end
                    else begin //D[7] == 0
                        storeD[5:0] = D[5:0];
                    end
                end
                else begin
                    READY = 1;
                end
            end
            LATCH: begin
                READY = 0;
                if (latch) begin
                    case(channel)
                        0: vol0 = storeD[3:0];
                        1: vol1 = storeD[3:0];
                        2: vol2 = storeD[3:0];
                        3: vol3 = storeD[3:0];
                    endcase
                end
                else begin
                    case(channel)
                        0: tone0[3:0] = storeD[3:0];
                        1: tone1[3:0] = storeD[3:0];
                        2: tone2[3:0] = storeD[3:0];
                        3: noise = storeD[2:0];
                    endcase
                end
            end
            DATA: begin
                READY = 0;
                if (~latch) begin
                    case (channel)
                        0: tone0[9:4] = storeD[5:0];
                        1: tone1[9:4] = storeD[5:0];
                        2: tone2[9:4] = storeD[5:0];
                        3: noise = storeD[2:0];
                    endcase   
                end 
            end
        endcase
    end
    
endmodule