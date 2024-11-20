module register_8bit (
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 8'b0;
        else if (enable)
            data_out <= data_in;
    end
endmodule