`timescale 1ns / 1ps

module right_shift_register(
    input logic CLK,
    input logic nRST,
    input logic DATA_IN,
    output logic BIT_OUT,
    output logic [7:0] bitShiftReg); //Need outside module to access the register
    
    always @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            bitShiftReg <= 8'b10101010;
        end
        else begin
            bitShiftReg <= {DATA_IN, bitShiftReg[7:1]};
        end
    end

    assign BIT_OUT = bitShiftReg[0];
    
endmodule