`timescale 1ns/10ps

`include "../lib/and_gate.v"
`include "../lib/or_gate.v"
`include "../lib/xor_gate.v"
`include "../lib/mux.v"
`include "../lib/not_gate.v"

module processor (clk);
  	parameter mem_file=""; //program
	input clk;

	//Control signals for ifetch (control unit->instruction fetch)
	wire nPC_sel, Branch;

	//Control signals for datapath (control unit->datapath)
	wire RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, ALUctr, 

	//feedback signals for control path (datapath->control unit)
	wire zero, msb;

	//instruction (ifetch -> control unit and datapath)
	wire [31:0] instruction; 

	//signals for alu control
	wire ALUop;


	//instantiate instruction fetch
	instruction_fetch ifetch (d, clk, nPC_sel, instruction); 

	//instantiate control unit
	main_control ctrl(/*Opcode*/instruction[31:26], zero, msb, nPC_sel, RegWr, RegDst, ExtOp, AluSrc, AluOp, MemWr, MemtoReg, Branch);
	alu_control aluctrl(AluOp, /*func*/instruction[5:0], ALUctr);

	//instantiate datapath
	datapath dpath (clk, instruction, RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, ALUctr, zero, msb);


endmodule