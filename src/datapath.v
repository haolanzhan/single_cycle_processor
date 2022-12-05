`timescale 1ns/10ps

`include "../lib/mux_n.v"
`include "../lib/syncram.v"

`include "alu.v"
`include "ext_16_32.v"
`include "register_file.v"


module datapath (
    clk,
    inst,
    regwrite, regdst, extop, alusrc, memwrite, mem2reg, aluctrl,
    zero, msb
);
    input           clk;
    input   [31:0]  inst;
    input           regwrite, regdst, extop, alusrc, memwrite, mem2reg;
    input   [3:0]   aluctrl;
    output          zero, msb;

    wire    [4:0]   write_reg, regdst_ext;
    wire    [31:0]  read_data_1, read_data_2, write_data_reg;
    wire    [31:0]  ext_out, alu_mux_out, alu_mux_ctrl;
    wire    [31:0]  alu_result;
    wire            alu_carry, alu_overflow;
    wire    [31:0]  mem_data_out, mem_mux_ctrl;

    // Write register selection
    assign regdst_ext = 5'b00000;
    assign regdst_ext[0] = regdst;
    mux_n #(.n(5)) write_sel_mux (regdst_ext, inst[20:16], inst[15:11], write_reg);

    // Wiring for register file
    register_file reg_file (clk, regwrite, write_reg, inst[25:21], inst[20:16], write_data_reg, 
                            read_data_1, read_data_2);

    // Wiring for sign extender
    ext_16_32 immed_ext (extop, inst[15:0], ext_out);

    // ALU wiring
    assign alu_mux_ctrl = 32'b00000000000000000000000000000000;
    assign alu_mux_ctrl[0] = alusrc;
    mux_n #(.n(32)) write_sel_mux (alu_mux_ctrl, read_data_2, ext_out, alu_mux_out);
    
    alu data_path_alu (read_data_1, alu_mux_out, aluctrl, alu_carry, alu_overflow, zero, alu_result);
    assign msb = alu_result[31];

    // Data memory wiring
    syncram data_memory (clk, 1'b1, memwrite, memwrite, alu_result, read_data_2, mem_data_out);
    assign mem_mux_ctrl = 32'b00000000000000000000000000000000;
    assign mem_mux_ctrl[0] = mem2reg;
    mux_n #(.n(32)) mem_reg_mux (mem_mux_ctrl, alu_result, mem_data_out, write_data_reg);
    
endmodule