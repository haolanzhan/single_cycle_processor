module and_gate_n (x, y, z);
  parameter n=1;
  input [n-1:0] x;
  input [n-1:0] y;
  output [n-1:0] z;
  
  assign z = (x&y) ;
  
  
endmodule
  




