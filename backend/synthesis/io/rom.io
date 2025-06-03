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
	(inst  name="rom_io_i/PAD_adr0"			place_status=fixed space = 0)
	(inst  name="rom_io_i/PAD_adr1"			place_status=fixed )
	(inst  name="rom_io_i/PAD_adr2"			place_status=fixed )
	(inst  name="rom_io_i/PAD_adr3"			place_status=fixed )
	(inst  name="rom_io_i/PAD_adr4"			place_status=fixed )    
	(inst name="VDDIORING" cell=PADVDDIOR			place_status=fixed )       

      )
    (top
	 (inst name="rom_io_i/PAD_d_o16"			place_status=fixed space = 0)
	 (inst name="rom_io_i/PAD_d_o17"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o18"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o19"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o20"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o21"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o22"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o23"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o24"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o25"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o26"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o27"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o28"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o29"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o30"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o31"			place_status=fixed )
    )
    (right
	(inst  name="rom_io_i/PAD_adr5"			place_status=fixed space = 0)
	(inst  name="rom_io_i/PAD_adr6"			place_status=fixed )
	(inst  name="rom_io_i/PAD_adr7"			place_status=fixed )
	(inst  name="rom_io_i/PAD_adr8"			place_status=fixed )
	(inst  name="rom_io_i/PAD_adr9"			place_status=fixed )
	(inst  name="rom_io_i/PAD_cs"			place_status=fixed )        
	(inst name="VSSIORING" cell=PADVSSIOR			place_status=fixed ) 
     )
     (bottom
	 (inst name="rom_io_i/PAD_d_o0"			place_status=fixed space = 0)
	 (inst name="rom_io_i/PAD_d_o1"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o2"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o3"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o4"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o5"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o6"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o7"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o8"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o9"			place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o10"		place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o11"		place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o12"		place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o13"		place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o14"		place_status=fixed )
	 (inst name="rom_io_i/PAD_d_o15"		place_status=fixed )
    )
)