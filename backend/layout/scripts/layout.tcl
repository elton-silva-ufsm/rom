#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
set PROJECT_DIR $env(PROJECT_DIR)
set TECH_DIR $env(TECH_DIR)
set DESIGNS $env(DESIGNS)
set HDL_NAME $env(HDL_NAME)
set VLOG_LIST $env(VLOG_LIST)
set CLK_PERIOD $env(CLK_PERIOD)
set INTERCONNECT_MODE ple

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
set MAIN_CLOCK_NAME clk
set MAIN_RST_NAME rst_n
set BEST_LIB_OPERATING_CONDITION PVT_1P32V_0C
set WORST_LIB_OPERATING_CONDITION PVT_0P9V_125C
set period_clk $CLK_PERIOD  ;
set clk_uncertainty 0.05 ;# ns (a guess)
set clk_latency 0.10 ;# ns (a guess)
set in_delay 0.30 ;# ns
set out_delay 0.30;#ns 
set out_load 0.045 ;#pF 
set slew "146 164 264 252" ;#minrise, minfall, maxrise, maxfall 
set slew_min_rise 0.146 ;# ns
set slew_min_fall 0.164 ;# ns
set slew_max_rise 0.264 ;# ns
set slew_max_fall 0.252 ;# ns
set NET_ZERO VSS ;# power net: see the lef file
set NET_ONE VDD ;# power net: see the lef file
#IO
# set MAIN_CLOCK_NAME io/clk
# set MAIN_RST_NAME io/rst_n


#------------------------Load Path File---------------------------------------
#-----------------------------------------------------------------------------
source ${PROJECT_DIR}/backend/synthesis/scripts/common/path.tcl


#----------set tech files to be used in ".globals" and ".view"----------------
#-----------------------------------------------------------------------------
set WORST_LIST ${LIB_DIR}/slow_vdd1v0_basicCells.lib
set BEST_LIST ${LIB_DIR}/fast_vdd1v2_basicCells.lib 
# set LEF_INIT "${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/lef/gsclib045_tech.lef ${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/lef/gsclib045_macro.lef";# ${TECH_DIR}/giolib045_v3.3/lef/giolib045.lef"
set CAP_MAX ${TECH_DIR}/gpdk045_v_6_0/soce/gpdk045.basic.CapTbl
set CAP_MIN ${TECH_DIR}/gpdk045_v_6_0/soce/gpdk045.basic.CapTbl
set QRC_LIST ${TECH_DIR}/gpdk045_v_6_0/qrc/rcworst/qrcTechFile
set LEF_INIT "${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/lef/gsclib045_tech.lef ${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/lef/gsclib045_macro.lef ${TECH_DIR}/giolib045_v3.3/lef/giolib045.lef"

#------Initiates the design files (netlist, LEFs, timing libraries)-----------
#-----------------------------------------------------------------------------
set_db init_power_nets $NET_ONE
set_db init_ground_nets $NET_ZERO
read_mmmc ${LAYOUT_DIR}/scripts/${DESIGNS}.view
read_physical -lef $LEF_INIT
# read_netlist ../../synthesis/deliverables/${DESIGNS}.v

# io
read_netlist "../../synthesis/deliverables/${DESIGNS}.v ../../synthesis/io/${DESIGNS}_chip.v ../../synthesis/io/${DESIGNS}_io.v"
read_io_file ../../synthesis/io/rom.io

init_design
connect_global_net $NET_ONE -type pg_pin -pin_base_name $NET_ONE -inst_base_name *
connect_global_net $NET_ZERO -type pg_pin -pin_base_name $NET_ZERO -inst_base_name *
set_db design_process_node 45

#-------------------------Specify floorplan-----------------------------------
#-----------------------------------------------------------------------------

# -core_density_size <aspectratio [rowdensity [left bottom right top]]>
# create_floorplan -core_margins_by die -site CoreSite -core_density_size 0.25 0.8 2.5 2.5 2.5 2.5
# create_floorplan -core_margins_by die -site CoreSite -core_density_size 0.25 0.8 3 3 3 3
#IO
create_floorplan -site CoreSite -core_density_size 0.2 0.7 232.0 232.0 232.0 233.0 ;# chip: io cells

#------------------Add ring (Power planning)----------------------------------
#-----------------------------------------------------------------------------
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_avoid_short 1
set_db add_rings_ignore_rows 0
set_db add_rings_extend_over_row 0
add_rings -type core_rings -jog_distance 0.6 -threshold 0.6 -nets "$NET_ONE $NET_ZERO" -follow core -layer {bottom Metal11 top Metal11 right Metal10 left Metal10} -width 0.7 -spacing 0.4 -offset 0.6

#--------------------Add stripes (Power planning)-----------------------------
#-----------------------------------------------------------------------------
add_stripes -block_ring_top_layer_limit Metal11 -max_same_layer_jog_length 0.44 -pad_core_ring_bottom_layer_limit Metal9 -set_to_set_distance 7 -pad_core_ring_top_layer_limit Metal11 -spacing 0.4 -layer Metal10 -block_ring_bottom_layer_limit Metal9 -width 0.22 -start_offset 1 -nets "$NET_ONE $NET_ZERO"

#-------------------------------Sroute----------------------------------------
#-----------------------------------------------------------------------------
route_special -connect core_pin -layer_change_range { Metal1(1) Metal11(11) } -block_pin_target nearest_target -core_pin_target first_after_row_end -allow_jogging 1 -crossover_via_layer_range { Metal1(1) Metal11(11) } -nets "$NET_ONE $NET_ZERO" -allow_layer_change 1 -target_via_layer_range { Metal1(1) Metal11(11) }

#-------------------------------Placement-------------------------------------
#-----------------------------------------------------------------------------
set_db place_global_place_io_pins 1
set_db place_global_reorder_scan 0
place_design

#------------------------------Extract RC-------------------------------------
#-----------------------------------------------------------------------------
set_db extract_rc_engine pre_route
extract_rc

#--------------------------preCTS optimization--------------------------------
#-----------------------------------------------------------------------------
# set_db opt_drv_fix_max_cap true ; set_db opt_drv_fix_max_tran true ; set_db opt_fix_fanout_load false
# opt_design -pre_cts

#-----------------------Pre-CTS timing verification---------------------------
#-----------------------------------------------------------------------------
set_db timing_analysis_type best_case_worst_case
time_design -pre_cts

#----------------CTS - Clock Concurrent Optimization Flow---------------------
#-----------------------------------------------------------------------------

# get_db clock_trees
# source ../scripts/cts.ccopt
# create_clock_tree_spec -out_file ../scripts/cts.spec ;# creates a database cts spec
# get_db clock_trees
# ccopt_design ;
# creates the clock tree

# delete_clock_tree_spec ;# removes the already loaded cts specification (reset_cts_config)
# look for "CTS constraint violations" in the innovus.log file
# GUI: Viewing clock tree results in the physical view
# select Clock -> CCOpt Clock Tree Debugger -> click OK for default selection in the window


#-----------------------Post-CTS timing verification--------------------------
#-----------------------------------------------------------------------------
set_db timing_analysis_type best_case_worst_case
set_db timing_analysis_clock_propagation_mode sdc_control
time_design -post_cts
time_design -post_cts -hold

#--------------------------postCTS optimization-------------------------------
#-----------------------------------------------------------------------------
#opt_design -post_cts ;# optimize for setup
#opt_design -post_cts ;# optimize for hold

#-------------------------------Routing---------------------------------------
#-----------------------------------------------------------------------------
# route_design

#----------------------Post-route timing verification-------------------------
#-----------------------------------------------------------------------------
set_db timing_analysis_type ocv
time_design -post_route > ../reports/${DESIGNS}_tns.rpt 
set_interactive_constraint_modes {normal_genus_slow_max}
set_propagated_clock [all_clocks] 
set_db timing_analysis_check_type setup
report_timing
set_db timing_analysis_check_type hold
report_timing

#------------------------Filler Cells Insertion-------------------------------
#-----------------------------------------------------------------------------
add_fillers -base_cells {FILL8 FILL64 FILL4 FILL32 FILL2 FILL16 FILL1}

#--------------------------Fix DRC violations---------------------------------
#-----------------------------------------------------------------------------
# check_drc
# delete_routes -regular_wire_with_drc ;# command to delete routed nets with DRC violations
# route_design ;# re-route the design
# check_drc
# route_eco -fix_drc ;# tries to fix remaining violation nets
# check_drc
# route_eco -route_only_layers 2:6;# route_only_layers option restricts eco routing to specified layer range 
# check_drc

#-----------------------------Write verilog-----------------------------------
#-----------------------------------------------------------------------------
write_netlist ../deliverables/${DESIGNS}_layout.v


#------------------------------Write SDF--------------------------------------
#-----------------------------------------------------------------------------
write_sdf -edge check_edge -map_setuphold merge_always -map_recrem merge_always -version 3.0  ../deliverables/${DESIGNS}_layout.sdf


#----------------------------Power Analysis-----------------------------------
#-----------------------------------------------------------------------------
get_db power_method ;# this command should return "static"
report_power -power_unit uW > ../reports/${DESIGNS}_power_no_VCD.rpt
set_db power_corner min
##set_default_switching_activity -reset
##set_default_switching_activity -input_activity 0.2 -period 100.0 ;# 100 = 10 Mhz
#set_db power_report_missing_nets true
#set_db power_method event_based

#---------------------------Add metal fill------------------------------------
#-----------------------------------------------------------------------------
add_metal_fill -layers {Metal1 Metal2 Metal3 Metal4 Metal5 Metal6 Metal7 Metal8 Metal9 Metal10 Metal11} ;#-nets {VDD VSS}

#------------------------------Write GDS--------------------------------------
#-----------------------------------------------------------------------------
write_stream -mode ALL -unit 2000 ../deliverables/${DESIGNS}.gsd
ls streamOut.map ;# this file should be created after write_stream command run

#------------------------------Write DEF--------------------------------------
#-----------------------------------------------------------------------------
write_def ../deliverables/${DESIGNS}_layout.def
report_area > ../reports/${DESIGNS}_area_layout.rpt
report_timing > ../reports/${DESIGNS}_timing_layout.rpt

#-----------------------------Save Design-------------------------------------
#-----------------------------------------------------------------------------
write_db to_drc_lvs.enc
gui_show

# exit