module not_gate_n (x, z);
  parameter n=1;
  input [n-1:0] x;
  output [n-1:0] z;
  
  assign z = ~x ;
  
  
endmodule
  



