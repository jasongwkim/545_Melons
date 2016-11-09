module sega_genesis_top(
    input CLK100MHZ,
    input CPU_RESETN,
    input [3:0] SW,
    output logic AUD_PWM
);

    logic ti_nWE, ti_nCE;
    logic [7:0] ti_D;
    logic ti_READY, ti_OUT;

    ti_top ti(.CLK(CLK100MHZ), .nRST(CPU_RESETN), .nWE(ti_nWE), .nCE(ti_nCE), .D(ti_D), .READY(ti_READY), .AOUT(ti_OUT));
    
    always_ff @(posedge CLK100MHZ) begin
        
    end
    
endmodule