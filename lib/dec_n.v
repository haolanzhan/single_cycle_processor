module dec_n (src , z);
  parameter n=1;
  input [n-1:0] src;
  output reg [((2**n)-1):0] z;
  integer i;
  
  always @(src)
      begin
        for (i = 0; i < 2**n; i = i+1) begin
            if (src == i) z[i] <= 1'b1;
            else z[i] <= 1'b0;
          end
      end
endmodule
  
  
  
