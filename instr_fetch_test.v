`timescale 1ns/10ps


module instr_fetch_test;
    reg [31:0] pc;
    reg clk;
    reg [15:0] imm16 ;
    reg npc_sel;

    // wire [31:0] q;
    wire [31:0] instruction;

    
    always #10 clk = ~clk;

    instruction_fetch ifu(pc, clk, imm16, npc_sel, instruction);

    initial begin
        clk = 0;
        pc = 32'h00400020;
        imm16 = 16'b0;
        npc_sel = 0;

        #10;
        #10;
        #10;
        #10;
        $finish;

    end

endmodule