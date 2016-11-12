module sega_genesis_top(
    input CLK100MHZ,
    input CPU_RESETN,
    input [15:0] SW,
    output logic AUD_PWM
);
    logic [4:0] divider;
    logic ti_nWE, ti_nCE, ti_CLK;
    logic [7:0] ti_D;
    logic ti_READY, ti_OUT;

    ti_top ti(.CLK(ti_CLK), .nRST(CPU_RESETN), .nWE(ti_nWE), .nCE(ti_nCE), .D(ti_D), .READY(ti_READY), .AOUT(ti_OUT));
    
    always_ff @(posedge CLK100MHZ) begin
        if (divider == 25) begin
            divider <= 0;
            ti_CLK <= 1;
            if (~CPU_RESETN) begin
                AUD_PWM <= 0;
            end
            else begin
                AUD_PWM <= ti_OUT;
            end
        end
        else begin
            ti_CLK <= 0;
            divider <= divider + 1; 
        end
    end
    
    assign ti_nWE = SW[15];
    assign ti_nCE = SW[14];
    assign ti_D = SW[7:0];
    
    /*
    initial begin
        ti_nWE <= 1;
        ti_nCE <= 1;
        @(posedge CLK100MHZ);
        ti_nWE <= 0;
        ti_nCE <= 0;
        ti_D <= 8'b10001110;
        @(posedge CLK100MHZ); //IDLE
        @(posedge CLK100MHZ); //LATCH
        ti_D <= 8'b00001111;
        @(posedge CLK100MHZ); //IDLE
        @(posedge CLK100MHZ); //DATA
        ti_D <= 8'b10010000;
        @(posedge CLK100MHZ);
        @(posedge CLK100MHZ);
        ti_D <= 8'b11100111;
        @(posedge CLK100MHZ);
    end*/
    
endmodule