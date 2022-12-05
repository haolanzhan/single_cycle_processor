`timescale 1ns/10ps
// `include "lib/sign_ext_30.v"

module sign_ext_test;
    reg [15:0] imm16;
    wire [29:0] out30;

    sign_ext_30 s_30(imm16, out30);

    initial
        begin 
            imm16 = 16'h0011;
            #10;

            imm16 = 16'hf100;
            #10;

        end
        

endmodule