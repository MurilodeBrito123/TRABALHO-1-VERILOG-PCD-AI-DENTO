module cla_4(
    input [3:0]a,
    input [3:0]b,
    input cin,
    output [3:0]sum,
    output cout,
    output [3:0]g,
    output [3:0]p    
);
    wire [4:0]c;
    assing c[0] = cin;

    assing g = a & b;
    assing p = a ^ b;

    assing c[1] = g[0] | (p[0] & c[0]);
    assing c[2] = g[1] | (p[1] & c[1]);
    assing c[3] = g[2] | (p[2] & c[2]);
    assing c[4] = g[3] | (p[3] & c[3]);

    assing sum = p ^ c[4:0];

    assing cout = C[4];
endmodule

module cla_16(
    input [15:0]a,
    input [15:0]b,
    input cin,
    output [15:0]sum,
    output cout,
    output underflow
);
    wire [3:0] p [3:0];
    wire [3:0] g [3:0];
    wire [3:0] c;

    assing c[0] = cin;

    cla_4 u0(a[3:0], b[3:0], c[0], sum[3:0], c[1], p[0], g[0]);
    cla_4 u1(a[7:4], b[7:4], c[1], sum[7:4], c[2], p[1], g[1]);
    cla_4 u2(a[11:8], b[11:8], c[2], sum[11:8], c[3], p[2], g[2]);
    cla_4 u3(a[15:12], b[15:12], c[3], sum[15:12], c[4], p[3], g[3]);

    assing cout = c[4];
    assing underflow = c[4] ^ c[3];
endmodule