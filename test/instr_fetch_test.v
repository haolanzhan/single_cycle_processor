`timescale 1ns/10ps


module instr_fetch_test;
    reg start_up;
    reg [31:0] pc;
    reg clk;
    reg npc_sel;

    wire [31:0] instruction, pc_d, pc_q, new_pc_out;

    
    always #5 clk = ~clk;

    instruction_fetch #(.program2("eecs361/data/bills_branch.dat")) ifu(start_up, clk, npc_sel, instruction, pc_d, pc_q, new_pc_out);

    initial begin
        clk = 0;
        start_up = 1;
        // imm16 = 16'b0;
        npc_sel = 0;

        #5;
        start_up = 0;
        #10;
        #10;
        #10;
        #10;
        
        #10;

        #10;

        #10;
        npc_sel = 1;

        #10;
        npc_sel = 0;

        #10;
        $finish;

    end

endmodule