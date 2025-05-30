module rom_tb;

    logic clk;
    logic [10:0] adr;
    logic [31:0] d_out;
    logic cs;

    logic [31:0] expected [0:1023];

    integer total_checks = 0;
    integer hits = 0;
    integer errors = 0;

    rom dut (.adr(adr[9:0]), .cs(cs), .d_o(d_out));

    initial begin
        $readmemh("rom.hex", expected);

        clk = 0;
        adr = 0;
        cs = 1'b0;

        forever begin 
            #5; 
            clk = ~clk;
        end
    end

    always @(posedge clk) begin
        if (adr < 1024) begin
            adr <= adr + 1;
        end else begin
            $display("Fim da simulação");
            $display("Total de verificações: %0d", total_checks);
            $display("Acertos: %0d", hits);
            $display("Erros: %0d", errors);
            $finish;
        end
    end

    always @(posedge clk) begin
        total_checks = total_checks + 1;

        if (d_out === expected[adr]) begin
            hits = hits + 1;
            $display("Correto! adr=%0d, esperado=%8h, recebido=%8h", adr, expected[adr], d_out);
        end else begin
            errors = errors + 1;
            $display("Errado! adr=%0d, esperado=%8h, recebido=%8h, dec_in=%10h, par=%7b", adr, expected[adr], d_out,dut.hdec.d_in, dut.hdec.paridade);
        end
    end

    // adding a error in dut.mtrx
    initial begin
        dut.mtrx.mem[1023] = 39'h1de19e3b45; // real value is 1dc19e3b45, expected is 3b0679d4
    end

endmodule