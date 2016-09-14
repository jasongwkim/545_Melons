module lab1_sim(
    output clk, sw[0],
    output [3:0] btn,
    input vga_hs, vga_vs,
    input [3:0] vga_r, vga_b, vga_g,
    input [3:0] led  
    );
    
    logic clock = 0;
    
    assign clk = clock;
    
    always begin 
        #5 clock = ~clock;
    end
    
    initial begin
        sw[0] = 1;
        btn[0] = 0;
        btn [1] = 0;
        @(posedge clock);
        btn[0] = 1;
        repeat(1000) @ (posedge clock);
    end
    
    
endmodule lab1_sim    