`timescale 1ns / 1ps
/*
module multiplier_8bit (
    input logic clk,
    input logic reset,
    input logic start,
    input logic [7:0] x,
    input logic [7:0] y,
    output logic [15:0] product,
    output logic done
);
    logic [7:0] count;
    logic [15:0] accumulator;

    wire enable_count = (count < y);

    // Counter instance
    counter_8bit counter_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable_count),
        .count(count)
    );

    // Register instance
    register_8bit register_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable_count),
        .data_in(accumulator + x),
        .data_out(accumulator)
    );

    // Logic for product
    always_comb begin
        if (count == y)
            done = 1;
        else
            done = 0;

        product = accumulator;
    end
endmodule*/





































