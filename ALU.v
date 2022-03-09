
module ALU 

(

input wire [2:0]ALU_Control,
input wire [31:0] SrcA,
input wire [31:0] SrcB,
output wire [31:0] ALUResult,
output wire zero 

);
reg [31:0] Res ;
reg zero_temp ;
always @(*) begin
    

case(ALU_Control)

3'b000:
    begin
        Res = SrcA & SrcB ;
        zero_temp = ~|Res;
    end 
3'b001:
    begin 
        Res = SrcA | SrcB ;
        zero_temp = ~|Res;
    end 
3'b010:
    begin 
        Res = SrcA + SrcB ; 
        zero_temp = ~|Res;
    end 
3'b100:
    begin 
        Res = SrcA - SrcB ;
        zero_temp = ~|Res;
    end 
3'b101:
    begin 
        Res = SrcA * SrcB;
        zero_temp = ~|Res;
    end
3'b110:
    begin 
        Res = (SrcA < SrcB ? 1 : 0);  
        zero_temp = ~|Res;
    end 
default:
     begin 
        Res = 0;
        zero_temp = 1; 
    end 
endcase

end 

    assign ALUResult = Res;
    assign zero = zero_temp;




endmodule