module RAM #(
    parameter WIDTH = 32,
    parameter DEPTH = 32
) 

(
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0]A,
    input wire [WIDTH-1:0]WD,
    output reg [(WIDTH/2)-1:0] test_value,
    input wire  WE,
    output reg [WIDTH-1:0] RD


);

reg [WIDTH-1:0]  RAM [DEPTH-1:0];

integer i = 0;
always @(*) begin
RD = RAM[A];
test_value = RAM[0];
   
end 


always @(posedge clk, negedge rst ) begin
    if(rst == 0)
    begin 
      for(i=0;i<DEPTH;i=i+1)
       RAM[i] <= 0;
    end 
    
    else if(WE == 1)
    begin
     
       RAM[A] <= WD;
    

    end 


end



    
endmodule