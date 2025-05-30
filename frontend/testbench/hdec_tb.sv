module tb;

logic [38:0] d_in;
logic [31:0] d_out;

logic [31:0] expected;
bit correct;

hdec dut (.d_in(d_in), .d_out(d_out));

initial begin
  expected = 32'hcafe_baca;
  d_in = 39'h65bf_ae58_b5;

  #2;
  $display("d_in  : %h\nd_out : %h\nexpec = %h\n", d_in, d_out, expected);
  $display("%8s\n", (d_out === expected) ? "Correto!" : "Errado");

  $display("\n_________\nFLIPANDO UM BIT RANDOM\n");

  expected = 32'hcafe_baca;
  d_in = 39'h65bf_ae78_b5;

  #2;
  $display("d_in  : %h\nd_out : %h\nexpec = %h\n", d_in, d_out, expected);
  $display("%8s\n", (d_out === expected) ? "Correto!" : "Errado");


  $display("\n_________\nFLIPANDO DOIS BIT RANDOM\n");

  expected = 32'h220438b6;
  d_in = 39'h11810f1777;

  #2;
  $display("d_in  : %h\nd_out : %h\nexpec = %h\n", d_in, d_out, expected);
  $display("%8s\n", (d_out === expected) ? "Correto!" : "Errado");

end

endmodule