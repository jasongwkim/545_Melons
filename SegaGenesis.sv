module sega_genesis_top(
    input CLK100MHZ,
    input CPU_RESETN
);
    logic vdp_clk, vdp_sel, vdp_A, vdp_rnw, vdp_uds_n, vdp_lds_n, vdp_di, vdp_do, vdp_dtack_n;
    logic VRAM_ADDR, VRAM_CE_N, VRAM_UB_N, VRAM_LB_N, VRAM_DO, VRAM_D1, VRAM_OE_N, VRAM_WE_N;
    logic VRAM_SEL, VRAM_DTACK_N;
    logic INTERLACE;
    logic vdp_hint, vdp_hint_ack;
    logic VINT_TG68, VINT_T80, VINT_TG68_ACK, VINT_T80_ACK;
    logic VBUS_DMA_REQ, VBUS_DMA_ACK;
    logic VBUS_ADDR, VBUS_UDS_N, VBUS_LDS_N, VBUS_DATA;
    logic VBUS_SEL, VBUS_DTACK_N;
    logic VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS;
    
    vdp video(.CLK(vdp_clk), .RST_N(CPU_RESETN), .SEL(vdp_sel), .A(vdp_A), .RNW(vdp_rnw), .UDS_N(vdp_uds_n),
              .LDS_N(vdp_lds_n), .DI(vdp_di), .DO(vdp_do), // Might need to rename this since "do" is a sv keyword
              .DTACK_N(vdp_dtack_n), .VRAM_ADDR, .VRAM_CE_N, .VRAM_UB_N, .VRAM_LB_N, .VRAM_DO, .VRAM_DI,
              .VRAM_OE_N, .VRAM_WE_N, .VRAM_SEL, .VRAM_DTACK_N, .INTERLACE, .HINT(vdp_hint), .HINT_ACK(vdp_hint_ack),
              .VINT_TG68, .VINT_T80, .VINT_TG68_ACK, .VINT_T80_ACK, .VBUS_DMA_REQ, .VBUS_DMA_ACK, .VBUS_ADDR,
              .VBUS_UDS_N, .VBUS_LDS_N, .VBUS_DATA, .VBUS_SEL, .VBUS_DTACK_N, .VGA_R, .VGA_G, .VGA_B, .VGA_HS,
              .VGA_VS);
    
    always_ff @(posedge CLK100MHZ, negedge CPU_RESETN) begin
        if (~CPU_RESETN) begin
            
        end
        else begin
            
        end
    end
    
endmodule