module P_Count (
    input wire [31:0]   PC_bar,
    input wire CLK,
    input wire RST,
    output wire [31:0]   PC
);
    reg [31:0] PC_internal;
    assign PC = PC_internal;
    
    always @(posedge CLK or negedge RST) begin
        if(~RST) begin
            PC_internal <= 32'b0;
        end
        else begin
            PC_internal <= PC_bar;
        end
    end
endmodule