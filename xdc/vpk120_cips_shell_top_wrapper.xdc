create_pblock pblock_Dynamic
add_cells_to_pblock [get_pblocks pblock_Dynamic] [get_cells -quiet [list vpk120_cips_shell_top_i/user_role_0]]
set_property SNAPPING_MODE ON [get_pblocks pblock_Dynamic]
set_property HD.RECONFIGURABLE true [get_cells -quiet [list vpk120_cips_shell_top_i/user_role_0]]
resize_pblock [get_pblocks pblock_Dynamic] -add {CLOCKREGION_X2Y1:CLOCKREGION_X9Y4}
resize_pblock [get_pblocks pblock_Dynamic] -add {CLOCKREGION_X1Y4}
resize_pblock [get_pblocks pblock_Dynamic] -add {CLOCKREGION_X1Y3}
resize_pblock [get_pblocks pblock_Dynamic] -add {CLOCKREGION_X1Y2}
resize_pblock [get_pblocks pblock_Dynamic] -add {CLOCKREGION_X0Y4}

#resize_pblock pblock_Dynamic -add {
#SLICE_X48Y0:SLICE_X83Y79
#BLI_X0Y0:BLI_X639Y0
#BLI_TMR_X0Y0:BLI_TMR_X19Y0
#IRI_QUAD_X6Y0:IRI_QUAD_X25Y347
#RAMB18_X1Y0:RAMB18_X1Y41
#RAMB36_X1Y0:RAMB36_X1Y20
#URAM288_X1Y0:URAM288_X1Y20
#}
#
#resize_pblock pblock_Dynamic -add {
#SLICE_X60Y80:SLICE_X83Y91
#IRI_QUAD_X12Y348:IRI_QUAD_X25Y395
#RAMB18_X1Y42:RAMB18_X1Y47
#RAMB36_X1Y21:RAMB36_X1Y23
#URAM288_X1Y21:URAM288_X1Y23
#URAM_CAS_DLY_X1Y0:URAM_CAS_DLY_X1Y0
#}

#set_property LOC AF9 [get_ports PCIE_REF_CLK_clk_p]
#
#set_property LOC AR1 [get_ports PCIE_grx_n[0]]
#set_property LOC AN1 [get_ports PCIE_grx_n[1]]
#set_property LOC AL1 [get_ports PCIE_grx_n[2]]
#set_property LOC AJ1 [get_ports PCIE_grx_n[3]]
#
#set_property LOC AG1 [get_ports PCIE_grx_n[4]]
#set_property LOC AE1 [get_ports PCIE_grx_n[5]]
#set_property LOC AD3 [get_ports PCIE_grx_n[6]]
#set_property LOC AC1 [get_ports PCIE_grx_n[7]]
#
