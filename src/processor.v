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
	wire nPC_sel; 

	//Control signals for datapath (control unit->datapath)

	//feedback signals for control path (datapath->control unit)

	//instruction (ifetch -> control unit and datapath)
	wire [31:0] instruction; 


	//instantiate instruction fetch
	instruction_fetch ifetch (d, clk, nPC_sel, instruction); 

	//instantiate control unit
	main_control ctrl(/*Opcode*/, Zero, AluResMsb, nPC_sel, RegWr, RegDst, ExtOp, AluSrc, AluOp, MemWr, MemtoReg, Branch);
	alu_control aluctrl(ALUop, func, ALUctr);

	//instantiate datapath
	datapath dpath (clk, instruction, regwrite, regdst, extop, alusrc, memwrite, mem2reg, aluctrl, zero, msb);


endmodule