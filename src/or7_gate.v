`timescale 1ns/10ps

`include "../lib/or_gate.v"

module or7_gate(a, b, c, d, e, f, g, out);

	//inuts
	input a, b, c, d, e, f, g; 

	//output
	output out;

	//wires
	wire l1temp0, l1temp1, l1temp2, l2temp0, l3temp0;

  or_gate l1_0(a, b, l1temp0);
	or_gate l1_1(c, d, l1temp1);
	or_gate l1_2(e, f, l1temp2);
  
	or_gate l2_0(l1temp0, l1temp1, l2temp0);

	or_gate l3_0(l2temp0, l1temp2, l3temp0);

	or_gate l4_0(l4temp0, g, out);
endmodule