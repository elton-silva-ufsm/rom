`timescale 1ns/10ps


module somador_chip (
		clk_p, // "clk_p" connects to ".PAD" pin in "somador_io" -> turns to "clk_Y" in ".Y" and connects to "clk" in "somador"
		rst_n_p,
		carry_i_ip,
		a_i_ip,
		b_i_ip,
		carry_o_op,
		sum_o_op
);



//--------------------------------------
// Ports definition
//--------------------------------------

input clk_p, rst_n_p, carry_i_ip;
input [7:0] a_i_ip, b_i_ip;
output carry_o_op;
output [7:0] sum_o_op;


//--------------------------------------
// Signals definition 
//--------------------------------------

wire tie_low, tie_high;

// IO <=> CHIP Interface
wire clk_p, rst_n_p, carry_i_ip;
wire [7:0] a_i_ip, b_i_ip;
wire carry_o_op;
wire [7:0] sum_o_op;


// ${DESIGN} Interface
wire clk_pad, rst_n_pad, carry_i_pad;
	wire	clk_Y, rst_n_Y, carry_i_Y;
wire [7:0] a_i_pad, b_i_pad;
	wire [7:0] a_i_Y, b_i_Y;
wire [7:0] sum_o_pad;		
	wire [7:0] sum_o_A;
wire carry_o_pad;		
	wire carry_o_A;




// ${DESIGN} instance
 somador i_somador (
	.clk (clk_Y), 
	.rst_n (rst_n_Y),
	.carry_i (carry_i_Y),
	.a_i (a_i_Y),
	.b_i (b_i_Y),
	.carry_o (carry_o_A),
	.sum_o (sum_o_A)
	);
	

// IO Instance 
  somador_io i_somador_io (
		.tie_low (tie_low),
		.tie_high (tie_high),
		.clk_pad (clk_p),
		.clk_Y (clk_Y),
		.rst_n_pad (rst_n_p),
		.rst_n_Y (rst_n_Y),
		.carry_i_pad (carry_i_ip),
		.carry_i_Y (carry_i_Y),
		.a_i_pad (a_i_ip),
		.a_i_Y (a_i_Y),
		.b_i_pad (b_i_ip),
		.b_i_Y (b_i_Y),
		.carry_o_pad (carry_o_op),
		.carry_o_A (carry_o_A),
		.sum_o_pad (sum_o_op),
		.sum_o_A (sum_o_A)
	);




endmodule




