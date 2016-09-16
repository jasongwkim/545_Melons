module lab1_sim(  
    );
    
    logic clk, sw, btnC, btnU;
    logic [6:0] seg;
    logic [7:0] an, led;
    logic [15:0] sw;
    
    lab1 l1a(.clk(clk), .btnC(btnC), .btnU(btnU), .sw(sw), 
                   .seg(seg), .an(an), .led(led));
    
    always begin 
        #5 clk = ~clk;
    end
    
    initial begin
        sw = 1;
        btnU = 0;
        btnC = 0;
        @(posedge clk);
        btnU = 1;
        repeat(1000) @ (posedge clk);
    end
    
    
endmodule: lab1_sim    