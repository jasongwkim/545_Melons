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
    input clk, sw[0],
    input [3:0] btn,
    output vga_hs, vga_vs,
    output [3:0] vga_r, vga_b, vga_g,
    output [3:0] led  
    );
    
    logic hs, vs; 
    logic [3:0] count;
    logic [9:0] h_count;
    logic [23:0] v_count;
    
    enum {V_PULSE, V_SYNC} V_STATE;
    enum {H_PULSE, H_SYNC} H_STATE; 
    
    assign led = count; 
    assign vga_hs = hs;
    assign vga_vs = vs;
    assign vga_r = count[3:0];
    assign vga_b = count[3:0];
    assign vga_g = count[3:0];
    
    
    always_ff @(posedge clk, negedge btn[0]) begin
        if(~btn[0]) begin
            count = 0;
            v_count = 0;
            h_count = 0;
            hs = 0;
            vs = 0;
            V_STATE = V_PULSE;
            H_STATE = H_PULSE;
        end
        else begin
            if(v_count < 833599) begin
                v_count <= v_count + 1;
            end
            else begin
                v_count <= 0;
            end
            
            case(V_STATE)
                V_PULSE: begin
                    if(v_count < 3199) begin
                        hs <= 0;
                        vs <= 0; 
                        h_count <= 0;           
                    end
                    else begin
                        V_STATE <= V_SYNC;
                    end
                end
                V_SYNC: begin
                    if(h_count < 1599) begin
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
        
            if(btn[1]) begin
                if(sw[0]) begin
                    count <= count + 1;
                end
                else begin
                    count <= count - 1;
                end
            end
        end
    end
    
endmodule
