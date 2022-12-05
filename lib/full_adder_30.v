`timescale 1ns/10ps
`include "lib/full_adder.v"


module full_adder_30(a, b, c, s);

    input	[29:0] 	a; // takes <31:2> 
	input	[29:0] 	b;
    input c;
    output [29:0] s;

    wire [29:0] carries;
    full_adder lsb(a[0], b[0], c, carries[0], s[0]);
    genvar i;
    generate
        for(i = 1; i < 29; i = i + 1) begin
            full_adder adder_gen(a[i], b[i], carries[i-1], carries[i], s[i]);
        end
    endgenerate
    full_adder msb(a[29], b[29], carries[28], carries[29], s[29]);
    

endmodule