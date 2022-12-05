`timescale 1ns/10ps

module datapath_test;
    reg           clk;
    reg   [31:0]  inst;
    reg           regwrite, regdst, extop, alusrc, memwrite, mem2reg, shiftctrl;
    reg   [3:0]   aluctrl;
    wire          zero, msb;
    wire  [31:0]  write, regout;

    
    datapath #(.file("../data/bills_branch.dat")) data_path_test (clk,
                            inst,
                            regwrite, regdst, extop, alusrc, memwrite, mem2reg, aluctrl, shiftctrl,
                            zero, msb, write, regout);

	initial $monitor ("clk: %d, inst: %b, zero: %d, msb: %d, write: %x, regout: %x", 
                        clk, inst, zero, msb, write, regout);

    always #5 clk = ~clk;

	initial 
		begin
			$display("--------------------------------------------");
			$display("Datapath Test");

            clk = 1;
            
            inst = 32'b00100000000001010000000000000001;
            regwrite = 1;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 0;
            mem2reg = 0;
            aluctrl = 4'b0010;
            shiftctrl = 0;

            #10

            inst = 32'b00100000000001100000000001100100;
            regwrite = 1;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 0;
            mem2reg = 0;
            aluctrl = 4'b0010;
            shiftctrl = 0;

            #10

            inst = 32'b00100000000000100001000000000000;
            regwrite = 1;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 0;
            mem2reg = 0;
            aluctrl = 4'b0010;
            shiftctrl = 0;

            #10

            inst = 32'b00000000000000100001010000000000;
            regwrite = 1;
            regdst = 1;
            extop = 0;
            alusrc = 0;
            memwrite = 0;
            mem2reg = 0;
            aluctrl = 4'b1000;
            shiftctrl = 1;

            #10

            inst = 32'b00100000010001110000000000101000;
            regwrite = 1;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 0;
            mem2reg = 0;
            aluctrl = 4'b0010;
            shiftctrl = 0;

            #10

            inst = 32'b10001100010000110000000000000000;
            regwrite = 1;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 0;
            mem2reg = 1;
            aluctrl = 4'b0010;
            shiftctrl = 0;

            #10

            inst = 32'b00000000010001110011000000101010;
            regwrite = 1;
            regdst = 1;
            extop = 0;
            alusrc = 0;
            memwrite = 0;
            mem2reg = 0;
            aluctrl = 4'b0111;
            shiftctrl = 0;

            #10
            $display("STORE ============================");

            inst = 32'b10101100010000110000000000100100;
            regwrite = 0;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 1;
            mem2reg = 0;
            aluctrl = 4'b0010;
            shiftctrl = 0;

            #10
            $display("LOAD ============================");
            
            inst = 32'b10001100010001000000000000101000;
            regwrite = 1;
            regdst = 0;
            extop = 1;
            alusrc = 1;
            memwrite = 0;
            mem2reg = 1;
            aluctrl = 4'b0010;
            shiftctrl = 0;


            #20 $finish;
		end 
endmodule