module tb_cla_16;
    reg [15:0] a, b;
    reg cin;
    wire [15:0] sum;
    wire cout, over_under;
    reg [16:0] expected;

    Cla_16 uut (
        .a(a),
        .b(b),
        .Cin(cin),
        .sum(sum),
        .Cout(cout),
        .overflow(over_under)
    );

    task testa;
        begin
            #1;
            expected = a + b + cin;
            if ({cout, sum} !== expected)
                $display("ERRO: a=%h b=%h cin=%b | Esp=%h Obt=%h", a, b, cin, expected, {cout, sum});
            else
                $display("OK: a=%h b=%h cin=%b | Res=%h", a, b, cin, {cout, sum});
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_cla_16);
        
        $display("\n==== INICIO ====\n");
        a = 16'h0001; b = 16'h0001; cin = 0; testa();
        a = 16'hFFFF; b = 16'h0001; cin = 0; testa();
        a = 16'hAAAA; b = 16'h5555; cin = 0; testa();
        
        repeat (5) begin
            a = $random; b = $random; cin = $random % 2;
            testa();
        end
        
        $display("\n==== FIM ====\n");
        $finish;
    end
endmodule
