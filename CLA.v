module Cla_4(
    input [3:0]a,
    input [3:0]b,
    input Cin,
    output [3:0]sum,
    output Cout,
    output [3:0]G,
    output [3:0]P    
);
    wire [4:0]C;
    assing C[0] = Cin;

    assing G = a & b;
    assing P = a ^ b;

    assing C[1] = G[0] | (P[0] & C[0]);
    assing C[2] = G[1] | (P[1] & C[1]);
    assing C[3] = G[2] | (P[2] & C[2]);
    assing C[4] = G[3] | (P[3] & C[3]);

    assing sum = P ^ C[4:0];

    assing Cout = C[4];
endmodule

module Cla_16(
    input [15:0]a,
    input [15:0]b,
    input Cin,
    output [15:0]sum,
    output Cout,
    output underflow
);
    wire [3:0] P [3:0];
    wire [3:0] G [3:0];
    wire [3:0] C;

    assing C[0] = Cin;

    Cla_4 u0(a[3:0], b[3:0], C[0], sum[3:0], C[1], P[0], G[0]);
    Cla_4 u1(a[7:4], b[7:4], C[1], sum[7:4], C[2], P[1], G[1]);
    Cla_4 u2(a[11:8], b[11:8], C[2], sum[11:8], C[3], P[2], G[2]);
    Cla_4 u3(a[15:12], b[15:12], C[3], sum[15:12], C[4], P[3], G[3]);

    assing Cout = C[4];
    assing underflow = C[4] ^ C[3];
endmodule