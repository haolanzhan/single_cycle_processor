`timescale 1ns/10ps

`include "../lib/dffr.v"

// pos-edged 32-bit register
module register(clk, d, q);
    input           clk;
    input   [31:0]  d;  
    output  [31:0]  q;  

    genvar i;

    // Generate 32 copies of dff controled by single clock signal
    // for each of 32 bits
    generate
		for (i = 0; i < 32; i = i + 1) begin 
			dffr dff_gen (clk, d[i], q[i]);
		end
	endgenerate

endmodule 