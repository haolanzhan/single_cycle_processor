`timescale 1ns/10ps


module instr_fetch_test;
    reg start_up;
    reg [31:0] pc;
    reg clk;
    reg [15:0] imm16 ;
    reg npc_sel;
    wire [31:0] output_pc;

    // wire [31:0] q;
    wire [31:0] instruction;

    
    always #10 clk = ~clk;

    instruction_fetch ifu(pc, start_up, clk, imm16, npc_sel, instruction, output_pc);

    initial begin
        clk = 0;
        start_up = 1;
        pc = 32'h00400020;
        imm16 = 16'b0;
        npc_sel = 0;

        #10;
        start_up = 0;
        #10;
        #10;
        imm16 = 16'h8;
        npc_sel = 1;
        #10;
        #10;
        imm16 = -16'h8;
        npc_sel = 1;
        #10;
        #10;
        npc_sel = 0;
        #10;
        
        $finish;

    end

endmodule