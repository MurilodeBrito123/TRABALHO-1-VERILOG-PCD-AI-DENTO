module Cla_4(
    input [3:0]a,
    input [3:0]b,
    input Cin,
    output [3:0]sum,
    output Cout,
    output [3:0]P,
    output [3:0]G  
);
    wire [4:0]C;
    assign C[0] = Cin;

    assign G = a & b;
    assign P = a ^ b;

    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign C[4] = G[3] | (P[3] & C[3]);

    assign sum = P ^ C[3:0];

    assign Cout = C[4];
endmodule

module Cla_16(
    input [15:0]a,
    input [15:0]b,
    input Cin,
    output [15:0]sum,
    output Cout,
    output overflow
);
    wire [3:0] P [3:0];
    wire [3:0] G [3:0];
    wire [4:0] C;

    assign C[0] = Cin;

    Cla_4 u0(a[3:0], b[3:0], C[0], sum[3:0], C[1], P[0], G[0]);
    Cla_4 u1(a[7:4], b[7:4], C[1], sum[7:4], C[2], P[1], G[1]);
    Cla_4 u2(a[11:8], b[11:8], C[2], sum[11:8], C[3], P[2], G[2]);
    Cla_4 u3(a[15:12], b[15:12], C[3], sum[15:12], C[4], P[3], G[3]);

    assign Cout = C[4];
    
    assign overflow = C[4] ^ C[3];

endmodule
