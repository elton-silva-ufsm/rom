module encoder;

localparam TESTS = 512;

logic [15:0] data;
logic [20:0] ham_encoded1;
int file, file1, file2, file3; 
logic par1, par2, par4, par8, par16;

initial begin 
    file = $fopen ("rom1.hex","w");
    file1 = $fopen ("expected1.hex","w");
    file2 = $fopen ("rom2.hex","w");

    for (int i = 0; i < TESTS; ++i) begin
        // data = $urandom();
        data = $urandom();
        
        // Calculate parity bits
        par1 = ^{data[1:0], data{4:3}, data[6], data[8], data[11:10], data[13], data[15]};
        // P2
        par2 = ^{data[0], data[3:2], data[6:5], data[10:9], data[13:12]};
        // P4
        par4 = ^{data[3:1], data[10:7], data[15:14]};
        // P8
        par8 = ^{data[10:4]};
        // P16
        par16 = ^{data[15:11]};
        // Construct the encoded data

        ham_encoded1 = {data[15:11], par16, data[10:4], par8, data[3:1], par4, data[0], par2, par1};
        // Write to file
        $fwrite(file, "%h\n", ham_encoded1);
        $fwrite(file1, "%h\n", data);

        // For the second file, we will use a different encoding scheme
        fwrite(file2, "%h\n", {data, par16, par8, par4, par2, par1});
    end

    $fclose(file);
    $fclose(file1);
    $fclose(file2);
    $finish;
end

endmodule
