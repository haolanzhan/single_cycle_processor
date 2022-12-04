`timescale 1ns/10ps

module instr_fetch_test(clk, imm16);

    input clk;
    input [15:0] imm16;
    wire [31:0] d;
    wire [29:0] q;
    

    assign d = 32'b00000000010000000000000000100000; //0x00400020

    genvar i;

    generate
        for (i = 2; i < 33; i = i + 1) begin
            dff pc(clk, d[i], q[i-2]);
        end
    endgenerate

    pc_update pc_u(q, imm16, 1'b0, 1'b0, d[31:2]);

    // q -> memory!



endmodule