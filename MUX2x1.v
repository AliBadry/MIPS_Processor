module MUX2x1 
    #(parameter WIDTH = 32)
(
    input wire [WIDTH-1:0] In1,
    input wire [WIDTH-1:0] In2,
    output wire [WIDTH-1:0] MUX_out,
    input wire Select
);
reg [WIDTH-1:0] MUX_reg;
assign MUX_out = MUX_reg;
    always @(*) begin
        if (Select)
            MUX_reg = In2;
        else
            MUX_reg = In1;
    end
endmodule