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
    input clk, sw[0], btnC, btnU,
    output Hsync, Vsync,
    output [3:0] vgaRed, vgaBlue, vgaGreen,
    output [7:0] led  
    );
    
    logic hs, vs; 
    logic [3:0] count;
    logic [9:0] h_count;
    logic [23:0] v_count;
    
    enum {V_PULSE, V_SYNC} V_STATE;
    enum {H_PULSE, H_SYNC} H_STATE; 
    enum {UNPRESSED, PRESSED} B_STATE;
    
    assign led[3:0] = count;
    assign led[7:4] = 4'b1111; 
    assign Hsync = hs;
    assign Vsync = vs;
    assign vgaRed = count[3:0];
    assign vgaBlue = count[3:0];
    assign vgaGreen = count[3:0];
    
    
    always_ff @(posedge clk, negedge btnU) begin
        if(~btnU) begin
            count = 0;
            v_count = 0;
            h_count = 0;
            hs = 0;
            vs = 0;
            V_STATE = V_PULSE;
            H_STATE = H_PULSE;
            B_STATE = UNPRESSED;
        end
        else begin
            if(v_count < 416799) begin
                v_count <= v_count + 1;
            end
            else begin
                v_count <= 0;
            end
            
            case(V_STATE)
                V_PULSE: begin
                    if(v_count < 1699) begin
                        hs <= 0;
                        vs <= 0; 
                        h_count <= 0;           
                    end
                    else begin
                        V_STATE <= V_SYNC;
                    end
                end
                V_SYNC: begin
                    if(h_count < 799) begin
                        h_count <= h_count + 1;
                    end
                    else begin
                        h_count <= 0;
                    end
                    
                    case(H_STATE) 
                        H_PULSE: begin
                            hs <= 0;
                        end
                        H_STATE: begin
                            if(h_count < 1599) begin
                                hs <= 1;
                            end
                            else begin
                                hs <= 0;
                                H_STATE <= H_PULSE;
                            end
                        end
                    endcase
                
                    if(v_count < 833599) begin
                        vs <= 1;
                    end
                    else begin
                        vs <= 0;
                        V_STATE <= V_PULSE;
                    end
                end
            endcase
        
            case(B_STATE) 
                UNPRESSED: begin
                    if(btnC) begin
                        B_STATE <= PRESSED;
                        if(sw[0]) begin
                            count <= count + 1;
                        end
                        else begin
                            count <= count - 1;
                        end
                    end
                end
                PRESSED: begin
                    if(~btnC) begin
                        B_STATE <= UNPRESSED;
                    end
                end
            endcase
        end
    end
    
endmodule
