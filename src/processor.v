`timescale 1ns/10ps

`include "instruction_fetch.v"
`include "main_control.v"
`include "alu_controle.v"
`include "datapath.v"

module processor (clk, start_up);
  	parameter program1 = ""; //program
	input clk, startup;

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

	//instantiate instruction fetch (in: d ... nPC_sel; out: instruction)
	instruction_fetch #(.program2(program1)) ifetch (start_up, clk, nPC_sel, instruction); 

	//instantiate control unit (in: Instruction ... msb; out: nPC_sel ... Branch)
	main_control ctrl(/*Opcode*/instruction[31:26], zero, msb, nPC_sel, RegWr, RegDst, ExtOp, AluSrc, AluOp, MemWr, MemtoReg, Branch);
	//(in: Aluop, Instruction; out: ALUctr)
	alu_control aluctrl(AluOp, /*func*/instruction[5:0], ALUctr);

	//instantiate datapath (in: clk ... ALUctr; out: zero, msb)
	datapath dpath (clk, instruction, RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, ALUctr, zero, msb);
endmodule