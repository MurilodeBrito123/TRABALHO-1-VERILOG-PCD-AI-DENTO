module tb_Sub_e_add_CLA;
    reg [15:0] a, b;
    reg controle; //coltrole = 1 para subtração; 0 para adição
    wire [15:0] R;
    wire Cout, overflow;

    reg signed [16:0] sinal;
    integer erros = 0;

    Sub_ou_add16 uut (
        .a(a),
        .b(b),
        .controle(controle),
        .R(R),
        .Cout(Cout),
        .overflow(overflow)
    );

    task testa;
        begin
            #1;
            if (R !== sinal[15:0]) begin
                $display("A=%d B=%d OP=%d | Esp=%d Obt=%d",
                         $signed(a), $signed(b), controle, sinal, $signed(R));
                erros = erros + 1;
            end
                        if (sinal > 32767 || sinal < -32768) begin
                if (!overflow) begin
                    $display("ERRO OVERFLOW: A=%d B=%d OP=%d",
                             $signed(a), $signed(b), controle);
                    erros = erros + 1;
                end
            end else begin
                if (overflow) begin
                  $display("OVERFLOW: A=%d B=%d | OP=%d Obt=%d",
                           $signed(a), $signed(b), controle, $signed(R));
                    erros = erros + 1;
                end
            end
        end
    endtask

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, tb_Sub_e_add_CLA);
      controle = 0;
        a = 10; b = 20; testa();
        a = 32767; b = 1; testa();
        a = -32768; b = -1; testa();
        a = -50; b = 50; testa();
        a = 0; b = 0; testa();
        
        repeat (5) begin
            a = $random; b = $random; controle = $random % 2;
            testa();
        end
        
        $finish;
    end
endmodule