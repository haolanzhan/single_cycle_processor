`timescale 1ns/10ps

`include "../lib/and_gate.v"
`include "../lib/or_gate.v"
`include "../lib/xor_gate.v"
`include "../lib/mux.v"
`include "../lib/not_gate.v"

module processor (clk);
  	parameter mem_file=""; //program
	input clk;

	//instantiate instruction fetch
	instruction_fetch if (d, clk, nPC_sel, instruction); 

	//instantiate control unit
	main_control ctrl(Opcode, Zero, AluResMsb, nPC_sel, RegWr, RegDst, ExtOp, AluSrc, AluOp, MemWr, MemtoReg, Branch);
	alu_control aluctrl(ALUop, func, ALUctr);


endmodule