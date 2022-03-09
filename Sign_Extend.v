module Sign_Extend (
    input wire [15:0]   Inst_in,
    output wire [31:0]  SignImm_out
);
    assign SignImm_out = {{16{Inst_in[15]}} , Inst_in[15:0]};
endmodule