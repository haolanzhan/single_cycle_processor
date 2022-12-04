`timescale 1ns/10ps

`include "../lib/or_gate.v"

module or5_gate(a, b, c, d, e, out);

	//inuts
	input a, b, c, d, e;

	//output
	output out;

	//wires
	wire l1temp0, l1temp1, l2temp0;

  	or_gate l1_0(a, b, l1temp0);
  	or_gate l1_1(c, d, l1temp1);

  	or_gate l2_0(l1temp0, l1temp1, l2temp0);

		or_gate l3_0(l2temp0, e, out);
endmodule