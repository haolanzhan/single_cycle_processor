`timescale 1ns/10ps

`include "../lib/and_gate.v"

module and8_gate(a, b, c, d, e, f, g, h, out);

	//inuts
	input a, b, c, d, e, f, g, h; 

	//output
	output out;

	//wires
	wire l1temp0, l1temp1, l1temp2, l1temp3, l2temp0, l2temp1;

  	and_gate l1_0(a, b, l1temp0);
  	and_gate l1_1(c, d, l1temp1);
  	and_gate l1_2(e, f, l1temp2);
  	and_gate l1_3(g, h, l1temp3);

  	and_gate l2_0(l1temp0, l1temp1, l2temp0);
  	and_gate l2_1(l1temp2, l1temp3, l2temp1);

	and_gate l3_0(l2temp0, l2temp1, out);
endmodule