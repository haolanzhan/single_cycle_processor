`timescale 1ns/10ps

`include "../lib/or_gate.v"

module or4_gate(a, b, c, d, out);

	//inuts
	input a, b, c, d;

	//output
	output out;

	//wires
	wire l1temp0, l1temp1;

  	or_gate l1_0(a, b, l1temp0);
		or_gate l1_1(c, d, l1temp1);

  	or_gate l2_0(l1temp0, l1temp1, out);

endmodule