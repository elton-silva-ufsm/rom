module rom_chip (
    adr_pad,
    cs_pad,
    d_o_pad
);

input  [9:0]  adr_pad;
input         cs_pad;
output [31:0] d_o_pad;

wire [9:0]  adr_rom;
wire        cs_rom;
wire [31:0] d_o_rom;

rom_io rom_io_i (
    .adr_pad(adr_pad),
    .adr_rom(adr_rom),
    .cs_pad(cs_pad),
    .cs_rom(cs_rom),
    .d_o_pad(d_o_pad),
    .d_o_rom(d_o_rom)
);

rom rom_i (
    .adr(adr_rom),
    .cs(cs_rom),
    .d_o(d_o_rom)
);

endmodule
