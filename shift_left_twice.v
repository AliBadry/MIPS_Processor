module shift_left_twice 
#(parameter WIDTH = 4 )


( input wire [WIDTH-1:0]in,
  output wire [WIDTH-1:0]out
 
);

assign out = in << 2 ;


endmodule