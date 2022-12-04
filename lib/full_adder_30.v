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



// // Generate first single bit ALU since less input is different
// 	bit_alu balu (A[0], B[0], ctrl[2], ctrl[2], set, ctrl, res[0], carry[0]);

// 	// Generate middle 30 single bit ALU
// 	generate
// 		for (i = 1; i < 31; i = i + 1) begin 
// 			bit_alu balu_gen (A[i], B[i], ctrl[2], carry[i - 1], 1'b0, ctrl, res[i], carry[i]);
// 		end
// 	endgenerate

// 	// Generate MSB ALU
// 	msb_alu msbalu (A[31], B[31], ctrl[2], carry[30], 1'b0, ctrl, res[31], cout, over, set);