module lab1(
    input CLK100MHZ, BTNC, BTNU,
    input [1:0] SW,
    output  CA,CB,CC,CD,CE,CF,CG,
    output [7:0] AN, LED  
    );
    
    logic [1:0] index;
    logic [3:0] count;
    logic [23:0] cycle_count;
    
    enum {UNPRESSED, PRESSED} B_STATE;
    
    assign LED[3:0] = count;
    assign LED[7:4] = 4'b1111;
    assign AN[7:4] = 4'b1111;
    assign {CG,CF,CE,CD,CC,CB,CA} = (count[index]) ? 7'b1111001 : 7'b1000000;
    assign AN[3:0] = (BTNU) ? 4'b0000 : ~(1 << index);
    
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
     
    
endmodule