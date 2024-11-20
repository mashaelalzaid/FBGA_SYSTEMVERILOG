`timescale 1ns / 1ps


module Register(
 input logic  [3:0] D,
 input logic clk,
 input logic RST_N,
             
 output logic [3:0] Q
    );
    //wires 
    logic w_Q3, w_Q2, w_Q1;
    logic temp_Q;
    logic [3:0] temp_Qbar;
    
    //instance 1 of DFF
    DFF dff_inst1(
             .D(D[3]),
             .clk(clk),
             .CLR_N(RST_N),
             .Q(Q[3]),
             .Qbar(temp_Qbar[3]));
             
             
    //instance 2 of DFF 
    DFF dff_inst2(
             .D(D[2]),
             .clk(clk),
             .CLR_N(RST_N),
             .Q(Q[2]),
             .Qbar(temp_Qbar[2]));
          

    //instance 3 of DFF 
    DFF dff_inst3(
             .D(D[1]),
             .clk(clk),
             .CLR_N(RST_N),
             .Q(Q[1]),
             .Qbar(temp_Qbar[1]));

          
    //instance 4 of DFF 
    DFF dff_inst4(
             .D(D[0]),
             .clk(clk),
             .CLR_N(RST_N),
             .Q(Q[0]),
             .Qbar(temp_Qbar[0]));

assign Q0 = Q;

endmodule
