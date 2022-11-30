`timescale 1ns/10ps

module full_shifter_test;
	reg		[31:0]	A;
	reg		[4:0]	B;
	wire	[31:0]	resr;
    wire	[31:0]	resl;

	full_right_logical_shifter frls(A, B, resr);
	full_left_logical_shifter flls(A, B, resl);

	initial $monitor ("A: %b B: %d       res_right: %b res_left: %b", A, B, resr, resl);

	integer i;

	initial 
		begin
			$display("--------------------------------------------");
			$display("Shift Test");

			A = 32'b01010101010101010101010101010101; 
			for (i = 0; i < 32; i = i + 1) begin
				B = i;
				#1;
			end

			$display("\n\n");
			#100
			A = 32'b10101010101010101010101010101010; 
			for (i = 0; i < 32; i = i + 1) begin
				B = i;
				#1;
			end

            #20 $finish;
		end 
endmodule