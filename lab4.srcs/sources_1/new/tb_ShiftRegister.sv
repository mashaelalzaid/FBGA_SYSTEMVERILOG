`timescale 1ns / 1ps


module tb_ShiftRegister;
reg clk,reset_n, serial_in, enable;
wire [7:0] Q;
wire serial_out;

    
    ShiftRegister uut (
        .clk(clk),
        .reset_n(reset_n),
        .serial_in(serial_in),
        .serial_out(serial_out),
        .enable(enable),
        .Q(Q)
    );

  
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        reset_n = 0; enable = 0; serial_in = 0;
        
        #10 reset_n = 1; 
        
        #10 enable = 1; serial_in = 1;
        #40; 

        #10 serial_in = 0;
        #40; 
       
        #10 enable = 0;
        #10 reset_n = 0;
        #10 reset_n = 1;      
        #50 $stop;
    end

    initial begin
        $monitor("Time: %t | serial_in: %b | enable: %b | Q: %b | serial_out: %b",
                 $time, serial_in, enable, Q, serial_out);
    end
endmodule