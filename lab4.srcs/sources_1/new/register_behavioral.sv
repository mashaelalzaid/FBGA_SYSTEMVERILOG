`timescale 1ns / 1ps


module register_behavioral(
input logic clk,
input logic [3:0] D,
input logic reset_n,
input logic en,
output logic [3:0] Q
    );
    
 always @(posedge clk, negedge reset_n)
 begin 
 if(!reset_n) Q<= 0;
 else if (en) Q<= D;
 end
    
endmodule
