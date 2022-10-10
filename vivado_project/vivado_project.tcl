# Created : 7:44:33, Tue July 2, 2022 : Sanjay Rai

source ../device_type.tcl
create_project -force project_X project_X -part [DEVICE_TYPE_ES] 
set_property board_part [BOARD_TYPE_ES] [current_project]

proc create_CPM_BD {} {
    source ../IP/user_role_BD.tcl
    source ../IP/vpk120_cips_shell_top.tcl
    update_compile_order -fileset sources_1
    validate_bd_design -force
    generate_target all [get_files  ../IP/vpk120_cips_shell_top/vpk120_cips_shell_top.bd]
    create_ip_run [get_files -of_objects [get_fileset sources_1] ../IP/vpk120_cips_shell_top/vpk120_cips_shell_top.bd]
    launch_runs [get_runs vpk120_cips_shell_top*_synth*] -jobs 4
    wait_on_runs [get_runs vpk120_cips_shell_top*_synth*]
    make_wrapper -files [get_files vpk120_cips_shell_top.bd] -top
    update_compile_order -fileset sources_1
}

proc build_design { } {
    update_compile_order -fileset sources_1
    add_files -norecurse ../IP/vpk120_cips_shell_top/hdl/vpk120_cips_shell_top_wrapper.v
    update_compile_order -fileset sources_1
    update_compile_order -fileset sources_1
    launch_runs impl_1 -to_step write_device_image -jobs 4
    wait_on_run impl_1
    open_run impl_1
    report_clock_interaction -delay_type min_max -significant_digits 3 -name timing_1
}

proc create_CPM_BD_DFX {} {
    source ../IP/user_role_BD.tcl
    source ../IP/vpk120_cips_shell_top.tcl
    current_bd_design [get_bd_designs vpk120_cips_shell_top]
    set_property -dict [list CONFIG.ENABLE_DFX {true}] [get_bd_cells user_role_0]
    set_property -dict [list CONFIG.LOCK_PROPAGATE {true}] [get_bd_cells user_role_0]
    set_property APERTURES {{{0x201_0000_0000 64K}}} [get_bd_intf_pins /user_role_0/CPM2PL_S_AXI_INI]
    set_property APERTURES {{{0x201_8000_0000 32K}}} [get_bd_intf_pins /user_role_0/PS2PL_S_AXI_INI]
    set_property APERTURES {{{0x202_0000_0000 2M}}} [get_bd_intf_pins /user_role_0/DBG_HUB_INI]
    set_property APERTURES {{{0x0 2G} {0x8_0000_0000 8G}}} [get_bd_intf_pins /user_role_0/PL2DDR_M_AXI_INI]
    save_bd_design
    update_compile_order -fileset sources_1
    validate_bd_design -force
    update_compile_order -fileset sources_1
    generate_target all [get_files  ../IP/vpk120_cips_shell_top/vpk120_cips_shell_top.bd]
    create_ip_run [get_files -of_objects [get_fileset sources_1] ../IP/vpk120_cips_shell_top/vpk120_cips_shell_top.bd]
    launch_runs [get_runs vpk120_cips_shell_top*_synth*] -jobs 4
    wait_on_runs [get_runs vpk120_cips_shell_top*_synth*]
    make_wrapper -files [get_files vpk120_cips_shell_top.bd] -top
    update_compile_order -fileset sources_1
}

proc build_design_DFX { } {
    add_files -norecurse ../IP/vpk120_cips_shell_top/hdl/vpk120_cips_shell_top_wrapper.v
    add_files -fileset constrs_1 -norecurse ../xdc/vpk120_cips_shell_top_wrapper.xdc
    update_compile_order -fileset sources_1
    create_pr_configuration -name config_1 -partitions [list vpk120_cips_shell_top_i/user_role_0:user_role_inst_0 ]
    create_pr_configuration -name config_2 -partitions { }  -greyboxes [list vpk120_cips_shell_top_i/user_role_0 ]
    update_compile_order -fileset sources_1
    create_run child_0_impl_1 -parent_run impl_1 -flow {Vivado Implementation 2022} -pr_config config_2
    source ./pr_and_tandem_bitstream_params.tcl
    launch_runs impl_1 child_0_impl_1 -to_step write_bitstream -jobs 8
    wait_on_run {impl_1 child_0_impl_1}
    open_run impl_1
    report_clock_interaction -delay_type min_max -significant_digits 3 -name timing_1
    write_hw_platform -fixed -include_bit -force -file ./VPK120_top_wrapper.xsa
    #  Seperate Stage_1 and Stage_2  during Tandem pdi generation  for testin gpurpouses.
    set_property HD.TANDEM_BITSTREAMS SEPARATE [current_design]
    write_device_image ./srai_tandem_dfx_test
    

}

create_CPM_BD_DFX 
build_design_DFX

