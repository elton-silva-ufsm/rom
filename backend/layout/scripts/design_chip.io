# CADENCE INNOVUS uses a coordinate system that bases the coordinate (0,0) on the bottomleft corner
# On the left and right side the IOs will be ordered from bottom-to-top, and on the top and bottom side the pads will be ordered from left-to-right

# The name of the IO should match the name of the instance in the Verilog file



(globals
    version = 3
    space = 20
    io_order = clockwise # counterclockwise|clockwise|default
    total_edge = 4
)



# ( row_margin
#  ( top
#  ( io_row ring_number = 1 margin = 0)
#  ( io_row ring_number = 2 margin = 100)
#  ( io_row ring_number = 3 margin = 200)
# ) 


(iopad

    (topright 	 (inst name="CORNER_TR" cell=padIORINGCORNER	place_status=fixed )) # CORNER
    (bottomright (inst name="CORNER_BR" cell=padIORINGCORNER	place_status=fixed )) # CORNER
    (topleft	 (inst name="CORNER_TL" cell=padIORINGCORNER	place_status=fixed )) # CORNER
    (bottomleft	 (inst name="CORNER_BL" cell=padIORINGCORNER	place_status=fixed )) # CORNER


    (left
	(inst  name="i_somador_io/PAD_clk"			place_status=fixed space = 0)
	(inst  name="i_somador_io/PAD_rst_n"			place_status=fixed )
	(inst  name="i_somador_io/PAD_carry_i"			place_status=fixed )
	(inst  name="i_somador_io/PAD_carry_o"			place_status=fixed )        

	(inst name="i_somador_io/VDDCORE"			place_status=fixed )
	(inst name="i_somador_io/VSSCORE" 			place_status=fixed )        
	(inst name="VDDIORING" cell=PADVDDIOR			place_status=fixed )        
	(inst name="VSSIORING" cell=PADVSSIOR			place_status=fixed )        

      )
    (top
	(inst  name="i_somador_io/PAD_a_i_0"			place_status=fixed space = 0)
	(inst  name="i_somador_io/PAD_a_i_1"			place_status=fixed )
	(inst  name="i_somador_io/PAD_a_i_2"			place_status=fixed )
	(inst  name="i_somador_io/PAD_a_i_3"			place_status=fixed )
	(inst  name="i_somador_io/PAD_a_i_4"			place_status=fixed )
	(inst  name="i_somador_io/PAD_a_i_5"			place_status=fixed )
	(inst  name="i_somador_io/PAD_a_i_6"			place_status=fixed )
	(inst  name="i_somador_io/PAD_a_i_7"			place_status=fixed )
    )
    (right
	(inst  name="i_somador_io/PAD_b_i_0"			place_status=fixed space = 0)
	(inst  name="i_somador_io/PAD_b_i_1"			place_status=fixed )
	(inst  name="i_somador_io/PAD_b_i_2"			place_status=fixed )
	(inst  name="i_somador_io/PAD_b_i_3"			place_status=fixed )
	(inst  name="i_somador_io/PAD_b_i_4"			place_status=fixed )
	(inst  name="i_somador_io/PAD_b_i_5"			place_status=fixed )
	(inst  name="i_somador_io/PAD_b_i_6"			place_status=fixed )
	(inst  name="i_somador_io/PAD_b_i_7"			place_status=fixed )
     )
     (bottom
	(inst  name="i_somador_io/PAD_sum_o_0"			place_status=fixed space = 0)
	(inst  name="i_somador_io/PAD_sum_o_1"			place_status=fixed )
	(inst  name="i_somador_io/PAD_sum_o_2"			place_status=fixed )
	(inst  name="i_somador_io/PAD_sum_o_3"			place_status=fixed )
	(inst  name="i_somador_io/PAD_sum_o_4"			place_status=fixed )
	(inst  name="i_somador_io/PAD_sum_o_5"			place_status=fixed )
	(inst  name="i_somador_io/PAD_sum_o_6"			place_status=fixed )
	(inst  name="i_somador_io/PAD_sum_o_7"			place_status=fixed )
    )
)