`timescale 1ns/10ps

module full_adder(a, b, cin, cout, s);
    input a, b, cin;
    output cout, s;
    wire w1, w2, w3, w4;

    // Sum bit
    xor_gate xor_1 (a, b, w1);
    xor_gate xor_2 (w1, cin, s);

    // Carry out bit
    and_gate and_1 (b, cin, w2);
    and_gate and_2 (a, cin, w3);
    and_gate and_3 (a, b, w4);

    or_gate or_2 (w4, w5, cout);
    or_gate or_1 (w2, w3, w5);
   


endmodule




    
