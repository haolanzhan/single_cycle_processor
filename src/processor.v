`timescale 1ns/10ps

`include "src/instruction_fetch.v"
`include "src/main_control.v"
`include "src/alu_control.v"
`include "src/datapath.v"

module processor (clk, start_up, instruction, new_pc_out, busW, alu_result);
  	parameter program1 = ""; //program
	input clk, start_up;

	//Control signals for ifetch (control unit->instruction fetch)
	wire nPC_sel, Branch;

	//Control signals for datapath (control unit->datapath)
	wire RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, ALUctr;

	//feedback signals for control path (datapath->control unit)
	wire zero, msb;

	//instruction (ifetch -> control unit and datapath)
	output [31:0] instruction; 

	//signals for alu control
	wire ALUop;

	//outputs for testing
	output [31:0] new_pc_out, busW, alu_result;

	//instantiate instruction fetch (in: d ... nPC_sel; out: instruction)
	instruction_fetch #(.program2(program1)) ifetch (start_up, clk, nPC_sel, instruction, new_pc_out); 

	//instantiate control unit (in: Instruction ... msb; out: nPC_sel ... Branch)
	main_control ctrl(/*Opcode*/instruction[31:26], zero, msb, nPC_sel, RegWr, RegDst, ExtOp, AluSrc, AluOp, MemWr, MemtoReg, Branch);
	//(in: Aluop, Instruction; out: ALUctr)
	alu_control aluctrl(AluOp, /*func*/instruction[5:0], ALUctr);

	//instantiate datapath (in: clk ... ALUctr; out: zero, msb)
	datapath #(.file(program1)) dpath (clk, instruction, RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, ALUctr, zero, msb, busW, alu_result);
endmodule