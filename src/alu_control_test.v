`timescale 1ns/10ps

module alu_control_test;
	reg [1:0] ALUop_tb;
	reg [5:0] func_tb;
	wire [3:0] ALUctr_tb;
	wire SllFlag_tb;

    initial $monitor ("ALUop_tb: %b func_tb: %b ALUctr_tb: %b SllFlag_tb: %b", 
                    ALUop_tb, func_tb, ALUctr_tb, SllFlag_tb);
	 
	alu_control dut(ALUop_tb, func_tb, ALUctr_tb, SllFlag_tb);

	initial 
		begin
			ALUop_tb = 2'b00;
			func_tb = 6'b000000;

			$display("--------------------------------------------");
			$display("add instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b100000;
			#10

			$display("--------------------------------------------");
			$display("addu instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b100001;
			#10

			$display("--------------------------------------------");
			$display("sub instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b100010;
			#10

			$display("--------------------------------------------");
			$display("subu instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b100011;
			#10

			$display("--------------------------------------------");
			$display("and instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b100100;
			#10

			$display("--------------------------------------------");
			$display("or instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b100101;
			#10

			$display("--------------------------------------------");
			$display("sll instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b000000;
			#10

			$display("--------------------------------------------");
			$display("slt instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b101010;
			#10

			$display("--------------------------------------------");
			$display("sltu instruction (R-type)");
			ALUop_tb = 2'b10;
			func_tb = 6'b101001;
			#10

			$display("--------------------------------------------");
			$display("addi, lw, sw instruction (I-type using add)");
			ALUop_tb = 2'b00;
			#10

			$display("--------------------------------------------");
			$display("beq, bne, bgtz instruction (I-type using sub)");
			ALUop_tb = 2'b01;
			#10
            #20 $finish;
			
	end 
endmodule