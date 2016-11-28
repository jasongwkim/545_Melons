`timescale 1ns / 1ps

module ym2612(
    input logic [7:0] addr1, addr2,
    input logic [7:0] data1, data2,
    input logic CLK, nRST,
    input logic nIRQ,
    inout logic [7:0] DATA,
    output logic nIC, nCS, nWR, nRD, A0, A1 
);
    assign DATA = 0;
    
    logic [7:0] addr1prev, addr2prev, data1prev, data2prev;
    logic [2:0] counter;
    
    enum logic [1:0] {
        WAITING, STATUS, OPERATECH1, OPERATECH2
    } state, nextState;
    
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            nIC <= 1;
            nCS <= 1;
            nWR <= 1;
            nRD <= 1;
            A0 <= 0;
            A1 <= 0;
            counter <= 0;
            addr1prev <= 0;
            addr2prev <= 0;
            data1prev <= 0;
            data2prev <= 0;
            state <= WAITING;
        end
        else begin
            state <= nextState;
            
        end
    end
    
    always_comb begin
        case (state)
            WAITING: begin
            end
            STATUS: begin
                if (DATA[7] == 1) begin
                    nextState = WAITING;
                end
                else if (A1 == 0) begin
                    nextState = OPERATECH1;
                end
                else begin
                    nextState = OPERATECH2;
                end
            end
        endcase
    end
    
    always_comb begin
        case (state)
            WAITING: begin
                if (addr1prev != addr1 || data1prev != data1) begin
                    nCS = 0;
                    nRD = 0;
                    nWR = 1;
                    A0 = 1;
                    A1 = 0;
                end
                else if (addr2prev != addr2 || data2prev != data2) begin
                    nCS = 0;
                    nRD = 0;
                    nWR = 1;
                    A0 = 1;
                    A1 = 1;
                end
                else begin
                    nCS = 1;
                end
            end
            
            STATUS: begin
            
            end
        endcase
    end

endmodule