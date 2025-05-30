`ifdef dir_home
    localparam string rom_path = `dir_home;
`else
    localparam string rom_path = "rom.hex";
`endif

module matrix (
    input  logic [9:0]  address,
    output logic [38:0] data
);

    logic [38:0] mem [0:1023];

    initial begin
        $readmemh(rom_path, mem);
    end

    always_comb begin
        data = mem[address];
    end
    
endmodule

// module matrix_tb;
//     logic [9:0] addr;
//     logic [38:0] data;

//     matrix dut (.address(addr), .data(data));

//     initial begin
//         for (int i = 0; i < 1024; i++) begin
//             #2 addr = i;
//             #2 $display("address = %4d : data = %10h", addr, data);
//         end
//     end
// endmodule