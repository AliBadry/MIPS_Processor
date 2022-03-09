module Data_path
    #(parameter Size = 32)
//---------------------INOUT signals---------------------------------------------//
(
    input wire              CLK, Reset,
    input wire [Size-1:0]   Instr , ReadData,
    input wire [2:0]        ALUControl,
    input wire              Jump, PCSrc,MemtoReg,ALUSrc,RegDst,RegWrite,
    output wire [Size-1:0]  PC,ALUOut,WriteData,
    output wire             Zero
);

//----------------------------------------Local Nets-----------------------------------------------//
wire [Size-1:0] PCPlus4, PCBranch, PCJump, MUX_1_Out, MUX_5_Out, PC_bar, SrcA, SrcB, WData, SignImm, PC_in, Shift_2_Out;           
wire [28:0]     Shift_1_Out ;
wire [4:0]      WriteReg;


//---------------------------------Instantiation--------------------------------------------------//
MUX2x1              #(.WIDTH(Size)) MUX_1   (.In1(PCPlus4), .In2(PCBranch), .Select(PCSrc), .MUX_out(MUX_1_Out));
MUX2x1              #(.WIDTH(Size)) MUX_2   (.In1(MUX_1_Out), .In2(PCJump), .Select(Jump), .MUX_out(PC_bar));
P_Count                             Count1  (.PC_bar(PC_bar), .RST(Reset), .CLK(CLK), .PC(PC_in));
Adder32                             Add_1   (.A_in(PC_in), .B_in(32'b100), .C_out(PCPlus4));
Adder32                             Add_2   (.A_in(Shift_2_Out), .B_in(PCPlus4), .C_out(PCBranch));
register_file                       regFile (.A1(Instr[25:21]), .A2(Instr[20:16]), .A3(WriteReg), .WD3(MUX_5_Out), .clk(CLK), .WE3(RegWrite), .rst(Reset), .RD1(SrcA), .RD2(WData));
MUX2x1              #(.WIDTH(5))    MUX_3   (.In1(Instr[20:16]), .In2(Instr[15:11]), .Select(RegDst), .MUX_out(WriteReg));
MUX2x1              #(.WIDTH(Size)) MUX_4   (.In1(WData), .In2(SignImm), .Select(ALUSrc), .MUX_out(SrcB));
ALU                                 ALU1    (.ALU_Control(ALUControl), .SrcA(SrcA), .SrcB(SrcB), .ALUResult(ALUOut), .zero(Zero));
MUX2x1              #(.WIDTH(Size)) MUX_5   (.In1(ALUOut), .In2(ReadData), .Select(MemtoReg), .MUX_out(MUX_5_Out));
Sign_Extend                         signE1  (.Inst_in(Instr[15:0]), .SignImm_out(SignImm));
shift_left_twice    #(.WIDTH(28))   Shift_1 (.in(Instr[27:0]), .out(Shift_1_Out));
shift_left_twice    #(.WIDTH(Size)) Shift_2 (.in(SignImm), .out(Shift_2_Out));

//-------------------------------assignments------------------------------------------------------//
assign PCJump = {Instr[31:28], Shift_1_Out};

assign WriteData = WData;
assign PC = PC_in;
endmodule