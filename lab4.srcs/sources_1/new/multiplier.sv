module multiplier (
    input logic clk,
    input logic reset,
    input logic [7:0] x,        
    input logic [7:0] y,        
    output logic [15:0] product,
    output logic done           
);
    logic [7:0] count;            
    logic [15:0] accumulator;     // Accumulator for the product

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 8'b0;
            accumulator <= 16'b0;
            done <= 0;
        end else begin
            if (!done) begin
                if (count < y) begin
                    count <= count + 1;               
                    accumulator <= accumulator + x;   // Add x to the accumulator
                end else begin
                    done <= 1;                        
                end
            end
        end
    end


    always_comb begin
        product = accumulator;
    end
endmodule