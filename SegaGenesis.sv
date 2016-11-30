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
    
    logic Z80_clk;
    logic [4:0] clk_divider;
    
    assign vdp_clk = Z80_clk;
    
    blk_mem_gen_0 VRAM(.addra(VRAM_ADDR), .clka(vdp_clk), .dina(VRAM_DI), .douta(VRAM_DO), .ena(~VRAM_CE_N), .wea(~VRAM_WE_N));
    
    vdp video(.CLK(vdp_clk), .RST_N(CPU_RESETN), .SEL(vdp_sel), .A(vdp_A), .RNW(vdp_rnw), .UDS_N(vdp_uds_n),
              .LDS_N(vdp_lds_n), .DI(vdp_di), .DO(vdp_do), // Might need to rename this since "do" is a sv keyword
              .DTACK_N(vdp_dtack_n), .VRAM_ADDR, .VRAM_CE_N, .VRAM_UB_N, .VRAM_LB_N, .VRAM_DO, .VRAM_DI,
              .VRAM_OE_N, .VRAM_WE_N, .VRAM_SEL, .VRAM_DTACK_N, .INTERLACE, .HINT(vdp_hint), .HINT_ACK(vdp_hint_ack),
              .VINT_TG68, .VINT_T80, .VINT_TG68_ACK, .VINT_T80_ACK, .VBUS_DMA_REQ, .VBUS_DMA_ACK, .VBUS_ADDR,
              .VBUS_UDS_N, .VBUS_LDS_N, .VBUS_DATA, .VBUS_SEL, .VBUS_DTACK_N, .VGA_R, .VGA_G, .VGA_B, .VGA_HS,
              .VGA_VS);
    
    always_ff @(posedge CLK100MHZ, negedge CPU_RESETN) begin
        if (~CPU_RESETN) begin
            clk_divider <= 0;
            Z80_clk <= 0;
        end
        else begin
            if (clk_divider == 27) begin
                clk_divider <= 0;
                Z80_clk <= ~Z80_clk;
            end
            else begin
                clk_divider <= clk_divider + 1;
            end
        end
    end
    
endmodule