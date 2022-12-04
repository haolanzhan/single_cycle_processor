`timescale 1ns/10ps
`include "lib/full_adder_30.v"
`include "lib/dff.v"
`include "lib/sram.v"

module instruction_fetch(d, clk, imm16, npc_sel, instruction); 
// module instruction_fetch(d, clk, imm16, npc_sel, new_pc,); 

    //branch, zero can be a single signal npc_sel

    input [31:0] d;
    input [15:0] imm16;
    input clk, npc_sel;
    // output
    output [31:0] instruction;
    wire [31:0] new_pc;

    wire [29:0] ext_imm16;
    wire [29:0] one;
    wire [29:0] pc_selector;
    // output [29:0] pc_selector;
    
    wire [29:0] mux_output;
    // wire [29:0] zero;
    // output [29:0] mux_output;


    // wire [31:0] d; // pc d
    wire [31:0] q; // pc q
    // assign new_pc[31:0] = q[31:0];
    wire [31:0] sram_addr;
    assign sram_addr[1:0] = 2'b00;
    // assign d[31:0] = 32'b00000000010000000000000000100000;
    // assign d[31:0] = pc;
    assign d[1:0]         = 2'b00;
    assign q[1:0]         = 2'b00;
    assign new_pc[1:0] = 2'b00;
    

    genvar i;
    generate
        for (i = 2; i < 32; i = i + 1) begin
            dff pc(clk, d[i], q[i]);
        end
    endgenerate


    assign zero               = 30'h00000000;
    assign pc_selector[29:1]  = 30'h00000000;
    assign pc_selector[0]     = npc_sel;

    sign_ext_30 ext(imm16, ext_imm16);
    // and_gate branch_or_zero(branch, zero, pc_selector[0]);

    mux_n #(.n(30)) seq_or_branch(pc_selector, 30'h00000000, ext_imm16, mux_output[29:0]);

    // full_adder_30 add(q[31:2], mux_output[29:0], 1'b1, d[31:2]);
    
    full_adder_30 add2(q[31:2], mux_output[29:0], 1'b1, new_pc[31:2]);

    sram instr_mem(1'b1, 1'b1, 1'b0, new_pc, 32'b0, instruction); // should oe AND clk?
    
    // sram instr_mem(1'b1, 1'b1, 1'b0, d, 32'b0, instruction); // should oe AND clk?


endmodule
