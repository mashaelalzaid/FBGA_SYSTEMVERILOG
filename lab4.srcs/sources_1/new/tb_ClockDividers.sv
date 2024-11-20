module tb_ClockDividers;
parameter N = 10; 
    logic clk, rst; 
    logic [$clog2(N)-1:0] count;

    ClockDividers uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end  
    
    initial begin
        rst = 1; #10; 
        rst = 0;
        #100; 
        $stop; 
    end
endmodule

module Testbench;
    logic clk_in, rst;
    logic clk_out; 

   
    generateHz uut (
        .clk_in(clk_in),
        .rst(rst),
        .clk_out(clk_out)
    );

    
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in; 
    end
    initial begin
        rst = 1; #20; 
        rst = 0; 
        #1_000_000_000; 
        $stop; 
    end
    endmodule
    