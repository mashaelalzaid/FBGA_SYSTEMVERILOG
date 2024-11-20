`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module multiplier_tb;
    logic clk;
    logic reset;
    logic [7:0] x;
    logic [7:0] y;
    logic [15:0] product;
    logic done;

    // Instantiate multiplier
    multiplier uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y),
        .product(product),
        .done(done)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        x = 8'd12;
        y = 8'd5; // Test case: 12 * 5
        #10 reset = 0;

        // Wait for the computation to complete
        wait (done);
        $display("Test Case: x = %d, y = %d, Product = %d", x, y, product);

        // Finish the simulation
        #10 $finish;
    end

    // Monitor changes (optional)
    initial begin
        $monitor("At time %t: x = %d, y = %d, product = %d, done = %b", 
                 $time, x, y, product, done);
    end
endmodule