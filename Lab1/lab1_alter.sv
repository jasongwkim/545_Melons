module lab1(
    input CLK100MHZ, BTNC, BTNU, UART_TXD_IN, UART_RTS,
    input SD_RESET,  
    input [1:0] SW,
    output SD_SCK, SD_CMD, SD_CD,
    output CA,CB,CC,CD,CE,CF,CG,
    output VGA_HS, VGA_VS, UART_RXD_OUT, UART_CTS, AUD_PWM, AUD_SD,
    output [3:0] VGA_R, VGA_B, VGA_G,
    output [7:0] AN, LED,
    inout [3:0] SD_DAT  
    );
    
    logic vga_clk, clk_div, pcm_valid, pcm_ack;
    logic sd_re, sd_we, sd_rd_ready, sd_wr_ready, sd_ready, sd_clk;
    logic fifo_wr_en, fifo_rd_en, fifo_full, fifo_empty, fifo_buf_place;
    logic [1:0] index;
    logic [3:0] count, sd_stat;
    logic [7:0] pcm_data, sd_out, sd_in, fifo_dout, fifo_din;
    logic [9:0] pcm_count, h_count;
    logic [13:0] fifo_count;
    logic [15:0] buf_pack;
    logic [23:0] v_count;
    logic [23:0] cycle_count;
    logic [31:0] sd_addr, addr_count;
    
    enum {UNPRESSED, PRESSED} B_STATE;
    enum {V_PULSE, V_FRONT, V_DISP, V_BACK} V_STATE;
    enum {H_PULSE, H_FRONT, H_DISP, H_BACK} H_STATE; 
    
    assign AUD_SD = 1;
    assign sd_we = 0;
    assign sd_wr_ready = 0;
    assign sd_in = 0;
    assign SD_RESET = 0;
    assign SD_DAT[1] = 0;
    assign SD_DAT[2] = 0;
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
    
    PCMtoPWM PtP(.clk(vga_clk), .rst(BTNC), .PCM_valid(pcm_valid), 
            .PCM_data(fifo_dout), .PCM_ack(pcm_ack), .PWM(AUD_PWM));
    sd_controller sdc(.cs(SD_DAT[3]), .mosi(SD_CMD), .miso(SD_DAT[0]),
            .sclk(SD_SCK), .rd(sd_re), .wr(sd_we), .reset(BTNU),
            .din(sd_in), .dout(sd_out), .byte_available(sd_rd_ready),
            .ready(sd_ready), .address(sd_addr), .clk(vga_clk), 
            .ready_for_next_byte(sd_wr_ready), .status(sd_state));
    fifo_generator_1 pwm_buffer(.clk(vga_clk), .srst(BTNC), .din(fifo_din), .wr_en(fifo_wr_en),
              .rd_en(fifo_rd_en), .dout(fifo_dout), .full(fifo_full), .empty(fifo_empty),
              .data_count(fifo_count));
    
    //50MHZ Clock Divider    
    always_ff @(posedge CLK100MHZ, negedge BTNU) begin
        if(BTNU) begin
            clk_div = 0;
        end
        else begin
            clk_div <= ~clk_div;
        end
    end
    
    //25MHZ Clock Divider
    always_ff @(posedge clk_div, negedge BTNU) begin
        if(BTNU) begin
            vga_clk <= 0;
        end
        else begin
            vga_clk <= ~vga_clk;
        end
    end
    
    //SSD Control FSM
    always_ff @(posedge CLK100MHZ, negedge BTNU) begin
        if(BTNU) begin
            index <= 0;
            count <= 0;
            cycle_count <= 0;
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
    
    //VGA Control FSM 
    always_ff @(posedge vga_clk, negedge BTNU) begin
        if(BTNU) begin
            v_count <= 0;
            h_count <= 0;
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
    
    //SD Control FSM
    always_ff @(posedge vga_clk, negedge BTNU) begin
        if(BTNU) begin
            sd_addr <= 0;
            addr_count <= 0;
            pcm_valid <= 0;
            fifo_buf_place <= 0;
            buf_pack <= 0;
        end
        else begin
            if(sd_ready) begin
                if(addr_count >= 511) begin
                    addr_count <= 0;
                    sd_addr <= 0;
                    if(fifo_count > 512) begin
                        sd_re <= 0;
                    end 
                    else begin
                        sd_re <= 1;
                    end
                end
                else begin
                    if(sd_rd_ready) begin
                        addr_count <= addr_count + 1;
                        if(~fifo_buf_place) begin
                            buf_pack[7:0] <= sd_out; 
                        end
                        else begin
                            buf_pack[15:8] <= sd_out;
                            fifo_rd_en <= 1;
                            fifo_din <= (sd_re) ? buf_pack : 0;
                        end
                        fifo_buf_place = ~fifo_buf_place;
                    end
                    else begin
                        fifo_rd_en <= 0;
                    end       
                end
            end
        end
    end
    
    always_ff @(posedge vga_clk, negedge BTNU) begin
        if(BTNU) begin
            fifo_wr_en <= 0;
            pcm_valid <= 0;
            pcm_count <= 0;
        end
        else begin
            
            if(pcm_count >= 566) begin
                pcm_count <= 0;
                pcm_valid <= 1;
                fifo_wr_en <= 1;
            end
            else begin
                pcm_count <= pcm_count + 1;
                pcm_valid <= 0;  
                fifo_wr_en <= 0;              
            end
        end
    end
    
    //VGA State Control
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