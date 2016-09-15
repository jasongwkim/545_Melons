`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 545 Mellons 
// Engineer: Steve Jurcsek, Brad Powell, Jason Kim
// 
// Create Date: 09/12/2016 07:12:08 PM
// Design Name: Up/Down Controlled Counter
// Module Name: lab1
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


module lab1(
    input sys_clk_pin, SW[1:0], BTNC, BTNU,
    output VGA_HS, VGA_VS,
    output [3:0] VGA_R, VGA_B, VGA_G,
    output [7:0] LED  
    );
    
    logic hs, vs; 
    logic [3:0] count;
    logic [9:0] h_count;
    logic [23:0] v_count;
    
    enum {V_PULSE, V_FRONT, V_DISP, V_BACK} V_STATE;
    enum {H_PULSE, H_FRONT, H_DISP, H_BACK} H_STATE; 
    enum {UNPRESSED, PRESSED} B_STATE;
    
    assign LED[3:0] = count;
    assign LED[7:4] = 4'b1111; 
    assign VGA_HS = H_STATE != H_PULSE;
    assign VGA_VS = V_STATE != V_PULSE;
    assign VGA_R = (H_STATE == H_DISP) ? count : 0;
    assign VGA_B = (H_STATE == H_DISP) ? count : 0;
    assign VGA_G = (H_STATE == H_DISP) ? count : 0;
    
    
    always_ff @(posedge sys_clk_pin, posedge BTNU) begin
        if(BTNU) begin
            count = 0;
            v_count = 0;
            h_count = 0;
            B_STATE = UNPRESSED;
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
        
        if(v_count < 15) begin
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