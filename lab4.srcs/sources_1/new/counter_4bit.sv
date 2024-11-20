`timescale 1ns / 1ps


/*module counter_4bit(

    input logic CLK,             // Clock signal
    input logic CLR_N,           // Active-low asynchronous reset
    input logic EN,              // Enable signal
    input logic [3:0] load_data, // Data for parallel load
    input logic load,            // Load control signal
    input logic up_down,         // Up/Down control signal (0 = up, 1 = down)
    output logic [3:0] count     // Counter output
);

logic [3:0] D; // Intermediate signals for next count values

// Logic to calculate the next state for each bit
assign D[0] = load ? load_data[0] : (EN ? (up_down ? count[0] - 1 : count[0] + 1) : count[0]);
assign D[1] = load ? load_data[1] : (EN ? (up_down ? count[1] - (count[0] == 0) : count[1] + (count[0] == 1)) : count[1]);
assign D[2] = load ? load_data[2] : (EN ? (up_down ? count[2] - ((count[1:0] == 2'b00) ? 1 : 0) : count[2] + ((count[1:0] == 2'b11) ? 1 : 0)) : count[2]);
assign D[3] = load ? load_data[3] : (EN ? (up_down ? count[3] - ((count[2:0] == 3'b000) ? 1 : 0) : count[3] + ((count[2:0] == 3'b111) ? 1 : 0)) : count[3]);

// Flip-flop instances to store the state of the counter
DFF dff0 (.D(D[0]), .clk(CLK), .CLR_N(CLR_N), .Q(count[0]));
DFF dff1 (.D(D[1]), .clk(CLK), .CLR_N(CLR_N), .Q(count[1]));
DFF dff2 (.D(D[2]), .clk(CLK), .CLR_N(CLR_N), .Q(count[2]));
DFF dff3 (.D(D[3]), .clk(CLK), .CLR_N(CLR_N), .Q(count[3]));

endmodule
module Counter_behav#(
parameter N = 4
)(
    input logic clk,
    input logic [N-1:0] load_data, 
    input logic CLR_N,
    input logic EN,
    input logic load,
    input logic up_down,
    output logic [N-1:0] count 
    );
    always @(posedge clk or negedge CLR_N) begin
        if (!CLR_N) 
            count <= 0; 
        else if (load) 
            count <= load_data;
        else if (EN) begin
            if (up_down)
                count <= count - 1;
            else
                count <= count + 1;
        end
    end

endmodule*/


module counter_4bit(
input wire [3:0] d, //Data input
input wire BTNC,
input wire CPU_RESETN,
input wire En,
input wire load,
input wire up_down,
output wire [3:0]q
);
wire clk,reset;
wire En_reset;
wire [3:0] qnot,muxd;

assign clk = BTNC;
assign reset=CPU_RESETN;
assign En_clk=En&clk;
//

assign muxd[0]= load? d[0]:(up_down?qnot[0]:qnot[0]);
assign muxd[1]= load? d[1]:(up_down? q[1]^q[0]:q[1]~^q[0]);
assign muxd[2]= load? d[2]:(up_down?(q[2]&qnot[1])|(q[2]&qnot[0])|(qnot[2]&q[1]&q[0]):(q[2]&q[1])|(q[2]&q[0])|(qnot[2]&qnot[1]&qnot[0]));
assign muxd[3]= load? d[3]:(up_down?(q[3]&qnot[1])|(q[3]&qnot[0])|(q[3]&qnot[2]&q[0])|(qnot[3]&q[2]&q[1]&q[0]):(qnot[3]&qnot[2]&qnot[1]&qnot[0])|(q[3]&qnot[0])|(q[3]&q[2]&qnot[0])|(q[1]&q[3]));

  
//
DFF FF0(.d(muxd[0]),.CLK100MHZ(En_clk),.CPU_RESETN(reset),.q(q[0]),.qnot(qnot[0]));
DFF FF1(.d(muxd[1]),.CLK100MHZ(En_clk),.CPU_RESETN(reset),.q(q[1]),.qnot(qnot[1]));
DFF FF2(.d(muxd[2]),.CLK100MHZ(En_clk),.CPU_RESETN(reset),.q(q[2]),.qnot(qnot[2]));
DFF FF3(.d(muxd[3]),.CLK100MHZ(En_clk),.CPU_RESETN(reset),.q(q[3]),.qnot(qnot[3]));



endmodule


//THIS IS COUNTER BEHAVIORAL Comment one to test the other
module Counter_behav#(
parameter N = 4
)(
    input logic clk,
    input logic [N-1:0] load_data, 
    input logic CLR_N,
    input logic EN,
    input logic load,
    input logic up_down,
    output logic [N-1:0] count 
    );
    always @(posedge clk or negedge CLR_N) begin
        if (!CLR_N) 
            count <= 0; 
        else if (load) 
            count <= load_data;
        else if (EN) begin
            if (up_down)
                count <= count - 1;
            else
                count <= count + 1;
        end
    end

endmodule















