`timescale 1ns/10ps

module instruction_fetch_unit(pc, imm16, branch, zero) // pc needs to be passed back out to the main processor module where it lives as a dff
    input [29:0] pc;
    input [15:0] imm16;
    // output
    output [29:0] new_pc;

    wire [29:0] increment_pc_out, pc_immediate_out, ext_imm16;
    wire [29:0] one;
    wire [29:0] pc_selector;

    assign one = 30'b1;

    full_adder_32 increment_pc(pc, one, increment_pc_out);
    sign_ext_30 ext(imm16, ext_imm16);

    full_adder_32 pc_immediate(pc, ext_imm16, pc_immediate_out);

    assign [29:0] pc_selector = 30'h00000000;
    and_gate branch_or_zero(branch, zero, pc_selector[0]);
    
    mux_gate_n #(.n(30)) seq_or_branch(branch_or_zero, increment_pc, pc_immediate_out, new_pc;)

endmodule
