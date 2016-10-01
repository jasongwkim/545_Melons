module lab1(
    input CLK100MHZ, BTNC, BTNU,
    input [1:0] SW,
    output CA,CB,CC,CD,CE,CF,CG,
    output VGA_HS, VGA_VS,
    output [3:0] VGA_R, VGA_B, VGA_G,
    output [7:0] AN, LED  
    );
    
    logic vga_clk, clk_div;
    logic [1:0] index;
    logic [3:0] count;
    logic [9:0] h_count;
    logic [23:0] v_count;
    logic [23:0] cycle_count;
    
    enum {UNPRESSED, PRESSED} B_STATE;
    enum {V_PULSE, V_FRONT, V_DISP, V_BACK} V_STATE;
    enum {H_PULSE, H_FRONT, H_DISP, H_BACK} H_STATE; 
    
    assign LED[3:0] = count;
    assign LED[7:4] = 4'b1111;
    assign AN[7:4] = 4'b1111;
    assign {CG,CF,CE,CD,CC,CB,CA} = (count[index]) ? 7'b1111001 : 7'b1000000;
    assign AN[3:0] = (BTNU) ? 4'b0000 : ~(1 << index);

    assign VGA_HS = H_STATE == H_DISP;
    assign VGA_VS = V_STATE == V_DISP;
    assign VGA_R = (H_STATE == H_DISP) ? count : 0;
    assign VGA_B = (H_STATE == H_DISP) ? count : 0;
    assign VGA_G = (H_STATE == H_DISP) ? count : 0;
        
    always_ff @(posedge CLK100MHZ, negedge BTNU) begin
        if(BTNU) begin
            clk_div = 0;
        end
        else begin
            clk_div <= ~clk_div;
        end
    end
    
    always_ff @(posedge clk_div, negedge BTNU) begin
        if(BTNU) begin
            vga_clk = 0;
        end
        else begin
            vga_clk <= ~vga_clk;
        end
    end
    
    always_ff @(posedge CLK100MHZ, negedge BTNU) begin
        if(BTNU) begin
            index = 0;
            count = 0;
            cycle_count = 0;
        end
        else begin
            case(B_STATE) 
                UNPRESSED: begin
                    if(BTNC) begin
                        B_STATE <= PRESSED;
                        if(SW[0]) begin
                            count <= count + 1;
                        end
                        else begin
                            count <= count - 1;
                        end
                    end
                end
                PRESSED: begin
                    if(~BTNC) begin
                        B_STATE <= UNPRESSED;
                    end
                end
            endcase
            if(cycle_count < 99999) begin
                cycle_count <= cycle_count + 1;
            end
            else begin
                cycle_count <= 0;
            end
            case(cycle_count) 
                24999: index <= 1;
                49999: index <= 2;
                74999: index <= 3;
                99999: index <= 0;
            endcase
        end
    end
     
    always_ff @(posedge vga_clk, negedge BTNU) begin
        if(BTNU) begin
            v_count = 0;
            h_count = 0;
        end
        else begin
            if(v_count < 416799) begin
                v_count <= v_count + 1;
            end
            else begin
                v_count <= 0;
            end
            
            if(h_count < 799 && V_STATE == V_DISP) begin
                h_count <= h_count + 1;
            end
            else begin
                h_count <= 0;
            end
        end
    end
    
    always_comb begin
        if(v_count < 7999) begin
            V_STATE = V_FRONT;
        end
        else if(v_count < 9599) begin
            V_STATE = V_PULSE;
        end
        else if(v_count < 32799) begin
            V_STATE = V_BACK;
        end
        else begin
            V_STATE = V_DISP;
        end 
        
        if(h_count < 15) begin
            H_STATE = H_FRONT;
        end
        else if(h_count < 111) begin
            H_STATE = H_PULSE;
        end
        else if(h_count < 159) begin
            H_STATE = H_BACK;
        end
        else begin
            H_STATE = H_DISP;
        end 
    end  
endmodule