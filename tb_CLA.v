`timescale 1ns/1ps

module tb_cla_16;

    reg [15:0] a, b;
    reg cin;

    wire [15:0] sum;
    wire cout;
    wire over_under;

    reg [16:0] ref;

    cla_16 uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout),
        .over_under(over_under)
    );

    initial begin
        $monitor("t=%0t | a=%h b=%h cin=%b | sum=%h cout=%b",
                  $time, a, b, cin, sum, cout);
    end

    task testa;
        begin
            #1;
            ref = a + b + cin;

            if ({cout, sum} !== ref) begin
                $display(" ERRO: a=%h b=%h cin=%b | esperado=%h obtido=%h",
                          a, b, cin, ref, {cout, sum});
            end else begin
                $display(" OK: a=%h b=%h cin=%b | resultado=%h",
                          a, b, cin, {cout, sum});
            end
        end
    endtask

    initial begin

        $display("\n==== INÍCIO DOS TESTES ====\n");

        a = 16'h0001; b = 16'h0001; cin = 0; testa();

        a = 16'h0001; b = 16'h0001; cin = 1; testa();

        a = 16'hFFFF; b = 16'h0001; cin = 0; testa();

        a = 16'hFFFF; b = 16'h0000; cin = 1; testa();

        a = 16'hAAAA; b = 16'h5555; cin = 0; testa();

        a = 16'h0000; b = 16'h0000; cin = 0; testa();

        repeat (10) begin
            a = $random;
            b = $random;
            cin = $random % 2;
            testa();
        end

        a = 16'h00FF; b = 16'h0001; cin = 0; testa();

        a = 16'h0FFF; b = 16'h0001; cin = 0; testa();

        $display("\n==== FIM DOS TESTES ====\n");

        $finish;
    end

endmodule
