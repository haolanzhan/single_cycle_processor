`timescale 1ns/10ps

// 32-bit 32 to 1 mux
module mux_32_32(sel, 
                in0, in1, in2, in3, in4, in5, in6, in7,
                in8, in9, in10, in11, in12, in13, in14, in15,
                in16, in17, in18, in19, in20, in21, in22, in23,
                in24, in25, in26, in27, in28, in29, in30, in31, 
                out);
    input   [4:0]   sel;
    input   [31:0]  in0, in1, in2, in3, in4, in5, in6, in7;
    input   [31:0]  in8, in9, in10, in11, in12, in13, in14, in15;
    input   [31:0]  in16, in17, in18, in19, in20, in21, in22, in23;
    input   [31:0]  in24, in25, in26, in27, in28, in29, in30, in31;

    output  [31:0]  out;

    wire    [31:0]  interm0[15:0];
    wire    [31:0]  interm1[7:0];
    wire    [31:0]  interm2[3:0];
    wire    [31:0]  interm3[1:0];

    genvar i;

    // Level 0
    full_mux mux_lve00 (sel[0], in0, in1, interm0[0][31:0]);
    full_mux mux_lve01 (sel[0], in2, in3, interm0[1][31:0]);
    full_mux mux_lve02 (sel[0], in4, in5, interm0[2][31:0]);
    full_mux mux_lve03 (sel[0], in6, in7, interm0[3][31:0]);
    full_mux mux_lve04 (sel[0], in8, in9, interm0[4][31:0]);
    full_mux mux_lve05 (sel[0], in10, in11, interm0[5][31:0]);
    full_mux mux_lve06 (sel[0], in12, in13, interm0[6][31:0]);
    full_mux mux_lve07 (sel[0], in14, in15, interm0[7][31:0]);
    full_mux mux_lve08 (sel[0], in16, in17, interm0[8][31:0]);
    full_mux mux_lve09 (sel[0], in18, in19, interm0[9][31:0]);
    full_mux mux_lve010 (sel[0], in20, in21, interm0[10][31:0]);
    full_mux mux_lve011 (sel[0], in22, in23, interm0[11][31:0]);
    full_mux mux_lve012 (sel[0], in24, in25, interm0[12][31:0]);
    full_mux mux_lve013 (sel[0], in26, in27, interm0[13][31:0]);
    full_mux mux_lve014 (sel[0], in28, in29, interm0[14][31:0]);
    full_mux mux_lve015 (sel[0], in30, in31, interm0[15][31:0]);


    // Level 1
    generate
        for (i = 0; i < 16; i = i + 2) begin
            full_mux mux_lve1 (sel[1], interm0[i][31:0], interm0[i+1][31:0], interm1[i / 2][31:0]);
        end
    endgenerate

    // Level 2
    generate
        for (i = 0; i < 8; i = i + 2) begin
            full_mux mux_lve2 (sel[2], interm1[i][31:0], interm1[i+1][31:0], interm2[i / 2][31:0]);
        end
    endgenerate

    // Level 3
    generate
        for (i = 0; i < 4; i = i + 2) begin
            full_mux mux_lve3 (sel[3], interm2[i][31:0], interm2[i+1][31:0], interm3[i / 2][31:0]);
        end
    endgenerate

    // Level 4
    full_mux mux_lve4 (sel[4], interm3[0][31:0], interm3[1][31:0], out);


endmodule

// 32-bit mux 
module full_mux(sel, A, B, out);
	input 			sel;
	input	[31:0] 	A;
	input	[31:0] 	B;
	output	[31:0] 	out;

	genvar i;

	generate
		for (i = 0; i < 32; i = i + 1) begin
			mux mux0 (sel, A[i], B[i], out[i]);
		end
	endgenerate

endmodule