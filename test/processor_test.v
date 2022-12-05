`timescale 1ns/10ps



module processor_test;
  	//inputs
  	reg clk_tb, start_up_tb;

	//output
	wire  [31:0]  busW_tb, aluresult_tb, instruction_tb, pc_d_tb, pc_q_tb, new_pc_out_tb;


    initial $monitor ("clk_tb: %b start_up_tb: %b instruction_tb: %h pc_d_tb: %h pc_q_tb: %h new_pc_out_tb %h: busW_tb: %h aluresult_tb: %h", 
                    clk_tb, start_up_tb, instruction_tb, pc_d_tb, pc_q_tb, busW_tb, aluresult_tb, new_pc_out_tb);
	 
	always #5 clk_tb = ~clk_tb;

	processor #(.program1("eecs361/data/bills_branch.dat")) better_than_mips (clk_tb, start_up_tb, instruction_tb, pc_d_tb, pc_q_tb, busW_tb, aluresult_tb);

	initial 
		begin
			$display("--------------------------------------------");
			$display("Reseting to initial PC value");
			clk_tb = 0;
        	start_up_tb = 1;
			#20;

			$display("Beginning program, running for at least 10 cycles");
			start_up_tb = 0;
			
            #145 $finish;
	end 
endmodule