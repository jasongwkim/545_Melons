module sega_genesis_top(
    input CLK100MHZ,
    input CPU_RESETN,
    input [15:0] SW,
    output AUD_PWM,
    output [15:0] LED 
);
    //logic CLK100MHZ, CPU_RESETN;
    //logic AUD_PWM;
    logic [4:0] divider;
    logic ti_nWE, ti_nCE, ti_CLK;
    logic [7:0] ti_D;
    logic ti_READY, ti_OUT;
    /*
    logic [19:0] ctr;
    logic [1:0] minictr;
    logic latch;
    logic pwm_out;
    */
    
    assign AUD_PWM = CPU_RESETN ? ti_OUT : 0;
    
    ti_top ti(.CLK(ti_CLK), .nRST(CPU_RESETN), .nWE(ti_nWE), .nCE(ti_nCE), .D(ti_D), .READY(ti_READY), .AOUT(ti_OUT));
    
    assign LED = SW;
    
    always_ff @(posedge CLK100MHZ, negedge CPU_RESETN) begin
        if (~CPU_RESETN) begin
            divider <= 0;
            ti_CLK <= 0;
            /*
            ctr <= 0;
            latch <= 0;
            minictr <= 0;
            */
        end
        else begin
            if (divider == 27) begin
                divider <= 0;
                ti_CLK <= 1;
            end
            else begin
                ti_CLK <= 0;
                divider <= divider + 1;
            end
            /* Play a basic A
            if (ctr == 113636) begin
                latch <= ~latch;
                ctr <= 0;
            end
            else begin
                ctr <= ctr + 1;
            end
            if (latch) begin
                if (minictr != 0) begin
                    pwm_out <= 1;
                end
                else begin
                    pwm_out <= 0;
                end
                minictr <= minictr + 1;
            end
            else begin
                pwm_out <= 0;
            end
            */
        end
    end
    
    assign ti_nWE = SW[15];
    assign ti_nCE = SW[14];
    assign ti_D = SW[7:0];
    
    /*
    initial begin
        CLK100MHZ <= 0;
        forever #5 CLK100MHZ <= ~CLK100MHZ;
    end
    
    initial begin
        CPU_RESETN <= 1;
        @(posedge CLK100MHZ);
        CPU_RESETN <= 0;
        @(posedge CLK100MHZ);
        CPU_RESETN <= 1;
        @(posedge ti_CLK);
        ti_nWE <= 1;
        ti_nCE <= 1;
        @(posedge ti_CLK);
        @(posedge ti_CLK);
        ti_nWE <= 0;
        ti_nCE <= 0;
        ti_D <= 8'b10001110;
        @(posedge ti_CLK); //IDLE
        @(posedge ti_CLK); //LATCH
        ti_D <= 8'b00001111;
        @(posedge ti_CLK); //IDLE
        @(posedge ti_CLK); //DATA
        ti_D <= 8'b10010000;
        @(posedge ti_CLK); //IDLE
        @(posedge ti_CLK); //LATCH
    end
    */
    
endmodule