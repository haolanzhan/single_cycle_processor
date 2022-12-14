`timescale 1ns/10ps

`include "lib/and_gate.v"

module and6_gate(a, b, c, d, e, f, out);

	//inuts
	input a, b, c, d, e, f;

	//output
	output out;

	//wires
	wire l1temp0, l1temp1, l1temp2, l2temp0;

  	and_gate l1_0(a, b, l1temp0);
  	and_gate l1_1(c, d, l1temp1);
		and_gate l1_2(e, f, l1temp2);

  	and_gate l2_0(l1temp0, l1temp1, l2temp0);

  	and_gate l3_0(l2temp0, l1temp2, out);
endmodule