`timescale 1ns / 1ps


module ClockDevider#(


parameter N = 100 
) (
    input logic clk,        
    input logic rst,        
    output logic [$clog2(N)-1:0] count 
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0; 
        end else if (count == N-1) begin
            count <= 0; 
        end else begin
            count <= count + 1; 
        end
    end

endmodule