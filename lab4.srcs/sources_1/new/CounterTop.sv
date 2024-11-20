`timescale 1ns / 1ps


module CounterTop(

    input wire CLK100MHZ,    // 100 MHz clock input
    input wire CPU_RESETN,   // Active-low reset input
    input wire [3:0] SW,     // Switches for load data
    input wire LOAD,         // Load signal
    input wire EN,           // Enable signal
    input wire UP_DOWN,      // Up/Down control signal
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment outputs
    output wire [7:0] AN     // Digit enable outputs
);

    logic [3:0] count; // 4-bit counter output
    logic [3:0] digit0; // Current digit value for seven-segment display
    logic [3:0] unused_digit [7:1]; // Unused digits tied to zero

    // Instantiate the Counter module
    counter_4bit  counter_inst (
        .CLK(CLK100MHZ),       // Connect the 100 MHz clock
        .CLR_N(CPU_RESETN),    // Connect the reset signal
        .EN(EN),               // Connect enable signal
        .load_data(SW),        // Use switches as load data
        .load(LOAD),           // Connect load signal
        .up_down(UP_DOWN),     // Connect up/down control
        .count(count)          // Counter output
    );

    // Assign counter output to the first digit
    assign digit0 = count;

    // Tie unused digits to 0
    assign unused_digit[1] = 4'd0;
    assign unused_digit[2] = 4'd0;
    assign unused_digit[3] = 4'd0;
    assign unused_digit[4] = 4'd0;
    assign unused_digit[5] = 4'd0;
    assign unused_digit[6] = 4'd0;
    assign unused_digit[7] = 4'd0;

    // Flatten the digits array for sev_seg compatibility
    wire [3:0] digits [0:7];
    assign digits[0] = digit0;
    assign digits[1] = unused_digit[1];
    assign digits[2] = unused_digit[2];
    assign digits[3] = unused_digit[3];
    assign digits[4] = unused_digit[4];
    assign digits[5] = unused_digit[5];
    assign digits[6] = unused_digit[6];
    assign digits[7] = unused_digit[7];

    // Instantiate the sev_seg module
    sev_seg sev_seg_inst (
        .CLK100MHZ(CLK100MHZ), // Connect the 100 MHz clock
        .CPU_RESETN(CPU_RESETN), // Connect the reset signal
        .digits(digits),       // Connect the digits array
        .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG), .DP(DP), // Segment outputs
        .AN(AN)                // Digit enable outputs
    );

endmodule