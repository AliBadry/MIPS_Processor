module register_file 
#(parameter  WIDTH =32,
  parameter  DEPTH = 32 

)

(
    input wire [$clog2(WIDTH)-1:0] A1,A2,A3,
    input wire [WIDTH-1:0] WD3,
    input wire WE3,
    input wire clk,
    output wire [WIDTH-1:0]RD1,
    output wire [WIDTH-1:0]RD2,
    input wire rst
);   
 integer  i;
 reg[WIDTH-1:0]register_Bank[DEPTH-1:0];

        
       assign RD1 = register_Bank[A1];
       assign RD2 = register_Bank[A2];
       

    always @(posedge clk, negedge rst) begin
      if(rst == 0)
      begin 
      
            for(i=0;i<32;i=i+1)
            begin
         
            register_Bank[i] <= 0 ; 

             end 
        
      end 

      else if(WE3 == 1)
      begin

        register_Bank[A3] <= WD3;
       
      
      end 



    end








endmodule