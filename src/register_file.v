`timescale 1ns/10ps

`include "../lib/and_gate.v"
`include "../lib/dec_n.v"

`include "mux_32_32.v"
`include "register.v"


// 32, 32-bit registers
module register_file(clk, regwr, rd, ra, rb, data,
                    outa, outb);
    input           clk, regwr;     // clock and write control
    input   [4:0]   rd, ra, rb;     // register values (write, read, read)
    input   [31:0]  data;          // data to write
    output  [31:0]  outa, outb;     // output lines

    wire    [31:0]  mux_wire[31:0]; // wires for read outputs
    output  [31:0]  decode_out;     // 32 bit output from decoder
    wire    [31:0]  enable;         // Enable signal ofr 32 registers

    genvar i;

    // Decode write reigster 
    dec_n #(.n(5)) reg_dec (rd, decode_out);

    // Generate 32 registers and their corresponding enable logic
    generate
        for (i = 0; i < 32; i = i + 1) begin
            // If it is the first register, generate the Zero register
            if (i == 0) begin
                assign mux_wire[i] = 32'h00000000;
            end else begin
                and_gate and_enable (regwr, decode_out[i], enable[i]);
                register reg_single (clk, enable[i], data, mux_wire[i]);
            end
        end
    endgenerate

    // Read output muxes
    mux_32_32 mux_a (ra, 
                    mux_wire[0], mux_wire[1], mux_wire[2], mux_wire[3], mux_wire[4], mux_wire[5], mux_wire[6], mux_wire[7],
                    mux_wire[8], mux_wire[9], mux_wire[10], mux_wire[11], mux_wire[12], mux_wire[13], mux_wire[14], mux_wire[15],
                    mux_wire[16], mux_wire[17], mux_wire[18], mux_wire[19], mux_wire[20], mux_wire[21], mux_wire[22], mux_wire[23],
                    mux_wire[24], mux_wire[25], mux_wire[26], mux_wire[27], mux_wire[28], mux_wire[29], mux_wire[30], mux_wire[31],
                    outa);

    mux_32_32 mux_b (rb, 
                    mux_wire[0], mux_wire[1], mux_wire[2], mux_wire[3], mux_wire[4], mux_wire[5], mux_wire[6], mux_wire[7],
                    mux_wire[8], mux_wire[9], mux_wire[10], mux_wire[11], mux_wire[12], mux_wire[13], mux_wire[14], mux_wire[15],
                    mux_wire[16], mux_wire[17], mux_wire[18], mux_wire[19], mux_wire[20], mux_wire[21], mux_wire[22], mux_wire[23],
                    mux_wire[24], mux_wire[25], mux_wire[26], mux_wire[27], mux_wire[28], mux_wire[29], mux_wire[30], mux_wire[31],
                    outb);

endmodule