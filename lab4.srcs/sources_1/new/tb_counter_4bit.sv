`timescale 1ns / 1ps



module tb_counter_4bit;

logic CLK, CLR_N, EN, load, up_down;
logic [3:0] load_data;
logic [3:0] count;

counter_4bit uut (
    .CLK(CLK),
    .CLR_N(CLR_N),
    .EN(EN),
    .load_data(load_data),
    .load(load),
    .up_down(up_down),
    .count(count)
);

initial begin
    // Clock generation
    CLK = 0;
    forever #5 CLK = ~CLK; // 10 ns clock period
end

initial begin
    // Test sequence
    CLR_N = 0; EN = 0; load = 0; up_down = 0; load_data = 4'b0000;
    #10 CLR_N = 1; // Release reset
    #10 EN = 1; // Enable counting
    #50 up_down = 1; // Switch to down counting
    #50 load = 1; load_data = 4'b1010; // Load specific value
    #10 load = 0;
    #50 EN = 0; // Disable counting
    #10 CLR_N = 0; // Reset
    #10 CLR_N = 1; EN = 1; up_down = 0; // Restart counting up
    #100 $stop;
end

endmodule
















