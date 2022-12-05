`timescale 1ns/10ps

`include "../lib/mux_n.v"

module ext_16_32 (sel, in, out);
    input           sel;
    input   [15:0]  in;
    output  [31:0]  out;

    wire [15:0] all_zero, all_one;
    wire [15:0] extension_interm, extension_bits;
    wire [15:0] selection, sign;
    

    assign all_zero     = 16'b0000000000000000;
    assign all_one      = 16'b1111111111111111;

    assign selection    = 16'b0000000000000000;
    assign selection[0] = in[15];
    
    assign sign         = 16'b0000000000000000;
    assign sign[0]      = sel;

    mux_n #(.n(16)) mux_16_1(selection, all_zero, all_one, extension_interm);

    mux_n #(.n(16)) mux_16_2(sign, all_zero, extension_interm, extension_bits);

    // concatenate and then return
    assign  out[15:0] = in;
    assign  out[31:16]= extension_bits;
    
endmodule