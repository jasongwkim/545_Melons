module sega_genesis_top(
    input CLK100MHZ,
    input CPU_RESETN,
    output [3:0] VGA_R, VGA_G, VGA_B,
    output VGA_HS, VGA_VS
);
    logic [4:0] vdp_A;
    logic [15:0] vdp_di, vdp_do;
    logic vdp_clk, vdp_sel, vdp_rnw, vdp_uds_n, vdp_lds_n, vdp_dtack_n;
    
    logic [14:0] VRAM_ADDR;
    logic [15:0] VRAM_DO, VRAM_DI;
    logic VRAM_CE_N, VRAM_UB_N, VRAM_LB_N, VRAM_OE_N, VRAM_WE_N;
    logic VRAM_SEL, VRAM_DTACK_N;
    
    logic INTERLACE;
    
    logic vdp_hint, vdp_hint_ack;
    
    logic VINT_TG68, VINT_T80, VINT_TG68_ACK, VINT_T80_ACK;
    
    logic [23:0] VBUS_ADDR;
    logic [15:0] VBUS_DATA;
    logic VBUS_DMA_REQ, VBUS_DMA_ACK;
    logic VBUS_UDS_N, VBUS_LDS_N;
    logic VBUS_SEL, VBUS_DTACK_N;
    
    logic Z80_clk, M68_clk;
    logic [4:0] clk_divider_Z80, clk_divider_M68;
    
    assign vdp_clk = Z80_clk;
    
    logic Z80_rd, Z80_wr, Z80_mreq;
    logic M68_rw, M68_as, M68_lds, M68_uds;
    logic [7:0] RAM_8_data_out;
    logic [15:0] RAM_16_data_out, Z80_addr, M68_data_out;
    logic [31:0] M68_addr;
    logic M68_dtack, Z80_busack, RAM_8_en, RAM_16_en, RAM_8_we, RAM_16_we, VDP_data_rw, VDP_control_rw;
    logic [7:0] RAM_8_data_in, VDP_data, VDP_control;
    logic [9:0] RAM_8_addr;
    logic [11:0] RAM_16_addr;
    logic [15:0] RAM_16_data_in, M68_data_in;
    reg [7:0] Z80_data;
    
    z80_top_direct_n z80(.nM1(), .nMREQ(Z80_mreq), .nIORQ(), .nRD(Z80_rd), .nWR(Z80_wr), .nRFSH(),
                         .nHALT(), .nBUSACK(Z80_busack), .nWAIT(), .nNMI(), .nRESET(CPU_RESETN),.nBUSRQ(),
                         .CLK(Z80_clk), .A(Z80_addr), .D(Z80_data));
                         
    DMA dm(.clk(M68_clk), .rst_n(CPU_RESETN), .Z80_rd, .Z80_wr, .Z80_mreq, .M68_rw, .M68_as, .M68_lds, .M68_uds,
           .RAM_8_data_out, .RAM_16_data_out, .Z80_addr, .M68_data_out, .M68_addr, .M68_dtack, .Z80_busack, 
           .RAM_8_en, .RAM_16_en, .RAM_8_we, .RAM_16_we, .VDP_data_rw, .VDP_control_rw, .RAM_8_data_in, .VDP_data, .VDP_control,
           .RAM_8_addr, .RAM_16_addr, .RAM_16_data_in, .M68_data_in, .Z80_data);
    
    TG68 M68(.clk(M68_CLK), .reset(CPU_RESETN), .clkena_in(1'b1), .data_in(M68_data_in), 
             .IPL(), .dtack(M68_dtack), .addr(M68_addr), .data_out(M68_data_out), 
             .as(M68_as), .uds(M68_uds), .lds(M68_lds), .rw(M68_rw), .enaRDreg(), .enaWReg(),
             .intack());
    
    blk_mem_gen_0 VRAM(.addra({VRAM_ADDR, 1'b0}), .clka(vdp_clk), .dina(VRAM_DI[15:8]), .douta(VRAM_DO[15:8]), .ena(~VRAM_UB_N && ~VRAM_CE_N), .wea(~VRAM_WE_N),
                       .addrb({VRAM_ADDR, 1'b1}), .clkb(vdp_clk), .dinb(VRAM_DI[7:0]), .doutb(VRAM_DO[7:0]), .enb(~VRAM_LB_N && ~VRAM_CE_N), .web(~VRAM_WE_N));
    
    vdp video(.CLK(vdp_clk), .RST_N(CPU_RESETN), .SEL(vdp_sel), .A(vdp_A), .RNW(vdp_rnw), .UDS_N(vdp_uds_n),
              .LDS_N(vdp_lds_n), .DI(vdp_di), .DO(vdp_do), // Might need to rename this since "do" is a sv keyword
              .DTACK_N(vdp_dtack_n), .VRAM_ADDR, .VRAM_CE_N, .VRAM_UB_N, .VRAM_LB_N, .VRAM_DO, .VRAM_DI,
              .VRAM_OE_N, .VRAM_WE_N, .VRAM_SEL, .VRAM_DTACK_N, .INTERLACE, .HINT(vdp_hint), .HINT_ACK(vdp_hint_ack),
              .VINT_TG68, .VINT_T80, .VINT_TG68_ACK, .VINT_T80_ACK, .VBUS_DMA_REQ, .VBUS_DMA_ACK, .VBUS_ADDR,
              .VBUS_UDS_N, .VBUS_LDS_N, .VBUS_DATA, .VBUS_SEL, .VBUS_DTACK_N, .VGA_R, .VGA_G, .VGA_B, .VGA_HS,
              .VGA_VS);
    
    enum logic [1:0] {
        IDLE, VRAM_OPERATING
    } state, nextState;
    
    always_ff @(posedge CLK100MHZ, negedge CPU_RESETN) begin
        if (~CPU_RESETN) begin
            clk_divider_Z80 <= 0;
            Z80_clk <= 0;
            clk_divider_M68 <= 0;
            M68_clk <= 0;
        end
        else begin
            if (clk_divider_Z80 == 27) begin //3.57 MHz
                clk_divider_Z80 <= 0;
                Z80_clk <= ~Z80_clk;
            end
            else begin
                clk_divider_Z80 <= clk_divider_Z80 + 1;
            end
            if (clk_divider_M68 == 13) begin //7.67 MHz
                clk_divider_M68 <= 0;
                M68_clk <= ~M68_clk;
            end
            else begin
                clk_divider_M68 <= clk_divider_M68 + 1;
            end
        end
    end
    
    always_comb begin // Next state logic
        case (state)
            IDLE: begin
                if (~VRAM_CE_N) begin //Read enable
                    nextState = VRAM_OPERATING;
                end
            end
            
            VRAM_OPERATING: begin
                nextState = IDLE;
            end
        endcase
    end
    
    always_comb begin // Output logic
        case (state)
            IDLE: begin
                VRAM_DTACK_N = 1;
            end
            VRAM_OPERATING: begin
                VRAM_DTACK_N = 0;
            end
        endcase
    end
    
endmodule