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


proc customize_BD {} {
    add_files ../IP/vpk120_cips_shell_top/vpk120_cips_shell_top.bd
    add_files ../IP/user_role/user_role.bd

}

#create_CPM_BD 

