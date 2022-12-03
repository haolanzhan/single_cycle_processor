`timescale 1ns/10ps

`include "../lib/and_gate.v"
`include "../lib/or_gate.v"
`include "../lib/xor_gate.v"
`include "../lib/mux.v"
`include "../lib/not_gate.v"
`include "and8_gate.v"
`include "or5_gate.v"
`include "or7_gate.v"
`include "or3_gate.v"


module alu_control(ALUop, func, ALUctr);

	//inuts
	input [1:0] ALUop; //signal from main control unit. R-type: 10, I-type add: 00, I-type sub: 01 
	input [5:0] func; //func from instruction

	//output
	output [3:0] ALUctr; //control signal to ALU

	wire [1:0] ALUop_not; 
	wire [5:0] func_not; 
	wire sll_op_func, slt_op;
	wire sub_op_func, subu_op_func, slt_op_func, sltu_op_func, i_sub_op;
	wire add_op_func, addu_op_func, i_add_op;
	wire or_op_func;

	//produce bitwise not of inputs to use 
	not_gate op_inv0 (ALUop[0], ALUop_not[0]);
	not_gate op_inv1 (ALUop[1], ALUop_not[1]);

	not_gate func_inv0 (func[0], func_not[0]);
	not_gate func_inv1 (func[1], func_not[1]);
	not_gate func_inv2 (func[2], func_not[2]);
	not_gate func_inv3 (func[3], func_not[3]);
	not_gate func_inv4 (func[4], func_not[4]);
	not_gate func_inv5 (func[5], func_not[5]);

	//produce outputs 
	and8_gate aluctr3_0 (ALUop[1], ALUop_not[0], func_not[5], func_not[4], func_not[3], func_not[2], func_not[1], func_not[0], sll_op_func); 
	and_gate alcuctr3_1 (ALUop[1], ALUop[0], slt_op);
	or_gate alcuctr3_2 (sll_op_func, slt_op, ALUctr[3]); //ALUctr[3]

	and8_gate aluctr2_0 (ALUop[1], ALUop_not[0], func[5], func_not[4], func_not[3], func_not[2], func[1], func_not[0], sub_op_func);
	and8_gate aluctr2_1 (ALUop[1], ALUop_not[0], func[5], func_not[4], func_not[3], func_not[2], func[1], func[0], subu_op_func);
	and8_gate aluctr2_2 (ALUop[1], ALUop_not[0], func[5], func_not[4], func[3], func_not[2], func[1], func_not[0], slt_op_func);
	and8_gate aluctr2_3 (ALUop[1], ALUop_not[0], func[5], func_not[4], func[3], func_not[2], func_not[1], func[0], sltu_op_func);
	and_gate aluctr2_4 (ALUop_not[1], ALUop[0], i_sub_op);
	or5_gate aluctr2_5 (sub_op_func, subu_op_func, slt_op_func, sltu_op_func, i_sub_op, ALUctr[2]); //ALUctr[2]

	and8_gate aluctr1_0 (ALUop[1], ALUop_not[0], func[5], func_not[4], func_not[3], func_not[2], func_not[1], func_not[0], add_op_func); 
	and8_gate aluctr1_1 (ALUop[1], ALUop_not[0], func[5], func_not[4], func_not[3], func_not[2], func_not[1], func[0], addu_op_func); 
	and_gate aluctr1_5 (ALUop_not[1], ALUop_not[0], i_add_op); 
	or7_gate aluctr1_6 (add_op_func, addu_op_func, sub_op_func, subu_op_func, slt_op_func, i_add_op, i_sub_op, ALUctr[1]); //ALUctr[1]

	and8_gate aluctr0_0 (ALUop[1], ALUop_not[0], func[5], func_not[4], func_not[3], func[2], func_not[1], func[0], or_op_func);
	or3_gate aluctr0_1 (or_op_func, slt_op_func, sltu_op_func, ALUctr[0]) //ALUctr[0]

endmodule