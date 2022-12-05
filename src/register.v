`timescale 1ns/10ps

`include "../lib/dffr.v"
`include "../lib/mux.v"

// neg-edged 32-bit register
module register(clk, enable, d, q);
    input           clk, enable;
    input   [31:0]  d;  
    output  [31:0]  q;  

    genvar i;

    // Generate 32 copies of dff controled by single clock signal
    // for each of 32 bits
    generate
        for (i = 0; i < 32; i = i + 1) begin 
            bit_register reg_bit (clk, enable, d[i], q[i]);
        end
    endgenerate

endmodule 

// neg-edged 1-bit register
module bit_register(clk, enable, d, q);
    input   clk, enable, d;
    output  q;
    wire    d_in;

    // select between new (input) and old data (output)
    mux dmux (enable, q, d, d_in);
    dffr dff_gen (clk, d_in, q);

endmodule