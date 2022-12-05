`timescale 1ns/10ps


module garbage_test;
    reg start_up;
    reg clk;
    reg nPC_sel;

    wire [31:0] instruction, new_pc_tb, d_tb, q_tb;
    wire [29:0] mux_output_tb;

    always #5 clk = ~clk;

    initial $monitor ("start_up_tb: %b clk_tb: %b instruction_tb: %h new_pc_tb: %h d_tb: %h q_tb: %h mux_output_tb %h", 
                    clk, start_up, instruction, new_pc_tb, d_tb, q_tb, mux_output_tb);

    garbage #(.program1("eecs361/data/bills_branch.dat")) gg(start_up, clk, nPC_sel, instruction, new_pc_tb, d_tb, q_tb, mux_output_tb);

    initial begin
        clk = 0;
        start_up = 1;
        nPC_sel = 0;

        #5;
        start_up = 0;
        #100
        nPC_sel = 1;
        #100
        $finish;

    end

endmodule