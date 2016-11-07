`timescale 1ns / 1ps

module ti_mixer(
    input logic CLK, nRST,
    input logic [3:0] vol0, vol1, vol2, vol3,
    input logic ch0out, ch1out, ch2out, ch3out, //Make sure ch3out is shift register out
    output logic [14:0] digital_out
);
    int volume_table[16] = {
        32767, 26028, 20675, 16422, 13045, 10362, 8231, 6568,
        5193, 4125, 3277, 2603, 2067, 1642, 1304, 0
    };
    
    logic [16:0] intermediate;
    
    always_ff @(posedge CLK) begin
        if (~nRST) begin
            intermediate <= 0;
        end
        else begin
            intermediate <= (ch0out * volume_table[vol0] + 
                            ch1out * volume_table[vol1] +
                            ch2out * volume_table[vol2] +
                            ch3out * volume_table[vol3]) / 4;
        end
    end
    
    assign digital_out = intermediate;

endmodule