`timescale 1ns/1ps

module tb_bcd_7seg;

reg  [3:0] bcd;
wire [6:0] seg;
integer i;

bcd_7seg ai_dento (
    .bcd(bcd),
    .seg(seg)
);

initial begin
    $display("BCD | SEG");
    $display("------------");

    for (i = 0; i <= 15; i++) begin
        bcd = i;
        #10;
        $display("%2d  | %7b", bcd, seg);
    end

    $finish;
end

endmodule