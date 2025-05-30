#-----------------------------------------------------------------------------#
# DFT Configuration
#-----------------------------------------------------------------------------#
set_db dft_scan_style muxed_scan
set_db dft_prefix dft_
define_shift_enable -name {scan_en} -active {high} -create_port {scan_en}
define_shift_enable -name SE -active high -create_port SE
check_dft_rules


#-----------------------------------------------------------------------------#
# Scan Chain Setup
#-----------------------------------------------------------------------------#
set_db design:multiplier32FP .dft_min_number_of_scan_chains 1
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports
connect_scan_chains -auto_create_chains
syn_opt -incr


report_scan_chains > ${RPT_DIR}/${HDL_NAME}_scan_chains_dft.rpt
report_design_rules > ${RPT_DIR}/${HDL_NAME}_drc_dft.rpt

write_scandef ${HDL_NAME} > ${DEV_DIR}/${HDL_NAME}_dft.scandef
write_dft_atpg -library "${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/verilog/slow_vdd1v0_basicCells.v"

