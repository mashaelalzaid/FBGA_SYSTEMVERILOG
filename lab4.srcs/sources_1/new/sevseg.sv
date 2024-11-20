`timescale 1ns / 1ps

module sevseg #(
       parameter display_speed = 18 // Adjusted for ~60Hz refresh rate
)(
    input wire clk,              // System clock
    input wire resetn,           // Active-low reset
    input wire [15:0] product,   // 16-bit input data to display
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment segments
    output reg [7:0] AN          // Active digit selectors
);

    // Internal signals
    reg [display_speed - 1:0] refresh_counter; // Counter for digit refresh rate
    reg [2:0] current_digit;                  // Current active digit (0-3)
    reg [3:0] digits [0:3];                   // Array for 4 digits (4 bits each)
    reg [3:0] digit_value;                    // Current digit value
    reg [6:0] segments;                       // Current segment signals

    // Map the 16-bit product to 4 digits (4 bits each)
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            digits[0] <= 4'd0;  // Least significant digit
            digits[1] <= 4'd0;
            digits[2] <= 4'd0;
            digits[3] <= 4'd0;  // Most significant digit
        end else begin
            digits[0] <= product[3:0];
            digits[1] <= product[7:4];
            digits[2] <= product[11:8];
            digits[3] <= product[15:12];
        end
    end

    // Refresh the active digit at ~60Hz per digit
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            refresh_counter <= 0;
            current_digit <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
            if (refresh_counter == (1 << display_speed) - 1) begin
                refresh_counter <= 0;
                current_digit <= current_digit + 1;
                if (current_digit == 3)  // Cycle through 4 digits
                    current_digit <= 0;
            end
        end
    end

    // Select the active digit and digit value
    always_comb begin
        AN = 8'b1111_1111;          // Default: all digits off
        AN[current_digit] = 0;      // Activate the current digit
        digit_value = digits[current_digit]; // Select the corresponding digit value
    end

    // Seven-segment decoding for the selected digit
    always_comb begin
        case (digit_value)
            4'h0: segments = 7'b100_0000; // 0
            4'h1: segments = 7'b111_1001; // 1
            4'h2: segments = 7'b010_0100; // 2
            4'h3: segments = 7'b011_0000; // 3
            4'h4: segments = 7'b001_1001; // 4
            4'h5: segments = 7'b001_0010; // 5
            4'h6: segments = 7'b000_0010; // 6
            4'h7: segments = 7'b111_1000; // 7
            4'h8: segments = 7'b000_0000; // 8
            4'h9: segments = 7'b001_0000; // 9
            4'hA: segments = 7'b000_1000; // A
            4'hB: segments = 7'b000_0011; // B
            4'hC: segments = 7'b100_0110; // C
            4'hD: segments = 7'b010_0001; // D
            4'hE: segments = 7'b000_0110; // E
            4'hF: segments = 7'b000_1110; // F
            default: segments = 7'b111_1111; // All segments off
        endcase
    end

    // Map decoded segments to output
    assign {CG, CF, CE, CD, CC, CB, CA} = segments; // Corrected segment mapping
    assign DP = 1'b1; // Decimal point off by default

endmodule