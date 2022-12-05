`timescale 1ns/10ps

`include "lib/and_gate.v"
`include "lib/or_gate.v"
`include "lib/xor_gate.v"
`include "lib/mux.v"
`include "lib/not_gate.v"
`include "lib/mux_32.v"

//================================================
// Conventional ALU: 
// Operation	code
// ADD 			0010
// SUB			0110
// AND			0000
// OR			0001
// XOR			0011
// SLT			0111
// SLTU			0101
// SLL			1000
// SRL			1001
//================================================

// Top Module
module alu(op_A, op_B, ctrl, carry, overflow, zero, res);
	input	[31:0] 	op_A;
	input	[31:0] 	op_B;
	input	[3:0] 	ctrl;

	output 			carry;
	output			overflow;
	output			zero;
	output	[31:0]	res;

	wire 	[31:0]	alu_out, sll_out, slr_out, shift_out;
	wire			or_out;

	// ALU output
	full_alu falu (op_A, op_B, ctrl, carry, overflow, alu_out);

	// Shifter outputs
	full_left_logical_shifter flls(op_A, op_B[4:0], sll_out);
	full_right_logical_shifter frls(op_A, op_B[4:0], slr_out);

	// Choose shifter output
	full_mux shift_mux (ctrl[0], sll_out, slr_out, shift_out);

	// Choose ALU or shifter
	full_mux alu_mux (ctrl[3], alu_out, shift_out, res);

	// Determine zero
	or_32 zero_or (res, or_out);
	not_gate zero_not (or_out, zero);

endmodule


// Full ALU for 32 bits
module full_alu(A, B, ctrl, cout, over, res);
	input	[31:0] 	A;
	input	[31:0] 	B;
	input	[3:0] 	ctrl;
	output 			cout, over;
	output	[31:0] 	res;

	wire 			set;
	wire 	[30:0]	carry;

	genvar i;

	// Generate first single bit ALU since less input is different
	bit_alu balu (A[0], B[0], ctrl[2], ctrl[2], set, ctrl, res[0], carry[0]);

	// Generate middle 30 single bit ALU
	generate
		for (i = 1; i < 31; i = i + 1) begin 
			bit_alu balu_gen (A[i], B[i], ctrl[2], carry[i - 1], 1'b0, ctrl, res[i], carry[i]);
		end
	endgenerate

	// Generate MSB ALU
	msb_alu msbalu (A[31], B[31], ctrl[2], carry[30], 1'b0, ctrl, res[31], cout, over, set);


endmodule


// ALU for most significant bit
module msb_alu(a, b, bneg, cin, less, ctrl, res, cout, over, set);
	input 			a, b, bneg, cin, less;
	input 	[3:0]	ctrl;
	output 			res, cout, over, set;

	wire b_out, b_inv;
	wire and_out, or_out, xor_out, add_out;
	wire wire0_0, wire1_0, wire0_1, wire1_1;
	wire same_sign, stl_out, stlu_out;

	// invert b if needed
	not_gate not1 (b, b_inv);
	mux mux_b (bneg, b, b_inv, b_out);

	// results for AND, OR, XOR, ADD, SUB functionalities
	and_gate and1 (a, b_out, and_out);
	or_gate or1 (a, b_out, or_out);
	xor_gate xor1 (a, b_out, xor_out);
	full_adder fa1 (a, b_out, cin, add_out, cout);

	// select correct output based on control signal
	// level 0
	mux mux0_0 (ctrl[2], or_out, less, wire0_0);
	mux mux1_0 (ctrl[2], xor_out, less, wire1_0);
	// level 1
	mux mux0_1 (ctrl[1], and_out, add_out, wire0_1);
	mux mux1_1 (ctrl[1], wire0_0, wire1_0, wire1_1);
	// level 2
	mux mux0_2 (ctrl[0], wire0_1, wire1_1, res);


	// overflow detection 
	xor_gate xor_overflow (cin, cout, over);

	// set less than signed
	xor_gate xor_sign (a, b, same_sign);
	mux slt_mux (same_sign, add_out, a, stl_out);

	// set less than unsigned
	not_gate not_carry (cout, stlu_out);

	// select set less than signed or unsigned based on control
	// we don't care about other bits since this value will be fed
	// back into the first ALU and subsequently fitered
	mux slt_sltu_mux (ctrl[1], stlu_out, stl_out, set);


endmodule

// Bit ALU
module bit_alu(a, b, bneg, cin, less, ctrl, res, cout);
	input 			a, b, bneg, cin, less;
	input 	[3:0]	ctrl;
	output 			res, cout;

	wire b_out, b_inv;
	wire and_out, or_out, xor_out, add_out;
	wire wire0_0, wire0_1, wire1_1;

	// invert b if needed
	not_gate not1 (b, b_inv);
	mux mux_b (bneg, b, b_inv, b_out);

	// results for AND, OR, XOR, ADD, SUB functionalities
	and_gate and1 (a, b_out, and_out);
	or_gate or1 (a, b_out, or_out);
	xor_gate xor1 (a, b_out, xor_out);
	full_adder fa1 (a, b_out, cin, add_out, cout);

	// select correct output based on control signal
	// level 0
	mux mux0_0 (ctrl[2], or_out, less, wire0_0);
	mux mux1_0 (ctrl[2], xor_out, less, wire1_0);
	// level 1
	mux mux0_1 (ctrl[1], and_out, add_out, wire0_1);
	mux mux1_1 (ctrl[1], wire0_0, wire1_0, wire1_1);
	// level 2
	mux mux0_2 (ctrl[0], wire0_1, wire1_1, res);


endmodule


// Bit Full Adder
module full_adder(a, b, cin, res, cout);
	input a, b, cin;
	output res, cout;

	wire w1, wc1, wc2;

	// result
	xor_gate xor1 (a, b, w1);
	xor_gate xor2 (w1, cin, res);

	// carry out 
	and_gate and1 (a, b, wc1);
	and_gate and2 (cin, w1, wc2);
	or_gate or1 (wc1, wc2, cout);


endmodule


// Left Barrel shifter
module full_left_logical_shifter(A, B, out);
	input	[31:0] 	A;
	input	[4:0] 	B;
	output 	[31:0]	out;
	
	wire [31:0] inter_wire[3:0];

	genvar i, j;
	
	// Generate first layer of muxes
	generate
		for (j = 0; j < 32; j = j + 1) begin
			if (j + 1 < 32) begin
				mux mux0 (B[0], A[31 - j], A[31 - (j + 1)], inter_wire[0][j]);	

			end
			else begin 
				mux mux0 (B[0], A[31 - j], 1'b0, inter_wire[0][j]);
			end
		end
	endgenerate

	// Generate the middle layers
	generate
		for (i = 1; i < 4; i = i + 1) begin
			for (j = 0; j < 32; j = j + 1) begin
				if (2 ** i + j < 32) begin
					mux mux1 (B[i], inter_wire[i - 1][j], inter_wire[i - 1][2 ** i + j], inter_wire[i][j]);	
				end
				else begin
					mux mux1 (B[i], inter_wire[i - 1][j], 1'b0, inter_wire[i][j]);
				end
			end
		end
	endgenerate

	// Generate the last layer
	generate
		for (j = 0; j < 32; j = j + 1) begin
			if (16 + j < 32) begin
				mux mux2 (B[4], inter_wire[3][j], inter_wire[3][16 + j], out[31 - j]);
			end
			else begin 
				mux mux2 (B[4], inter_wire[3][j], 1'b0, out[31 - j]);
			end
		end
	endgenerate

endmodule

// Right Barrel shifter
module full_right_logical_shifter(A, B, out);
	input	[31:0] 	A;
	input	[4:0] 	B;
	output 	[31:0]	out;

	wire [31:0] inter_wire[3:0];

	genvar i, j;
	
	// Generate first layer of muxes
	generate
		for (j = 0; j < 32; j = j + 1) begin
			if (j + 1 < 32) begin
				mux mux0 (B[0], A[j], A[j + 1], inter_wire[0][j]);	

			end
			else begin 
				mux mux0 (B[0], A[j], 1'b0, inter_wire[0][j]);
			end
		end
	endgenerate

	// Generate the middle layers
	generate
		for (i = 1; i < 4; i = i + 1) begin
			for (j = 0; j < 32; j = j + 1) begin
				if (2 ** i + j < 32) begin
					mux mux1 (B[i], inter_wire[i - 1][j], inter_wire[i - 1][2 ** i + j], inter_wire[i][j]);	
				end
				else begin
					mux mux1 (B[i], inter_wire[i - 1][j], 1'b0, inter_wire[i][j]);
				end
			end
		end
	endgenerate

	// Generate the last layer
	generate
		for (j = 0; j < 32; j = j + 1) begin
			if (16 + j < 32) begin
				mux mux2 (B[4], inter_wire[3][j], inter_wire[3][16 + j], out[j]);
			end
			else begin 
				mux mux2 (B[4], inter_wire[3][j], 1'b0, out[j]);
			end
		end
	endgenerate

endmodule

// 32-bit to 1 OR
module or_32(A, out);
	input	[31:0] 	A;
	output 			out;

	wire or0_out, or1_out;

	or_16 or0 (A[15:0], or0_out);
	or_16 or1 (A[31:16], or1_out);

	or_gate or3(or0_out, or1_out, out);


endmodule


// 16-bit to 1 OR
module or_16(A, out);
	input	[15:0] 	A;
	output 			out;

	wire or0_out, or1_out;

	or_8 or0 (A[7:0], or0_out);
	or_8 or1 (A[15:8], or1_out);

	or_gate or3(or0_out, or1_out, out);


endmodule

// 8-bit to 1 OR
module or_8(A, out);
	input	[7:0] 	A;
	output 			out;

	wire or0_out, or1_out;

	or_4 or0 (A[3:0], or0_out);
	or_4 or1 (A[7:4], or1_out);

	or_gate or3(or0_out, or1_out, out);


endmodule


// 4-bit to 1 OR
module or_4(A, out);
	input	[3:0] 	A;
	output 			out;

	wire or0_out, or1_out;

	or_gate or0 (A[0], A[1], or0_out);
	or_gate or1 (A[2], A[3], or1_out);

	or_gate or3(or0_out, or1_out, out);


endmodule