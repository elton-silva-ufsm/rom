module rom (
    input  logic [9:0]  adr, //adress
    input  logic        cs, //chipselect active in low
    output logic [31:0] d_o //data out
);

wire [38:0] mtrx_out;
wire [31:0] hdec_out;

matrix  mtrx (
    .address(adr),
    .data(mtrx_out)
);
hdec    hdec (
    .d_in(mtrx_out), 
    .d_out(hdec_out)
);

assign d_o = (!cs) ? hdec_out : 32'b0;

endmodule