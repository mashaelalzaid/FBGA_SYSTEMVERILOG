`timescale 1ns / 1ps

module top_multiplier(
 
    input wire CLK100MHZ,       // Clock input
    input wire CPU_RESETN,      // Active-low reset input
    input wire [15:0] SW,       // Input switches (8 bits for x, 8 bits for y)
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment outputs
    output wire [7:0] AN        // Digit enable outputs
);

    // Clock and reset signals
    wire resetn = CPU_RESETN;
    wire clk = CLK100MHZ;

    // Signals for multiplier
    wire [7:0] x = SW[7:0];        // Lower 8 switches for x
    wire [7:0] y = SW[15:8];       // Upper 8 switches for y
    wire [15:0] product;           // Output product
    wire done;                     // Done signal (not used for display)

    // Instantiate the multiplier
    multiplier mult_inst (
        .clk(clk),
        .reset(~resetn),           // Convert active-low reset to active-high
        .x(x),
        .y(y),
        .product(product),
        .done(done)
    );

    // Digits for seven-segment display
    wire [3:0] digits [0:7];
    assign digits[0] = product[3:0];     // Least significant digit
    assign digits[1] = product[7:4];
    assign digits[2] = product[11:8];
    assign digits[3] = product[15:12];  // Most significant digit
    assign digits[4] = 4'b1111;         // Blank
    assign digits[5] = 4'b1111;         // Blank
    assign digits[6] = 4'b1111;         // Blank
    assign digits[7] = 4'b1111;         // Blank

    // Instantiate the seven-segment display module
    sev_seg sev_seg_inst (
        .CLK100MHZ(clk),
        .CPU_RESETN(resetn),
        .digits(digits),
        .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG), .DP(DP),
        .AN(AN)
    );

endmodule