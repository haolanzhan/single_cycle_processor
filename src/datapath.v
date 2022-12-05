`timescale 1ns/10ps

`include "lib/mux_n.v"
`include "lib/syncram.v"
`include "lib/not_gate_32.v"

`include "src/alu.v"
`include "src/ext_16_32.v"
`include "src/register_file.v"


module datapath (
    clk,
    inst,
    regwrite, regdst, extop, alusrc, memwrite, mem2reg, aluctrl, shiftctrl,
    zero, msb, write, regout
);
    parameter file="";

    input           clk;
    input   [31:0]  inst;
    input           regwrite, regdst, extop, alusrc, memwrite, mem2reg, shiftctrl;
    input   [3:0]   aluctrl;
    output          zero, msb;
    output  [31:0]  write, regout;

    wire    [4:0]   write_reg, regdst_ext;
    wire    [4:0]   ra_reg, ra_reg_ctrl;
    wire    [31:0]  read_data_1, read_data_2, write_data_reg;
    wire    [31:0]  ext_out, alu_data_mux_out, alu_mux_ctrl;
    wire    [31:0]  shift_amt_ext, alu_shift_ctrl, alu_shift_mux_out;
    wire    [31:0]  alu_result;
    wire            alu_carry, alu_overflow;
    wire    [31:0]  mem_data_out, mem_mux_ctrl;

    // Write register selection
    assign regdst_ext = 5'b00000;
    assign regdst_ext[0] = regdst;
    mux_n #(.n(5)) write_sel_mux (regdst_ext, inst[20:16], inst[15:11], write_reg);

    // Ra register selection
    assign ra_reg_ctrl = 5'b00000;
    assign ra_reg_ctrl[0] = shiftctrl;
    mux_n #(.n(5)) ra_reg_sel_mux (ra_reg_ctrl, inst[25:21], inst[20:16], ra_reg);

    // Wiring for register file
    register_file reg_file (clk, regwrite, write_reg, ra_reg, inst[20:16], write_data_reg, 
                            read_data_1, read_data_2);

    // Wiring for sign extender
    ext_16_32 immed_ext (extop, inst[15:0], ext_out);

    // ALU b data select
    assign alu_mux_ctrl = 32'b00000000000000000000000000000000;
    assign alu_mux_ctrl[0] = alusrc;
    mux_n #(.n(32)) alu_data_sel_mux (alu_mux_ctrl, read_data_2, ext_out, alu_data_mux_out);

    // Alu shift select
    assign shift_amt_ext = 32'b00000000000000000000000000000000;
    assign shift_amt_ext[4:0] = inst[10:6];
    assign alu_shift_ctrl = 32'b00000000000000000000000000000000;
    assign alu_shift_ctrl[0] = shiftctrl;
    mux_n #(.n(32)) alu_sift_sel_mux (alu_shift_ctrl, alu_data_mux_out, shift_amt_ext, alu_shift_mux_out);
    
    // ALU wiring
    alu data_path_alu (read_data_1, alu_shift_mux_out, aluctrl, alu_carry, alu_overflow, zero, alu_result);
    assign msb = alu_result[31];

    ////////////////

    // Data memory wiring
    syncram #(.mem_file(file)) data_memory (clk, 1'b1, 1'b1, memwrite, alu_result, read_data_2, mem_data_out);
    assign mem_mux_ctrl[31:1] = 31'b0000000000000000000000000000000;
    assign mem_mux_ctrl[0] = mem2reg;
    mux_n #(.n(32)) mem_reg_mux (mem_mux_ctrl, alu_result, mem_data_out, write_data_reg);

 

    assign write = write_data_reg;
    assign regout = alu_result;
    
endmodule