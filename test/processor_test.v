`timescale 1ns/10ps



module processor_test;
  	//inputs
  	reg clk_tb, start_up_tb;

	//output
	wire [31:0] instruction, new_pc_out, busW, alu_result;
	wire RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, shiftctr;
	wire [3:0] ALUctr;
	wire [1:0] ALUop;

    initial $monitor ("clk_tb: %b start_up_tb: %b instruction: %h new_pc_out: %h busW: %h alu_result: %h", 
                    clk_tb, start_up_tb, instruction, new_pc_out, busW, alu_result);
	 
	always #5 clk_tb = ~clk_tb;

	processor #(.program1("eecs361/data/unsigned_sum.dat")) better_than_mips (clk_tb, start_up_tb, instruction, new_pc_out, busW, alu_result, RegWr, RegDst, ExtOp, AluSrc, MemWr, MemtoReg, shiftctr, ALUctr, ALUop);

	initial 
		begin
			$display("--------------------------------------------");
			$display("Reseting to initial PC value");
			clk_tb = 1;
        	start_up_tb = 1;
			#20;

			$display("Beginning program, running for at least 10 cycles");
			start_up_tb = 0;
			
            #600 $finish;
	end 
endmodule