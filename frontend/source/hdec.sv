
module hdec (
    input  logic [38:0] d_in,   // 39-bit encoded input (received d_in)
    output logic [31:0] d_out   // 32-bit decoded saida (corrected saida)
);

    logic [6:0]  paridade, paridade_in, paridade_err;
    logic [38:0] corrigido;

    assign paridade_in = {d_in[32], d_in[16], d_in[8], d_in[4], d_in[2], d_in[1], d_in[0]};

    always_comb begin
        // P0
        paridade[0] = ^{d_in[38:1]};
        // P1
        paridade[1] =   d_in[3]  ^ d_in[5]  ^ d_in[7]  ^ d_in[9]  ^ d_in[11] ^ d_in[13] ^ 
                        d_in[15] ^ d_in[17] ^ d_in[19] ^ d_in[21] ^ d_in[23] ^ d_in[25] ^
                        d_in[27] ^ d_in[29] ^ d_in[31] ^ d_in[33] ^ d_in[35] ^ d_in[37];
        // P2
        paridade[2] =   d_in[3]  ^ d_in[6]  ^ d_in[7]  ^ d_in[10] ^ d_in[11] ^ d_in[14] ^ 
                        d_in[15] ^ d_in[18] ^ d_in[19] ^ d_in[22] ^ d_in[23] ^ d_in[26] ^ 
                        d_in[27] ^ d_in[30] ^ d_in[31] ^ d_in[34] ^ d_in[35] ^ d_in[38];
        // P4
        paridade[3] = ^{d_in[38:36], d_in[31:28], d_in[23:20], d_in[15:12], d_in[7:5]};
        // P8
        paridade[4] = ^{d_in[15:9], d_in[31:24]};
        // P16
        paridade[5] = ^{d_in[31:17]};
        // P32
        paridade[6] = ^{d_in[38:33]};

        // Compare the calculated parity with the received parity
        paridade_err = paridade_in ^ paridade;
    end

    always_comb begin        
        if (paridade_err == 7'b000_0000) begin //No error
            corrigido = d_in; 
        end else begin
            corrigido = d_in ^ (1 << (paridade_err[6:1]));
        end
    end

    always_comb begin
        d_out = {corrigido[38:33], corrigido[31:17], corrigido[15:9], corrigido[7:5], corrigido[3]};
    end

endmodule
