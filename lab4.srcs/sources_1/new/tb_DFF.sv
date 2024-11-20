`timescale 1ns / 1ps

module tb_DFF;

    reg D, clk, CLR_N;
    wire Q, Qbar;

 
    DFF uut (
        .D(D),
        .clk(clk),
        .CLR_N(CLR_N),
        .Q(Q),
        .Qbar(Qbar)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5ns
    end

   
    initial begin
        // Initialize inputs
        D = 0;
        CLR_N = 0;

        
       //display %0t | D: %b | clk: %b | CLR_N: %b | Q: %b | Qbar: %b", 
             //  $time, D, clk, CLR_N, Q, Qbar);

        // Test 1: Reset the flip-flop
        #10 CLR_N = 1; //  reset

        // Test 2: Transparent state (D changes when clk toggles)
        #10 D = 1; // Set D to 1
        #10 D = 0; // Set D to 0

        // Test 3: Reset while clk is high
        #10 CLR_N = 0; // Assert reset while clk is high
        #10 CLR_N = 1; // Deassert reset

        // Test 4: Verify holding state
        #10 D = 1; CLR_N = 1; // Normal operation resumes
        #10 D = 0;

        // Finish simulation
        #50 $finish;
    end

endmodule