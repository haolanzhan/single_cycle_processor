`timescale 1ns/10ps



module processor_test;
  	//inputs
  	reg clk_tb, start_up_tb;

	//output
	wire  [31:0]  busW_tb, aluresult_tb, instruction_tb;


    initial $monitor ("clk_tb: %b start_up_tb: %b instruction_tb: %b busW_tb: %b aluresult_tb: %b", 
                    clk_tb, start_up_tb, instruction_tb, busW_tb, aluresult_tb);
	 
	always #5 clk_tb = ~clk_tb;

	processor #(.program1("eecs361/data/unsigned_sum.dat")) better_than_mips (clk_tb, start_up_tb, instruction_tb, busW_tb, aluresult_tb);

	initial 
		begin
			$display("--------------------------------------------");
			$display("Reseting to initial PC value");
			clk_tb = 0;
        	start_up_tb = 1;
			#5;

			$display("Beginning program, running for at least 10 cycles");
			start_up_tb = 0;
			
            #120 $finish;
	end 
endmodule