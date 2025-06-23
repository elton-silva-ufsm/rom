module hamming16 (
    input logic [15:0] d_in,
    input logic [4:0]  p_in,
    output logic [15:0] d_out,
    output logic error_flag,
);

    logic [4:0]  parity, parity_err;
    logic [15:0] corrected;

//       1    	 2	     3	     4	     5	     6	     7	     8	     9	    10	    11	    12	    13	    14	    15	    16	    17	    18	    19	    20	    21

//                       0               1               3               4               6               8              10              11              13              15
//                       0                       2       3                       5       6                       9      10                      12      13            
//                                       1       2       3                                       7       8       9      10                                      14      15
//                                                                       4       5       6       7       8       9      10      
//                                                                                                                                      11      12      13      14      15
//  000001	000010	000011	000100	000101	000110	000111	001000	001001	001010	001011	001100	001101	001110	001111	010000	010001	010010	010011	010100	010101
//                       0               1       2       3               4       5       6       7       8       9      10              11      12      13      14      15

    always_comb begin
        // P1
        parity[0] = d_in[0] ^ d_in[1] ^ d_in[3] ^ d_in[4] ^ d_in[6] ^ d_in[8] ^ d_in[10] ^ d_in[11] ^ d_in[13] ^ d_in[15];
        // P2
        parity[1] = ^{d_in[0], d_in[3:2], d_in[6:5], d_in[10:9], d_in[13:12]};
        // P4
        parity[2] = ^{d_in[3:1], d_in[10:7], d_in[15:14]};
        // P8
        parity[3] = ^{d_in[10:4]};
        // P16
        parity[4] = ^{d_in[15:11]};

        // Compare the calculated parity with the received parity
        parity_err = p_in ^ parity;
    end

    // The value of `parity_err` indicates the position (1 to 21) of the bit with the error,
    // considering both parity and data bits as a single sequence.
    // Since the `d_in` vector contains only the 16 data bits (excluding parity bits),
    // we need to adjust the index to correct the appropriate bit within `d_in`.

    // The parity bits are located at positions 1, 2, 4, 8, and 16 (1-based indexing).
    // Therefore, depending on the value of `parity_err`, we must subtract
    // the number of parity bits that come before it, to map it correctly to an index in `d_in`.

    // Examples:
    // - If the error is at position 3 (parity_err = 3), two parity bits come before (positions 1 and 2),
    //   so the data bit index is 3 - 2 = 1.
    // - If the error is at position 5, parity bits at positions 1, 2, and 4 come before.
    //   So the index is 5 - 3 = 2.
    // - This logic continues depending on the parity_err value:
    //     - 3          → subtract 3
    //     - 5,6,7      → subtract 4
    //     - 9 to 15    → subtract 5
    //     - 16 to 21   → subtract 6

    // This adjustment is implemented in the case block below.

    always_comb begin   

        error_flag = 1'b0;
        corrected = d_in;   
  
    case (parity_err)
        5'd0: begin
            corrected = d_in;
            error_flag = 1'b0; // No error
        end
        5'd3: begin
            corrected = d_in ^ (1 << (parity_err - 3));
        end
        5'd7, 5'd6, 5'd5: begin
            corrected = d_in ^ (1 << (parity_err - 4));
        end
        5'd15, 5'd14, 5'd13, 5'd12, 5'd11, 5'd10, 5'd9: begin
            corrected = d_in ^ (1 << (parity_err - 5));
        end
        5'd20, 5'd19, 5'd18, 5'd17, 5'd16: begin
            corrected = d_in ^ (1 << (parity_err - 6));
        end
        default: begin
            corrected = 'x;
            error_flag = 1'b1;
        end
    endcase

    end

    always_comb begin
        d_out = corrected;
    end

endmodule