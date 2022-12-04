`timescale 1ns/10ps

`include "../lib/and_gate.v"
`include "../lib/or_gate.v"
`include "../lib/xor_gate.v"
`include "../lib/mux.v"
`include "../lib/not_gate.v"
`include "and6_gate.v"
`include "or3_gate.v"
`include "and3_gate.v"

module main_control(Opcode, Zero, AluResMsb, nPC_sel, RegWr, RegDst, ExtOp, AluSrc, AluOp, MemWr, MemtoReg, Branch);
	//inputs
  	input [5:0] Opcode; 
  	input Zero, AluResMsb;

	//output
 	output [1:0] AluOp; 
  	output nPC_sel, RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, Branch;

	wire [5:0] Opcode_not; 
  	wire r_type, addi, lw, sw, beq, bne, bgtz; 
	wire beq_branch_flag, bne_branch_flag, bgtz_branch_flag, Zero_not, AluResMsb_not;

  	//inverse of opcode
	not_gate op_0 (Opcode[0], Opcode_not[0]);
	not_gate op_1 (Opcode[1], Opcode_not[1]);
	not_gate op_2 (Opcode[2], Opcode_not[2]);
	not_gate op_3 (Opcode[3], Opcode_not[3]);
	not_gate op_4 (Opcode[4], Opcode_not[4]);
	not_gate op_5 (Opcode[5], Opcode_not[5]);

	//AND plane for the PLA
	and6_gate r_type_and (Opcode_not[5], Opcode_not[4], Opcode_not[3], Opcode_not[2], Opcode_not[1], Opcode_not[0], r_type); 
	and6_gate RegDst_and (Opcode_not[5], Opcode_not[4], Opcode_not[3], Opcode_not[2], Opcode_not[1], Opcode_not[0], RegDst); //output RegDst is 1 if and only if its a R-type instruction
	and6_gate AluOp1_and (Opcode_not[5], Opcode_not[4], Opcode_not[3], Opcode_not[2], Opcode_not[1], Opcode_not[0], AluOp[1]); //output ALUop[1] is 1 if and only if its a R-type instruction
	and6_gate addi_and (Opcode_not[5], Opcode_not[4], Opcode[3], Opcode_not[2], Opcode_not[1], Opcode_not[0], addi); 
	and6_gate lw_and (Opcode[5], Opcode_not[4], Opcode_not[3], Opcode_not[2], Opcode[1], Opcode[0], lw); 
	and6_gate MemtoReg_and (Opcode[5], Opcode_not[4], Opcode_not[3], Opcode_not[2], Opcode[1], Opcode[0], MemtoReg); //output MemtoReg is 1 if and only of its a load instruction
	and6_gate sw_and (Opcode[5], Opcode_not[4], Opcode[3], Opcode_not[2], Opcode[1], Opcode[0], sw); 
	and6_gate MemWr_and (Opcode[5], Opcode_not[4], Opcode[3], Opcode_not[2], Opcode[1], Opcode[0], MemWr); //output MemWr is 1 if and only if its a store instruciton
	and6_gate beq_and (Opcode_not[5], Opcode_not[4], Opcode_not[3], Opcode[2], Opcode_not[1], Opcode_not[0], beq); 
	and6_gate bne_and (Opcode_not[5], Opcode_not[4], Opcode_not[3], Opcode[2], Opcode_not[1], Opcode[0], bne); 
	and6_gate bgtz_and (Opcode_not[5], Opcode_not[4], Opcode_not[3], Opcode[2], Opcode[1], Opcode[0], bgtz); 

	//OR Plane for the PLA to calculate outputs
	or3_gate RegWr_or (r_type, addi, lw, RegWr); //Regwr output
	or3_gate ExtOp_or (addi, lw, sw, ExtOp); //Extop output
	or3_gate AluSrc_or (addi, lw, sw, AluSrc); //alusrc output
	or3_gate AluOp2_or (beq, bne, bgtz, AluOp[0]); //aluop[0] output
	or3_gate Branch_or (beq, bne, bgtz, Branch); //branch output

	//calculate nPC_Sel independently
	and_gate beq_and_zero (beq, Zero, beq_branch_flag); //this instruction is beq, and the condition passes so we must branch
	not_gate not_zero (Zero, Zero_not); //result from subtraction is not zero 
	and_gate bne_and_not_zero (bne, Zero_not, bne_branch_flag); //this instruction is bne, and the condition passes so we must branch
	not_gate not_AluResMsb (AluResMsb, AluResMsb_not); //result from subtraction has a 0 MSB (thus positive) 
	and3_gate bgtz_and_not_zero_and_pos (bgtz, Zero_not, AluResMsb_not, bgtz_branch_flag); //this instruction is bngz, and the condition passes so we must branch
	or3_gate nPC_sel_or (beq_branch_flag, bne_branch_flag, bgtz_branch_flag, nPC_sel); //npc_sel output
endmodule