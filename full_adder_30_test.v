`timescale 1ns/10ps

module full_adder_30_test;
    reg [29:0] A, B;
    reg c;
    wire [29:0] out30;

    full_adder_30 fa30(A, B, c, out30);

    initial
        begin 
            c = 0;
            A = 30'h00400020;
            B = 30'h00000001;
            #10;

            A = 30'h00400020;
            B = 30'h00000001;
            
            #10;

            A = 30'h00400020;
            B = 30'h00004000;
            c = 1;
            #10;

            A = 30'h00400020;
            B = -30'h00000020;
            #10;
        
        end


endmodule