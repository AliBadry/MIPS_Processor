module MyMIPS
#(parameter Size =32)
//-------------------inOut signal--------------//
(
    input CLK, Reset,
    output [15:0] test_value
);

//-------------------------------Local wires----------------//
wire [Size-1:0] Instr, ReadData;
wire [2:0]      ALUControl ;
wire            Jump, PCSrc, MemtoReg, ALUSrc, RegDst, RegWrite, Zero,Branch;
wire [Size-1:0] PC, ALUOut, WriteData;
//reg [31:0]      MEM [31:0];
//----------------------module instantiation---------------//
Data_path   Data_path1  (
    .CLK(CLK), 
    .Reset(Reset), 
    .Instr(Instr), 
    .ReadData(ReadData), 
    .ALUControl(ALUControl), 
    .Jump(Jump), 
    .MemtoReg(MemtoReg), 
    .ALUSrc(ALUSrc), 
    .RegDst(RegDst), 
    .RegWrite(RegWrite), 
    .PC(PC), 
    .ALUOut(ALUOut), 
    .WriteData(WriteData), 
    .Zero(Zero), 
    .PCSrc(PCSrc));
Control_unit    Control1   (
    .Instruction(Instr), 
    .MemtoReg_out(MemtoReg), 
    .MemWrite_out(MemWrite), 
    .Branch_out(Branch), 
    .ALUSrc_out(ALUSrc), 
    .RegDst_out(RegDst), 
    .RegWrite_out(RegWrite), 
    .Jump_out(Jump), 
    .ALUControl_out(ALUControl));
Inst_ROM        Rom1(
    .PC(PC), 
    .inst(Instr));
RAM             Ram1(
    .clk(CLK), 
    .rst(Reset), 
    .A(ALUOut), 
    .WD(WriteData), 
    .test_value(test_value), 
    .WE(MemWrite), 
    .RD(ReadData));


//--------------------assignments-----------------------------//
//initial $readmemh("Program 1_Machine Code.txt",Rom1) ;


assign PCSrc = Zero & Branch;
endmodule