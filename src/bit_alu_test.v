`timescale 1ns/10ps

module bit_alu_test;
	reg a, b, bneg, cin, less;
	reg [3:0] ctrl;
	wire res, cout, over, set; 

    initial $monitor ("a: %b b: %b bneg: %b cin: %b less: %b      cout: %b over: %b set: %b res: %d", 
                    a, b, bneg, cin, less, cout, over, set, res);
	 
	// full_adder fa(a, b, cin, res, cout);
	msb_alu msb_alu(a, b, bneg, cin, less, ctrl, res, cout, over, set);

// insert data
	initial 
		begin
			less = 1'b0;
// Test add
			$display("--------------------------------------------");
			$display("Test Add");
			bneg = 1'b0;
			ctrl = 3'b010;
// 000
			a = 1'b0;
			b = 1'b0;
			cin = 1'b0;
			#10
// 001
			a = 1'b0;
			b = 1'b0;
			cin = 1'b1;
			#10
// 010
			a = 1'b0;
			b = 1'b1;
			cin = 1'b0;
			#10
// 011
			a = 1'b0;
			b = 1'b1;
			cin = 1'b1;
			#10
// 100
			a = 1'b1;
			b = 1'b0;
			cin = 1'b0;
			#10
// 101
			a = 1'b1;
			b = 1'b0;
			cin = 1'b1;
			#10
// 110
			a = 1'b1;
			b = 1'b1;
			cin = 1'b0;
			#10
// 111
			a = 1'b1;
			b = 1'b1;
			cin = 1'b1;
			#50

// Test sub
			$display("--------------------------------------------");
			$display("Test Sub");
			ctrl = 3'b110;
			bneg = 1'b1;
// 00
			a = 1'b0;
			b = 1'b0;
			cin = 1'b1;
			#10
// 011
			a = 1'b0;
			b = 1'b1;
			cin = 1'b1;
			#10
// 101
			a = 1'b1;
			b = 1'b0;
			cin = 1'b1;
			#10
// 111
			a = 1'b1;
			b = 1'b1;
			cin = 1'b1;
			#50

// Test and 
			$display("--------------------------------------------");
			$display("Test And");
			bneg = 1'b0;
			ctrl = 3'b000;

			a = 1'b0;
			b = 1'b0;
			#10

			a = 1'b0;
			b = 1'b1;
			#10

			a = 1'b1;
			b = 1'b0;
			#10

			a = 1'b1;
			b = 1'b1;
			#50

// Test or 
			$display("--------------------------------------------");
			$display("Test Or");
			ctrl = 3'b001;

			a = 1'b0;
			b = 1'b0;
			#10

			a = 1'b0;
			b = 1'b1;
			#10

			a = 1'b1;
			b = 1'b0;
			#10

			a = 1'b1;
			b = 1'b1;
			#50

// Test xor 
			$display("--------------------------------------------");
			$display("Test Xor");
			ctrl = 3'b011;

			a = 1'b0;
			b = 1'b0;
			#10

			a = 1'b0;
			b = 1'b1;
			#10

			a = 1'b1;
			b = 1'b0;
			#10

			a = 1'b1;
			b = 1'b1;
			#50

// Test SLT 
			$display("--------------------------------------------");
			$display("Test SLT");
			ctrl = 3'b111;
			bneg = 1'b1;

			a = 1'b0;
			b = 1'b0;
			cin = 1'b1;
			less = 1'b0;
			#10

			a = 1'b0;
			b = 1'b1;
			cin = 1'b1;
			less = 1'b0;
			#10

			a = 1'b1;
			b = 1'b0;
			cin = 1'b1;
			less = 1'b0;
			#10

			a = 1'b1;
			b = 1'b1;
			cin = 1'b1;
			less = 1'b0;
			#10

			less = 1'b1;
			#50

// Test SLTU 
			$display("--------------------------------------------");
			$display("Test SLTU");
			ctrl = 3'b0101;
		
			a = 1'b0;
			b = 1'b0;
			cin = 1'b1;
			less = 1'b0;
			#10

			a = 1'b0;
			b = 1'b1;
			cin = 1'b1;
			less = 1'b0;
			#10

			a = 1'b1;
			b = 1'b0;
			cin = 1'b1;
			less = 1'b0;
			#10

			a = 1'b1;
			b = 1'b1;
			cin = 1'b1;
			less = 1'b0;
			#10

			less = 1'b1;
			#50


            #20 $finish;
			
	end 
endmodule