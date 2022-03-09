module Adder32 (
    input wire [31:0]   A_in,
    input wire [31:0]   B_in,
    output wire [31:0]   C_out
);
    assign C_out = A_in + B_in;
endmodule