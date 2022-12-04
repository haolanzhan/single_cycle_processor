`timescale 1ns/10ps

module full_shifter_test;
    reg   [31:0]  in0, in1, in2, in3, in4, in5, in6, in7;
    reg   [31:0]  in8, in9, in10, in11, in12, in13, in14, in15;
    reg   [31:0]  in16, in17, in18, in19, in20, in21, in22, in23;
    reg   [31:0]  in24, in25, in26, in27, in28, in29, in30, in31;

	reg		[4:0]	sel;
	wire	[31:0]	out;

	mux_32_32 mux(sel,
                in0, in1, in2, in3, in4, in5, in6, in7,
                in8, in9, in10, in11, in12, in13, in14, in15,
                in16, in17, in18, in19, in20, in21, in22, in23,
                in24, in25, in26, in27, in28, in29, in30, in31, 
                out);

	initial $monitor ("sel: %d out: %d", sel, out);

	integer i;

	initial 
		begin
			$display("--------------------------------------------");
			$display("Mux 32 32 Test");

            in0 = 0;
            in1 = 1;
            in2 = 2;
            in3 = 3;
            in4 = 4;
            in5 = 5;
            in6 = 6;
            in7 = 7;
            in8 = 8;
            in9 = 9;
            in10 = 10;
            in11 = 11;
            in12 = 12;
            in13 = 13;
            in14 = 14;
            in15 = 15;
            in16 = 16;
            in17 = 17;
            in18 = 18;
            in19 = 19;
            in20 = 20;
            in21 = 21;
            in22 = 22;
            in23 = 23;
            in24 = 24;
            in25 = 25;
            in26 = 26;
            in27 = 27;
            in28 = 28;
            in29 = 29;
            in30 = 30;
            in31 = 31;

			for (i = 0; i < 32; i = i + 1) begin
				sel = i;
				#1;
			end

            #20 $finish;
		end 
endmodule