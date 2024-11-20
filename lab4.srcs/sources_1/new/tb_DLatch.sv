`timescale 1ns / 1ps

module tb_DLatch;

    reg D, clk, reset_n;
    wire Q, Qbar;


    DLatch uut (
        .D(D),
        .clk(clk),
        .reset_n(reset_n),
        .Q(Q),
        .Qbar(Qbar)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    
    initial begin
       
        D = 0;
        reset_n = 1;

     
       // $display("Time: %0t | D: %b | clk: %b | reset_n: %b | Q: %b | Qbar: %b", 
         //        $time, D, clk, reset_n, Q, Qbar);

        // Test 1: Reset the latch
        #5 reset_n = 0; 
        #10 reset_n = 1;

        // Test 2: (clk = 1, D changes)
        #10 D = 1; // Q should follow D
        #10 D = 0; // Q should follow D

        // Test 3: Hold state (clk = 0)
        #10 clk = 0; D = 1; // D changes, Q should hold previous value
        #10 D = 0; // Again, Q should hold

        // Test 4: Asynchronous reset overrides all inputs
        #10 reset_n = 0; //  Q should go to 0 immediately
        #10 reset_n = 0; clk = 1; //  back to normal operation

        // Test 5: Reset while clk = 1
        #10 reset_n = 0; D = 1; // Q should still reset to 0
        #10 reset_n = 1; D = 0; // Normal operation resumes, Q = D

        #50 $finish;
    end

endmodule