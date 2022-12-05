`timescale 1ns/10ps

module ext_16_32_test;
    reg     [15:0]  in;
    reg             sel;

	wire	[31:0]	out;


    ext_16_32 ext (sel, in, out);

	initial $monitor ("sel: %d, in: %b, out: %b", 
                        sel, in, out);

	initial 
		begin
			$display("--------------------------------------------");
			$display("Ext 16 32 Test");

            sel = 0;
            in = 123;
            #10

            sel = 1;

            #10

            sel = 0;
            in = -123;

            #10

            sel = 1;


            #20 $finish;
		end 
endmodule