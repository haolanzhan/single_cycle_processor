`timescale 1ns/10ps

module register_file_test;
    reg             clk, regwr;
    reg     [4:0]   rd, ra, rb;
    reg     [31:0]  data;

	wire	[31:0]	outa, outb, decode;


    register_file reg_file (clk, regwr, rd, ra, rb, data, outa, outb);

	initial $monitor ("clk: %d, wenb: %d, rd (write): %d, ra (read): %d, rb (read): %d, data: %d     outa: %d, outb: %d", 
                        clk, regwr, rd, ra, rb, data,
                        outa, outb);

	integer i;

    always #5 clk = ~clk;

	initial 
		begin
			$display("--------------------------------------------");
			$display("Register File Test");

            clk = 0;
            regwr = 1;
            ra = 5;
            rb = 31;
            rd = 0;
            data = 0;

			for (i = 0; i < 32; i = i + 1) begin
                rd = i;
                data = i + 2;
				#10;
			end

			$display("--------------------------------------------");
            regwr = 0;

            for (i = 0; i < 32; i = i + 1) begin
                ra = i;
                rb = i + 1;
				#10;
			end

            #20 $finish;
		end 
endmodule