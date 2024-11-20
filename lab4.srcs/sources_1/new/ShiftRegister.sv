module ShiftRegister(
input clk,
input reset_n,
input serial_in,
input enable,
output reg [7:0] Q,
output serial_out
    );
    assign serial_out = Q[7];
    always@ (posedge clk or negedge reset_n) begin 
    if (!reset_n)
    Q <= 8'b0;
    else if (enable)
    Q <= {Q[6:0], serial_in};
    end 
endmodule
