module Control_unit (
    input wire [31:0] Instruction,
    output wire MemtoReg_out,
    output wire MemWrite_out,
    output wire Branch_out,
    output wire ALUSrc_out,
    output wire RegDst_out,
    output wire RegWrite_out,
    output wire Jump_out,
    output wire [2:0] ALUControl_out
);
reg [1:0] ALUOp;
reg MemtoReg;
reg MemWrite;
reg Branch;
reg ALUSrc;
reg RegDst;
reg RegWrite;
reg Jump;
reg [2:0] ALUControl;

assign MemtoReg_out = MemtoReg;
assign MemWrite_out = MemWrite;
assign Branch_out = Branch;
assign ALUSrc_out = ALUSrc;
assign RegDst_out = RegDst;
assign RegWrite_out = RegWrite;
assign Jump_out = Jump;
assign ALUControl_out = ALUControl;
always @(*) begin
    case(Instruction[31:26])
    6'b100011:      //this is load word case
                begin
                    Jump    <= 0;
                    ALUOp   <= 2'b0;
                    MemWrite<= 0;
                    RegWrite<= 1;
                    RegDst  <= 0;
                    ALUSrc  <= 1;
                    MemtoReg<= 1;
                    Branch  <= 0;
                end
    6'b101011:      //store word case
                begin
                    Jump    <= 0;
                    ALUOp   <= 2'b0;
                    MemWrite<= 1;
                    RegWrite<= 0;
                    RegDst  <= 0;
                    ALUSrc  <= 1;
                    MemtoReg<= 1;
                    Branch  <= 0;
                end
    6'b000000:      //rtype case
                begin
                    Jump    <= 0;
                    ALUOp   <= 2'b10;
                    MemWrite<= 0;
                    RegWrite<= 1;
                    RegDst  <= 1;
                    ALUSrc  <= 0;
                    MemtoReg<= 0;
                    Branch  <= 0;
                end
    6'b001000:      //addImmediate case
                begin
                    Jump    <= 0;
                    ALUOp   <= 2'b0;
                    MemWrite<= 0;
                    RegWrite<= 1;
                    RegDst  <= 0;
                    ALUSrc  <= 1;
                    MemtoReg<= 0;
                    Branch  <= 0;
                end
    6'b000100:      //branch if equal case
                begin
                    Jump    <= 0;
                    ALUOp   <= 2'b01;
                    MemWrite<= 0;
                    RegWrite<= 0;
                    RegDst  <= 0;
                    ALUSrc  <= 0;
                    MemtoReg<= 0;
                    Branch  <= 1;
                end
    6'b000010:      //jump instruction case
                begin
                    Jump    <= 1;
                    ALUOp   <= 2'b0;
                    MemWrite<= 0;
                    RegWrite<= 0;
                    RegDst  <= 0;
                    ALUSrc  <= 0;
                    MemtoReg<= 0;
                    Branch  <= 0;
                end
    default:
                begin
                    Jump    <= 0;
                    ALUOp   <= 2'b0;
                    MemWrite<= 0;
                    RegWrite<= 0;
                    RegDst  <= 0;
                    ALUSrc  <= 0;
                    MemtoReg<= 0;
                    Branch  <= 0;
                end
    endcase
    if (ALUOp == 2'b10) begin
        case (Instruction[5:0])
            6'b100000:  //addition function
                ALUControl  <= 3'b010;
            6'b100010:  //subtraction function
                ALUControl  <= 3'b100;
            6'b101010:  //SLT function
                ALUControl  <= 3'b110;
            6'b011100:  //multiplication function
                ALUControl  <= 3'b101;
            default:
                ALUControl  <= 3'b010;
        endcase
    end
    else if (ALUOp == 2'b00)
        ALUControl  <= 3'b010;
    else if (ALUOp == 2'b01)
        ALUControl  <= 3'b100;
    else
        ALUControl  <= 3'b010;
end
    
endmodule