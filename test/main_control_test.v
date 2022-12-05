`timescale 1ns/10ps

module main_control_test;
  	//inputs
  	reg [5:0] Opcode_tb; 
  	reg Zero_tb, AluResMsb_tb;

	//output
 	wire [1:0] AluOp_tb; 
  	wire nPC_sel_tb, RegWr_tb, RegDst_tb, ExtOp_tb, AluSrc_tb, MemWr_tb, MemtoReg_tb, Branch_tb;

    initial $monitor ("Opcode_tb: %b Zero_tb: %b AluResMsb_tb: %b nPC_sel_tb: %b RegWr_tb: %b RegDst_tb: %b ExtOp_tb: %b AluSrc_tb: %b AluOp_tb: %b MemWr_tb: %b MemtoReg_tb: %b Branch_tb: %b", 
                    Opcode_tb, Zero_tb, AluResMsb_tb, nPC_sel_tb, RegWr_tb, RegDst_tb, ExtOp_tb, AluSrc_tb, AluOp_tb, MemWr_tb, MemtoReg_tb, Branch_tb);
	 
	main_control dut(Opcode_tb, Zero_tb, AluResMsb_tb, nPC_sel_tb, RegWr_tb, RegDst_tb, ExtOp_tb, AluSrc_tb, AluOp_tb, MemWr_tb, MemtoReg_tb, Branch_tb);

	initial 
		begin
			Opcode_tb = 6'b000000;
			Zero_tb = 1'b0;
			AluResMsb_tb = 1'b0;
			
			$display("--------------------------------------------");
			$display("R-type instructions (produce same control signals)");
			Opcode_tb = 6'b000000;
			#10

			$display("--------------------------------------------");
			$display("addi instruction (I-type)");
			Opcode_tb = 6'b001000;
			#10

			$display("--------------------------------------------");
			$display("lw instruction (I-type)");
			Opcode_tb = 6'b100011;
			#10

			$display("--------------------------------------------");
			$display("sw instruction (I-type)");
			Opcode_tb = 6'b101011;
			#10

			$display("--------------------------------------------");
			$display("beq instruction (I-type), branch not taken");
			Opcode_tb = 6'b000100;
			Zero_tb = 1'b0;
			#10

			$display("--------------------------------------------");
			$display("beq instruction (I-type), branch taken");
			Zero_tb = 1'b1;
			#10

			$display("--------------------------------------------");
			$display("bne instruction (I-type), branch not taken");
			Opcode_tb = 6'b000101;
			Zero_tb = 1'b1;
			#10

			$display("--------------------------------------------");
			$display("bne instruction (I-type), branch taken");
			Zero_tb = 1'b0;
			#10

			$display("--------------------------------------------");
			$display("bgtz instruction (I-type), branch not taken");
			Opcode_tb = 6'b000111;
			Zero_tb = 1'b1;
			AluResMsb_tb = 1'b0;
			#10
			Zero_tb = 1'b1;
			AluResMsb_tb = 1'b1;
			#10
			Zero_tb = 1'b0;
			AluResMsb_tb = 1'b1;
			#10

			$display("--------------------------------------------");
			$display("bgtz instruction (I-type), branch taken");
			Zero_tb = 1'b0;
			AluResMsb_tb = 1'b0;

            #20 $finish;
	end 
endmodule