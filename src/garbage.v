`timescale 1ns/10ps

`include "src/instruction_fetch.v"
`include "src/main_control.v"
`include "src/alu_control.v"
`include "src/datapath.v"

module garbage (start_up, clk, nPC_sel, instruction, new_pc_tb, d_tb, q_tb, mux_output_tb);
	parameter program1 = ""; //program
	input clk, start_up;

	input nPC_sel;

	//instruction (ifetch -> control unit and datapath)
	output [31:0] instruction; 

	//test outputs
    output  [31:0] new_pc_tb, d_tb, q_tb;
	output [29:0] mux_output_tb; 

	//instantiate instruction fetch (in: d ... nPC_sel; out: instruction)

	instruction_fetch #(.program2(program1)) gtest (start_up, clk, nPC_sel, instruction, new_pc_tb, d_tb, q_tb, mux_output_tb); 
endmodule