`timescale 1ns/10ps

// Module interface
module somador_io (tie_low,
		tie_high,
		//
		clk_pad,
		clk_Y,
		rst_n_pad,
		rst_n_Y,
		carry_i_pad,
		carry_i_Y,
		a_i_pad,
		a_i_Y,
		b_i_pad,
		b_i_Y,
		carry_o_pad,
		carry_o_A,
		sum_o_pad,
		sum_o_A
);


// Ports definition 
input tie_low, tie_high;

input clk_pad, rst_n_pad, carry_i_pad;
	output	clk_Y, rst_n_Y, carry_i_Y;
		
input [7:0] a_i_pad, b_i_pad;
	output [7:0] a_i_Y, b_i_Y;
		
output [7:0] sum_o_pad;		
	input [7:0] sum_o_A;

output carry_o_pad;		
	input carry_o_A;
		

// Signals definition
wire tie_low, tie_high;

wire clk_pad, rst_n_pad, carry_i_pad;
	wire	clk_Y, rst_n_Y, carry_i_Y;
		
wire [7:0] a_i_pad, b_i_pad;
	wire [7:0] a_i_Y, b_i_Y;
		
wire [7:0] sum_o_pad;		
	wire [7:0] sum_o_A;

wire carry_o_pad;		
	wire carry_o_A;


wire VDD, VSS;



//---------------------------------------------------------------------------
// IO cells instantiation
//---------------------------------------------------------------------------

PADDI PAD_clk		( .Y(clk_Y), .PAD(clk_pad) );
PADDI PAD_rst_n		( .Y(rst_n_Y), .PAD(rst_n_pad) );
PADDI PAD_carry_i	( .Y(carry_i_Y), .PAD(carry_i_pad) );

PADDI PAD_a_i_0		( .Y(a_i_Y[0]), .PAD(a_i_pad[0]) );
PADDI PAD_a_i_1		( .Y(a_i_Y[1]), .PAD(a_i_pad[1]) );
PADDI PAD_a_i_2		( .Y(a_i_Y[2]), .PAD(a_i_pad[2]) );
PADDI PAD_a_i_3		( .Y(a_i_Y[3]), .PAD(a_i_pad[3]) );
PADDI PAD_a_i_4		( .Y(a_i_Y[4]), .PAD(a_i_pad[4]) );
PADDI PAD_a_i_5		( .Y(a_i_Y[5]), .PAD(a_i_pad[5]) );
PADDI PAD_a_i_6		( .Y(a_i_Y[6]), .PAD(a_i_pad[6]) );
PADDI PAD_a_i_7		( .Y(a_i_Y[7]), .PAD(a_i_pad[7]) );

PADDI PAD_b_i_0		( .Y(b_i_Y[0]), .PAD(b_i_pad[0]) );
PADDI PAD_b_i_1		( .Y(b_i_Y[1]), .PAD(b_i_pad[1]) );
PADDI PAD_b_i_2		( .Y(b_i_Y[2]), .PAD(b_i_pad[2]) );
PADDI PAD_b_i_3		( .Y(b_i_Y[3]), .PAD(b_i_pad[3]) );
PADDI PAD_b_i_4		( .Y(b_i_Y[4]), .PAD(b_i_pad[4]) );
PADDI PAD_b_i_5		( .Y(b_i_Y[5]), .PAD(b_i_pad[5]) );
PADDI PAD_b_i_6		( .Y(b_i_Y[6]), .PAD(b_i_pad[6]) );
PADDI PAD_b_i_7		( .Y(b_i_Y[7]), .PAD(b_i_pad[7]) );

PADDO PAD_sum_o_0	( .A(sum_o_A[0]), .PAD(sum_o_pad[0]) );
PADDO PAD_sum_o_1	( .A(sum_o_A[1]), .PAD(sum_o_pad[1]) );
PADDO PAD_sum_o_2	( .A(sum_o_A[2]), .PAD(sum_o_pad[2]) );
PADDO PAD_sum_o_3	( .A(sum_o_A[3]), .PAD(sum_o_pad[3]) );
PADDO PAD_sum_o_4	( .A(sum_o_A[4]), .PAD(sum_o_pad[4]) );
PADDO PAD_sum_o_5	( .A(sum_o_A[5]), .PAD(sum_o_pad[5]) );
PADDO PAD_sum_o_6	( .A(sum_o_A[6]), .PAD(sum_o_pad[6]) );
PADDO PAD_sum_o_7	( .A(sum_o_A[7]), .PAD(sum_o_pad[7]) );

PADDO PAD_carry_o	( .A(carry_o_A), .PAD(carry_o_pad) );


PADVDD VDDCORE 		( .VDD (VDD));
PADVSS VSSCORE 		( .VSS (VSS));


//-----------------------------------------------------------------------------------------------------
/* template for DIGITAL single signal from PAD (external world) to CORE: ".Y" goes to core **
PADDI PAD_clk		( .Y(<signal-TO-core>_Y), .PAD() );
*/


//-----------------------------------------------------------------------------------------------------
/* template for DIGITAL bus signal from PAD (external world) to CORE: ".Y" goes to core **
PADDI PAD_a_i_0		( .Y(a_i_Y[0]), .PAD(a_i_pad[0]) );
*/


//-----------------------------------------------------------------------------------------------------
/* template for DIGITAL signal from CORE to PAD (external world): ".A" cames from core **
PADDO PAD_carry_o	( .A(<signal-FROM-core>_A), .PAD() );
*/


//-----------------------------------------------------------------------------------------------------
/* template for DIGITAL bus signal from CORE to PAD (external world): ".A" cames from core **
PADDO PAD_sum_o_0		( .A(sum_o_A[0]), .PAD(sum_o_pad[0]) );
*/


/*
Digital output		
module PADDO (A, PAD);
input  A ;
output PAD ;

Digital input
module PADDI (PAD, Y);
input  PAD ;
output Y ;
*/




/* OTHER IO CELLS

PADVDD
PADVDDIOR -- IO ring power VDD cell

PADVSS
PADVSSIOR -- IO ring power VSS cell

padIORINGCORNER

padIORINGFEED1
padIORINGFEED3
padIORINGFEED5
padIORINGFEED10
padIORINGFEED60

*/



endmodule

