module rom_io (
    adr_pad,
    adr_rom,
    cs_pad,
    cs_rom,
    d_o_rom,
    d_o_pad
);

input  [9:0]  adr_pad;
output [9:0]  adr_rom;

input         cs_pad;
output        cs_rom;

input  [31:0] d_o_rom;
output [31:0] d_o_pad;

wire VDD, VSS;

PADDI PAD_adr0 (.PAD(adr_pad[0]), .Y(adr_rom[0]));
PADDI PAD_adr1 (.PAD(adr_pad[1]), .Y(adr_rom[1]));
PADDI PAD_adr2 (.PAD(adr_pad[2]), .Y(adr_rom[2]));
PADDI PAD_adr3 (.PAD(adr_pad[3]), .Y(adr_rom[3]));
PADDI PAD_adr4 (.PAD(adr_pad[4]), .Y(adr_rom[4]));
PADDI PAD_adr5 (.PAD(adr_pad[5]), .Y(adr_rom[5]));
PADDI PAD_adr6 (.PAD(adr_pad[6]), .Y(adr_rom[6]));
PADDI PAD_adr7 (.PAD(adr_pad[7]), .Y(adr_rom[7]));
PADDI PAD_adr8 (.PAD(adr_pad[8]), .Y(adr_rom[8]));
PADDI PAD_adr9 (.PAD(adr_pad[9]), .Y(adr_rom[9]));

PADDI PAD_cs (.PAD(cs_pad), .Y(cs_rom));

PADDO PAD_d_o0  (.PAD(d_o_rom[0]),  .A(d_o_pad[0]));
PADDO PAD_d_o1  (.PAD(d_o_rom[1]),  .A(d_o_pad[1]));
PADDO PAD_d_o2  (.PAD(d_o_rom[2]),  .A(d_o_pad[2]));
PADDO PAD_d_o3  (.PAD(d_o_rom[3]),  .A(d_o_pad[3]));
PADDO PAD_d_o4  (.PAD(d_o_rom[4]),  .A(d_o_pad[4]));
PADDO PAD_d_o5  (.PAD(d_o_rom[5]),  .A(d_o_pad[5]));
PADDO PAD_d_o6  (.PAD(d_o_rom[6]),  .A(d_o_pad[6]));
PADDO PAD_d_o7  (.PAD(d_o_rom[7]),  .A(d_o_pad[7]));
PADDO PAD_d_o8  (.PAD(d_o_rom[8]),  .A(d_o_pad[8]));
PADDO PAD_d_o9  (.PAD(d_o_rom[9]),  .A(d_o_pad[9]));
PADDO PAD_d_o10 (.PAD(d_o_rom[10]), .A(d_o_pad[10]));
PADDO PAD_d_o11 (.PAD(d_o_rom[11]), .A(d_o_pad[11]));
PADDO PAD_d_o12 (.PAD(d_o_rom[12]), .A(d_o_pad[12]));
PADDO PAD_d_o13 (.PAD(d_o_rom[13]), .A(d_o_pad[13]));
PADDO PAD_d_o14 (.PAD(d_o_rom[14]), .A(d_o_pad[14]));
PADDO PAD_d_o15 (.PAD(d_o_rom[15]), .A(d_o_pad[15]));
PADDO PAD_d_o16 (.PAD(d_o_rom[16]), .A(d_o_pad[16]));
PADDO PAD_d_o17 (.PAD(d_o_rom[17]), .A(d_o_pad[17]));
PADDO PAD_d_o18 (.PAD(d_o_rom[18]), .A(d_o_pad[18]));
PADDO PAD_d_o19 (.PAD(d_o_rom[19]), .A(d_o_pad[19]));
PADDO PAD_d_o20 (.PAD(d_o_rom[20]), .A(d_o_pad[20]));
PADDO PAD_d_o21 (.PAD(d_o_rom[21]), .A(d_o_pad[21]));
PADDO PAD_d_o22 (.PAD(d_o_rom[22]), .A(d_o_pad[22]));
PADDO PAD_d_o23 (.PAD(d_o_rom[23]), .A(d_o_pad[23]));
PADDO PAD_d_o24 (.PAD(d_o_rom[24]), .A(d_o_pad[24]));
PADDO PAD_d_o25 (.PAD(d_o_rom[25]), .A(d_o_pad[25]));
PADDO PAD_d_o26 (.PAD(d_o_rom[26]), .A(d_o_pad[26]));
PADDO PAD_d_o27 (.PAD(d_o_rom[27]), .A(d_o_pad[27]));
PADDO PAD_d_o28 (.PAD(d_o_rom[28]), .A(d_o_pad[28]));
PADDO PAD_d_o29 (.PAD(d_o_rom[29]), .A(d_o_pad[29]));
PADDO PAD_d_o30 (.PAD(d_o_rom[30]), .A(d_o_pad[30]));
PADDO PAD_d_o31 (.PAD(d_o_rom[31]), .A(d_o_pad[31]));

PADVDD VDDCORE (.VDD(VDD));
PADVSS VSSCORE (.VSS(VSS));

endmodule
