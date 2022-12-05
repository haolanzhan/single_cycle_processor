`timescale 1ns/10ps

module datapath_test;
    reg           clk;
    reg   [31:0]  inst;
    reg           regwrite, regdst, extop, alusrc, memwrite, mem2reg;
    reg   [3:0]   aluctrl;
    wire          zero, msb;

    
    datapath data_path_test (clk,
                            inst,
                            regwrite, regdst, extop, alusrc, memwrite, mem2reg, aluctrl,
                            zero, msb);

	initial $monitor ("clk: %d, wenb: %d, rd (write): %d, ra (read): %d, rb (read): %d, data: %d     outa: %d, outb: %d, decode: %b", 
                        clk, regwr, rd, ra, rb, data,
                        outa, outb, decode);

	// integer i;

    // always #5 clk = ~clk;

	// initial 
	// 	begin
	// 		$display("--------------------------------------------");
	// 		$display("Datapath Test");

    //         clk = 0;
    //         regwr = 1;
    //         ra = 5;
    //         rb = 31;
    //         rd = 0;
    //         data = 0;

	// 		for (i = 0; i < 32; i = i + 1) begin
    //             rd = i;
    //             data = i + 2;
	// 			#10;
	// 		end

	// 		$display("--------------------------------------------");
    //         regwr = 0;

    //         for (i = 0; i < 32; i = i + 1) begin
    //             ra = i;
    //             rb = i + 1;
	// 			#10;
	// 		end

    //         #20 $finish;
	// 	end 
endmodule