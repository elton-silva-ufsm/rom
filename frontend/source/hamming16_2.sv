module hamming16_2 (
    input logic [20:0] d_in,   // 21-bit encoded input
    output logic [15:0] d_out, // 16-bit decoded output 
    output logic error_flag     // Error flag indicating if an error was detected
)

    logic [4:0]  parity, parity_in, parity_err;
    logic [20:0] corrected;

    assign parity_in = {d_in[15], d_in[7], d_in[3], d_in[1], d_in[0]};

    always_comb begin
        // P1 - 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
        parity[0] = d_in[2] ^ d_in[4] ^ d_in[6] ^ d_in[8] ^ d_in[10] ^ d_in[12] ^ d_in[14] ^ d_in[16] ^ d_in[18] ^ d_in[20];
        // P2 - 1, 3, 4, 5, 6	
        parity[1] = ^{d_in[2], d_in[5:4], d_in[9:8], d_in[13:12], d_in[17:16]};
        // P4 - 4, 5, 6, 11, 12, 13, 14, 19, 20
        parity[2] = ^{d_in[4:3], d_in[11:7], d_in[19:15]};
        // P8 - 8, 9, 10, 11, 12, 13, 14
        parity[3] = ^{d_in[11:8]};
        // P16 - 16, 17, 18, 19, 20
        parity[4] = ^{d_in[20:16]};
        
        // Compare the calculated parity with the received parity
        parity_err = parity_in ^ parity;
    end

    always_comb begin       

        error_flag = |parity_err;
        
        if (parity_err == 5'b00000) begin // No error
            corrected = d_in; 
        end else begin
            corrected = d_in ^ (1 << (parity_err[4:0]));
        end
    end

    always_comb begin
        d_out = {corrected[20:16], corrected[15:11], corrected[10:6], corrected[5:3]};
    end
    
    endmodule