module Inst_ROM (
    input wire [31:0]   PC,
    output wire [31:0]   inst
);
reg [31:0] inst_r;
reg [31:0] MEMO [0:31];

assign inst = inst_r;
    initial $readmemh("Program_1_Machine_Code.txt",MEMO) ;
/*initial begin
    MEM[0] = 32'b0;
    MEM[1] = 31'b10101010;
end*/
always @(*) begin
    inst_r <= MEMO [PC>>2];
end


endmodule