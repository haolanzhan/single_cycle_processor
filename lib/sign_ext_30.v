`timescale 1ns/10ps
`include "lib/mux_n.v"

module sign_ext_30(imm16, imm16_ext);

    input [15:0] imm16;
    output [29:0] imm16_ext;

    wire [13:0] all_zero, all_one;
    wire [13:0] extension_bits;
    wire [13:0] selection;

    assign all_zero = 14'b00000000000000;
    assign all_one  = 14'b11111111111111;

    assign selection    = 14'b00000000000000;
    assign selection[0] = imm16[15];
    

    mux_n #(.n(14)) mux_14(selection, all_zero, all_one, extension_bits);

    // concatenate and then return
    assign  imm16_ext[15:0] = imm16;
    assign  imm16_ext[29:16]= extension_bits;
    
endmodule