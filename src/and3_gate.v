`timescale 1ns/10ps

`include "lib/and_gate.v"

module and3_gate(a, b, c, out);

	//inuts
	input a, b, c;

	//output
	output out;

	//wires
	wire l1temp0;

  	and_gate l1_0(a, b, l1temp0);

  	and_gate l2_0(l1temp0, c, out);
endmodule