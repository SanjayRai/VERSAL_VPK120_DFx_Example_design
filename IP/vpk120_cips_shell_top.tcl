
################################################################
# This is a generated script based on design: vpk120_cips_shell_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source vpk120_cips_shell_top_script.tcl


# The design that will be created by this Tcl script contains the following 
# block design container source references:
# user_role

# Please add the sources before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvp1202-vsva2785-2MP-e-S-es1
   set_property BOARD_PART xilinx.com:vpk120_es_revb:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name vpk120_cips_shell_top

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ../IP/

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2030 -severity "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_gid_msg -ssname BD::TCL -id 2031 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_gid_msg -ssname BD::TCL -id 2032 -severity "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2033 -severity "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2034 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2035 -severity "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_gid_msg -ssname BD::TCL -id 2036 -severity "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2037 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_gid_msg -ssname BD::TCL -id 2038 -severity "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:emb_mem_gen:1.0\
xilinx.com:ip:axi_noc:1.0\
xilinx.com:ip:axis_ila:1.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:versal_cips:3.2\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Block Design Container Sources
##################################################################
set bCheckSources 1
set list_bdc_active "user_role"

array set map_bdc_missing {}
set map_bdc_missing(ACTIVE) ""
set map_bdc_missing(BDC) ""

if { $bCheckSources == 1 } {
   set list_check_srcs "\ 
user_role \
"

   common::send_gid_msg -ssname BD::TCL -id 2056 -severity "INFO" "Checking if the following sources for block design container exist in the project: $list_check_srcs .\n\n"

   foreach src $list_check_srcs {
      if { [can_resolve_reference $src] == 0 } {
         if { [lsearch $list_bdc_active $src] != -1 } {
            set map_bdc_missing(ACTIVE) "$map_bdc_missing(ACTIVE) $src"
         } else {
            set map_bdc_missing(BDC) "$map_bdc_missing(BDC) $src"
         }
      }
   }

   if { [llength $map_bdc_missing(ACTIVE)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2057 -severity "ERROR" "The following source(s) of Active variants are not found in the project: $map_bdc_missing(ACTIVE)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
      set bCheckIPsPassed 0
   }
   if { [llength $map_bdc_missing(BDC)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2059 -severity "WARNING" "The following source(s) of variants are not found in the project: $map_bdc_missing(BDC)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: static_shell
proc create_hier_cell_static_shell { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_static_shell() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 CPM2PL_M_AXI_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 DBG_HUB_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 PCIE

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REF_CLK

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:inimm_rtl:1.0 PL2DDR_S_AXI_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 PS2PL_M_AXI_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch0_lpddr4_trip1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch0_lpddr4_trip2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch1_lpddr4_trip1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch1_lpddr4_trip2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lpddr4_clk1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lpddr4_clk2


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst CPM_axi_aresetn
  create_bd_pin -dir O -type clk CPM_clk

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 axi_bram_ctrl_0_bram ]
  set_property -dict [ list \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
 ] $axi_bram_ctrl_0_bram

  # Create instance: axi_noc_0, and set properties
  set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
  set_property -dict [ list \
   CONFIG.CH0_LPDDR4_0_BOARD_INTERFACE {ch0_lpddr4_trip1} \
   CONFIG.CH0_LPDDR4_1_BOARD_INTERFACE {ch0_lpddr4_trip2} \
   CONFIG.CH1_LPDDR4_0_BOARD_INTERFACE {ch1_lpddr4_trip1} \
   CONFIG.CH1_LPDDR4_1_BOARD_INTERFACE {ch1_lpddr4_trip2} \
   CONFIG.CONTROLLERTYPE {LPDDR4_SDRAM} \
   CONFIG.LOGO_FILE {data/noc_mc.png} \
   CONFIG.MC0_CONFIG_NUM {config26} \
   CONFIG.MC0_FLIPPED_PINOUT {true} \
   CONFIG.MC1_CONFIG_NUM {config26} \
   CONFIG.MC1_FLIPPED_PINOUT {true} \
   CONFIG.MC2_CONFIG_NUM {config26} \
   CONFIG.MC3_CONFIG_NUM {config26} \
   CONFIG.MC_ADDR_BIT2 {CA0} \
   CONFIG.MC_ADDR_BIT3 {CA1} \
   CONFIG.MC_ADDR_BIT4 {CA2} \
   CONFIG.MC_ADDR_BIT5 {CA3} \
   CONFIG.MC_ADDR_BIT6 {CH_SEL} \
   CONFIG.MC_ADDR_BIT7 {CA4} \
   CONFIG.MC_ADDR_BIT8 {NC} \
   CONFIG.MC_ADDR_BIT14 {BA0} \
   CONFIG.MC_ADDR_BIT15 {BA1} \
   CONFIG.MC_ADDR_BIT16 {BA2} \
   CONFIG.MC_ADDR_WIDTH {6} \
   CONFIG.MC_BA_WIDTH {3} \
   CONFIG.MC_BG_WIDTH {0} \
   CONFIG.MC_BOARD_INTRF_EN {true} \
   CONFIG.MC_BURST_LENGTH {16} \
   CONFIG.MC_CASLATENCY {36} \
   CONFIG.MC_CASWRITELATENCY {18} \
   CONFIG.MC_CH0_LP4_CHA_ENABLE {true} \
   CONFIG.MC_CH0_LP4_CHB_ENABLE {true} \
   CONFIG.MC_CH1_LP4_CHA_ENABLE {true} \
   CONFIG.MC_CH1_LP4_CHB_ENABLE {true} \
   CONFIG.MC_CHANNEL_INTERLEAVING {true} \
   CONFIG.MC_CHAN_REGION1 {DDR_LOW1} \
   CONFIG.MC_CH_INTERLEAVING_SIZE {64_Bytes} \
   CONFIG.MC_CKE_WIDTH {0} \
   CONFIG.MC_CK_WIDTH {0} \
   CONFIG.MC_COMPONENT_DENSITY {16Gb} \
   CONFIG.MC_COMPONENT_WIDTH {x32} \
   CONFIG.MC_CONFIG_NUM {config26} \
   CONFIG.MC_DATAWIDTH {32} \
   CONFIG.MC_DDR_INIT_TIMEOUT {0x00036330} \
   CONFIG.MC_DM_WIDTH {4} \
   CONFIG.MC_DQS_WIDTH {4} \
   CONFIG.MC_DQ_WIDTH {32} \
   CONFIG.MC_ECC_SCRUB_PERIOD {0x004C4C} \
   CONFIG.MC_ECC_SCRUB_SIZE {4096} \
   CONFIG.MC_EN_BACKGROUND_SCRUBBING {true} \
   CONFIG.MC_F1_CASLATENCY {36} \
   CONFIG.MC_F1_CASWRITELATENCY {18} \
   CONFIG.MC_F1_LPDDR4_MR13 {0x00C0} \
   CONFIG.MC_F1_TCCD_L {0} \
   CONFIG.MC_F1_TCCD_L_MIN {0} \
   CONFIG.MC_F1_TFAW {30000} \
   CONFIG.MC_F1_TFAWMIN {30000} \
   CONFIG.MC_F1_TMOD {0} \
   CONFIG.MC_F1_TMOD_MIN {0} \
   CONFIG.MC_F1_TMRD {14000} \
   CONFIG.MC_F1_TMRDMIN {14000} \
   CONFIG.MC_F1_TMRW {10000} \
   CONFIG.MC_F1_TMRWMIN {10000} \
   CONFIG.MC_F1_TRAS {42000} \
   CONFIG.MC_F1_TRASMIN {42000} \
   CONFIG.MC_F1_TRCD {18000} \
   CONFIG.MC_F1_TRCDMIN {18000} \
   CONFIG.MC_F1_TRPAB {21000} \
   CONFIG.MC_F1_TRPABMIN {21000} \
   CONFIG.MC_F1_TRPPB {18000} \
   CONFIG.MC_F1_TRPPBMIN {18000} \
   CONFIG.MC_F1_TRRD {7500} \
   CONFIG.MC_F1_TRRDMIN {7500} \
   CONFIG.MC_F1_TRRD_L {0} \
   CONFIG.MC_F1_TRRD_L_MIN {0} \
   CONFIG.MC_F1_TRRD_S {0} \
   CONFIG.MC_F1_TRRD_S_MIN {0} \
   CONFIG.MC_F1_TWR {18000} \
   CONFIG.MC_F1_TWRMIN {18000} \
   CONFIG.MC_F1_TWTR {10000} \
   CONFIG.MC_F1_TWTRMIN {10000} \
   CONFIG.MC_F1_TWTR_L {0} \
   CONFIG.MC_F1_TWTR_L_MIN {0} \
   CONFIG.MC_F1_TWTR_S {0} \
   CONFIG.MC_F1_TWTR_S_MIN {0} \
   CONFIG.MC_F1_TZQLAT {30000} \
   CONFIG.MC_F1_TZQLATMIN {30000} \
   CONFIG.MC_INPUTCLK0_PERIOD {4992} \
   CONFIG.MC_INPUT_FREQUENCY0 {200.321} \
   CONFIG.MC_INTERLEAVE_SIZE {256} \
   CONFIG.MC_IP_TIMEPERIOD0_FOR_OP {1071} \
   CONFIG.MC_IP_TIMEPERIOD1 {512} \
   CONFIG.MC_LP4_CA_A_WIDTH {6} \
   CONFIG.MC_LP4_CA_B_WIDTH {6} \
   CONFIG.MC_LP4_CKE_A_WIDTH {1} \
   CONFIG.MC_LP4_CKE_B_WIDTH {1} \
   CONFIG.MC_LP4_CKT_A_WIDTH {1} \
   CONFIG.MC_LP4_CKT_B_WIDTH {1} \
   CONFIG.MC_LP4_CS_A_WIDTH {1} \
   CONFIG.MC_LP4_CS_B_WIDTH {1} \
   CONFIG.MC_LP4_DMI_A_WIDTH {2} \
   CONFIG.MC_LP4_DMI_B_WIDTH {2} \
   CONFIG.MC_LP4_DQS_A_WIDTH {2} \
   CONFIG.MC_LP4_DQS_B_WIDTH {2} \
   CONFIG.MC_LP4_DQ_A_WIDTH {16} \
   CONFIG.MC_LP4_DQ_B_WIDTH {16} \
   CONFIG.MC_LP4_RESETN_WIDTH {1} \
   CONFIG.MC_MEMORY_DENSITY {2GB} \
   CONFIG.MC_MEMORY_DEVICETYPE {Components} \
   CONFIG.MC_MEMORY_DEVICE_DENSITY {16Gb} \
   CONFIG.MC_MEMORY_SPEEDGRADE {LPDDR4-4267} \
   CONFIG.MC_MEMORY_TIMEPERIOD0 {512} \
   CONFIG.MC_MEMORY_TIMEPERIOD1 {512} \
   CONFIG.MC_MEM_DEVICE_WIDTH {x32} \
   CONFIG.MC_NO_CHANNELS {Dual} \
   CONFIG.MC_ODTLon {8} \
   CONFIG.MC_ODT_WIDTH {0} \
   CONFIG.MC_PER_RD_INTVL {0} \
   CONFIG.MC_PRE_DEF_ADDR_MAP_SEL {ROW_BANK_COLUMN} \
   CONFIG.MC_REFRESH_SPEED {1x} \
   CONFIG.MC_STACKHEIGHT {1} \
   CONFIG.MC_SYSTEM_CLOCK {Differential} \
   CONFIG.MC_TCCD {8} \
   CONFIG.MC_TCCD_L {0} \
   CONFIG.MC_TCCD_L_MIN {0} \
   CONFIG.MC_TCKE {15} \
   CONFIG.MC_TCKEMIN {15} \
   CONFIG.MC_TDQS2DQ_MAX {800} \
   CONFIG.MC_TDQS2DQ_MIN {200} \
   CONFIG.MC_TDQSCK_MAX {3500} \
   CONFIG.MC_TFAW {30000} \
   CONFIG.MC_TFAWMIN {30000} \
   CONFIG.MC_TFAW_nCK {0} \
   CONFIG.MC_TMOD {0} \
   CONFIG.MC_TMOD_MIN {0} \
   CONFIG.MC_TMPRR {0} \
   CONFIG.MC_TMRD {14000} \
   CONFIG.MC_TMRDMIN {14000} \
   CONFIG.MC_TMRD_div4 {10} \
   CONFIG.MC_TMRD_nCK {28} \
   CONFIG.MC_TMRW {10000} \
   CONFIG.MC_TMRWMIN {10000} \
   CONFIG.MC_TMRW_div4 {10} \
   CONFIG.MC_TMRW_nCK {20} \
   CONFIG.MC_TODTon_MIN {3} \
   CONFIG.MC_TOSCO {40000} \
   CONFIG.MC_TOSCOMIN {40000} \
   CONFIG.MC_TOSCO_nCK {79} \
   CONFIG.MC_TPAR_ALERT_ON {0} \
   CONFIG.MC_TPAR_ALERT_PW_MAX {0} \
   CONFIG.MC_TPBR2PBR {90000} \
   CONFIG.MC_TPBR2PBRMIN {90000} \
   CONFIG.MC_TRAS {42000} \
   CONFIG.MC_TRASMIN {42000} \
   CONFIG.MC_TRAS_nCK {83} \
   CONFIG.MC_TRC {63000} \
   CONFIG.MC_TRCD {18000} \
   CONFIG.MC_TRCDMIN {18000} \
   CONFIG.MC_TRCD_nCK {36} \
   CONFIG.MC_TRCMIN {0} \
   CONFIG.MC_TREFI {3904000} \
   CONFIG.MC_TREFIPB {488000} \
   CONFIG.MC_TRFC {0} \
   CONFIG.MC_TRFCAB {280000} \
   CONFIG.MC_TRFCABMIN {280000} \
   CONFIG.MC_TRFCMIN {0} \
   CONFIG.MC_TRFCPB {140000} \
   CONFIG.MC_TRFCPBMIN {140000} \
   CONFIG.MC_TRP {0} \
   CONFIG.MC_TRPAB {21000} \
   CONFIG.MC_TRPABMIN {21000} \
   CONFIG.MC_TRPAB_nCK {42} \
   CONFIG.MC_TRPMIN {0} \
   CONFIG.MC_TRPPB {18000} \
   CONFIG.MC_TRPPBMIN {18000} \
   CONFIG.MC_TRPPB_nCK {36} \
   CONFIG.MC_TRPRE {1.8} \
   CONFIG.MC_TRRD {7500} \
   CONFIG.MC_TRRDMIN {7500} \
   CONFIG.MC_TRRD_L {0} \
   CONFIG.MC_TRRD_L_MIN {0} \
   CONFIG.MC_TRRD_S {0} \
   CONFIG.MC_TRRD_S_MIN {0} \
   CONFIG.MC_TRRD_nCK {15} \
   CONFIG.MC_TRTP_nCK {16} \
   CONFIG.MC_TWPRE {1.8} \
   CONFIG.MC_TWPST {0.4} \
   CONFIG.MC_TWR {18000} \
   CONFIG.MC_TWRMIN {18000} \
   CONFIG.MC_TWR_nCK {36} \
   CONFIG.MC_TWTR {10000} \
   CONFIG.MC_TWTRMIN {10000} \
   CONFIG.MC_TWTR_L {0} \
   CONFIG.MC_TWTR_S {0} \
   CONFIG.MC_TWTR_S_MIN {0} \
   CONFIG.MC_TWTR_nCK {20} \
   CONFIG.MC_TXP {15} \
   CONFIG.MC_TXPMIN {15} \
   CONFIG.MC_TXPR {0} \
   CONFIG.MC_TZQCAL {1000000} \
   CONFIG.MC_TZQCAL_div4 {489} \
   CONFIG.MC_TZQCS_ITVL {0} \
   CONFIG.MC_TZQLAT {30000} \
   CONFIG.MC_TZQLATMIN {30000} \
   CONFIG.MC_TZQLAT_div4 {15} \
   CONFIG.MC_TZQLAT_nCK {59} \
   CONFIG.MC_TZQ_START_ITVL {1000000000} \
   CONFIG.MC_USER_DEFINED_ADDRESS_MAP {16RA-3BA-10CA} \
   CONFIG.MC_XPLL_CLKOUT1_PERIOD {1024} \
   CONFIG.NUM_CLKS {10} \
   CONFIG.NUM_MC {2} \
   CONFIG.NUM_MCP {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_NMI {3} \
   CONFIG.NUM_NSI {1} \
   CONFIG.NUM_SI {9} \
   CONFIG.sys_clk0_BOARD_INTERFACE {lpddr4_clk1} \
   CONFIG.sys_clk1_BOARD_INTERFACE {lpddr4_clk2} \
 ] $axi_noc_0

  set_property -dict [ list \
   CONFIG.APERTURES {{0x201_0000_0000 1G}} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/M00_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} MC_0 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S00_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {MC_1 { read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S00_INI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} MC_1 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S01_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} MC_2 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S02_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} MC_3 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S03_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} MC_0 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_rpu} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S04_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} MC_1 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_pmc} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S05_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} M01_INI { read_bw {1720} write_bw {1720}} MC_2 { read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S06_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M02_INI { read_bw {100} write_bw {100}} M01_INI { read_bw {1720} write_bw {1720}} MC_3 { read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S07_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {MC_0 { read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} M00_AXI { read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} M00_INI { read_bw {1720} write_bw {1720}} } \
   CONFIG.DEST_IDS {M00_AXI:0x40} \
   CONFIG.CATEGORY {ps_pcie} \
 ] [get_bd_intf_pins /static_shell/axi_noc_0/S08_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S01_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S02_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S03_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S04_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S05_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk5]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S06_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk6]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S07_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk7]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S08_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk8]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M00_AXI} \
 ] [get_bd_pins /static_shell/axi_noc_0/aclk9]

  # Create instance: axis_ila_SHELL_BRAM, and set properties
  set axis_ila_SHELL_BRAM [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_ila:1.1 axis_ila_SHELL_BRAM ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {0} \
   CONFIG.C_MON_TYPE {Interface_Monitor} \
   CONFIG.C_SLOT_0_AXI_R_SEL_TRIG {0} \
   CONFIG.C_SLOT_0_AXI_W_SEL_TRIG {0} \
 ] $axis_ila_SHELL_BRAM

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: versal_cips_0, and set properties
  set versal_cips_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.2 versal_cips_0 ]
  set_property -dict [ list \
   CONFIG.CLOCK_MODE {Custom} \
   CONFIG.CPM_CONFIG {\
     CPM_AXI_SLV_ECAM0_BASE_ADDRR_H {0x6}\
     CPM_AXI_SLV_ECAM0_BASE_ADDRR_L {0x0}\
     CPM_PCIE0_BRIDGE_AXI_SLAVE_IF {0}\
     CPM_PCIE0_FUNCTIONAL_MODE {None}\
     CPM_PCIE0_MAX_LINK_SPEED {16.0_GT/s}\
     CPM_PCIE0_MODES {None}\
     CPM_PCIE0_MODE_SELECTION {Advanced}\
     CPM_PCIE0_PCIE_REGION_0_EN {0}\
     CPM_PCIE0_PCIE_REGION_0_SCALE {Kilobytes}\
     CPM_PCIE0_PCIE_REGION_0_SIZE {4}\
     CPM_PCIE0_PCIE_REGION_1_EN {0}\
     CPM_PCIE0_PCIE_REGION_1_SCALE {Kilobytes}\
     CPM_PCIE0_PCIE_REGION_1_SIZE {4}\
     CPM_PCIE0_PCIE_REGION_2_EN {0}\
     CPM_PCIE0_PCIE_REGION_2_SCALE {Kilobytes}\
     CPM_PCIE0_PCIE_REGION_2_SIZE {4}\
     CPM_PCIE0_PF0_BAR0_BRIDGE_64BIT {0}\
     CPM_PCIE0_PF0_BAR0_BRIDGE_PREFETCHABLE {0}\
     CPM_PCIE0_PF0_BAR0_BRIDGE_SCALE {Kilobytes}\
     CPM_PCIE0_PF0_BAR0_BRIDGE_SIZE {4}\
     CPM_PCIE0_PF0_CFG_DEV_ID {B348}\
     CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_0 {0x0000000000000000}\
     CPM_PCIE0_PL_LINK_CAP_MAX_LINK_WIDTH {NONE}\
     CPM_PCIE0_PORT_TYPE {PCI_Express_Endpoint_device}\
     CPM_PCIE0_TANDEM {Tandem_PROM}\
     CPM_PCIE0_TYPE1_MEMBASE_MEMLIMIT_BRIDGE_ENABLE {Enabled}\
     CPM_PCIE0_TYPE1_MEMBASE_MEMLIMIT_ENABLE {Enabled}\
     CPM_PCIE0_TYPE1_PREFETCHABLE_MEMBASE_BRIDGE_MEMLIMIT {64bit_Enabled}\
     CPM_PCIE0_TYPE1_PREFETCHABLE_MEMBASE_MEMLIMIT {64bit_Enabled}\
     CPM_PCIE1_FUNCTIONAL_MODE {AXI_Bridge}\
     CPM_PCIE1_MODES {DMA}\
     CPM_PCIE1_MODE_SELECTION {Advanced}\
     CPM_PCIE1_PF0_BAR0_BRIDGE_SCALE {Megabytes}\
     CPM_PCIE1_PF0_BAR0_BRIDGE_SIZE {4}\
     CPM_PCIE1_PF0_PCIEBAR2AXIBAR_BRIDGE_0 {0x0000020100000000}\
     PS_USE_PS_NOC_PCI_0 {1}\
   } \
   CONFIG.DDR_MEMORY_MODE {Custom} \
   CONFIG.DEBUG_MODE {JTAG} \
   CONFIG.DESIGN_MODE {1} \
   CONFIG.PS_BOARD_INTERFACE {Custom} \
   CONFIG.PS_PMC_CONFIG {\
     CLOCK_MODE {Custom}\
     DDR_MEMORY_MODE {Connectivity to DDR via NOC}\
     DEBUG_MODE {JTAG}\
     DESIGN_MODE {1}\
     PCIE_APERTURES_DUAL_ENABLE {0}\
     PCIE_APERTURES_SINGLE_ENABLE {1}\
     PMC_CRP_PL0_REF_CTRL_FREQMHZ {100}\
     PMC_GPIO0_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 0 .. 25}}}\
     PMC_GPIO1_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 26 .. 51}}}\
     PMC_MIO37 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA high}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE GPIO}}\
     PMC_QSPI_FBCLK {{ENABLE 1} {IO {PMC_MIO 6}}}\
     PMC_QSPI_PERIPHERAL_DATA_MODE {x4}\
     PMC_QSPI_PERIPHERAL_ENABLE {1}\
     PMC_QSPI_PERIPHERAL_MODE {Dual Parallel}\
     PMC_REF_CLK_FREQMHZ {33.3333}\
     PMC_SD1 {{CD_ENABLE 1} {CD_IO {PMC_MIO 28}} {POW_ENABLE 1} {POW_IO {PMC_MIO 51}}\
{RESET_ENABLE 0} {RESET_IO {PMC_MIO 12}} {WP_ENABLE 0} {WP_IO {PMC_MIO\
1}}}\
     PMC_SD1_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x3} {CLK_200_SDR_OTAP_DLY 0x2}\
{CLK_50_DDR_ITAP_DLY 0x36} {CLK_50_DDR_OTAP_DLY 0x3}\
{CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x4} {ENABLE\
1} {IO {PMC_MIO 26 .. 36}}}\
     PMC_SD1_SLOT_TYPE {SD 3.0}\
     PMC_USE_NOC_PMC_AXI0 {0}\
     PMC_USE_PMC_NOC_AXI0 {1}\
     PS_BOARD_INTERFACE {Custom}\
     PS_ENET0_MDIO {{ENABLE 1} {IO {PS_MIO 24 .. 25}}}\
     PS_ENET0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 0 .. 11}}}\
     PS_GEM0_ROUTE_THROUGH_FPD {1}\
     PS_GEM1_ROUTE_THROUGH_FPD {0}\
     PS_GEN_IPI0_ENABLE {1}\
     PS_GEN_IPI0_MASTER {A72}\
     PS_GEN_IPI1_ENABLE {1}\
     PS_GEN_IPI1_MASTER {A72}\
     PS_GEN_IPI2_ENABLE {1}\
     PS_GEN_IPI2_MASTER {A72}\
     PS_GEN_IPI3_ENABLE {1}\
     PS_GEN_IPI3_MASTER {A72}\
     PS_GEN_IPI4_ENABLE {1}\
     PS_GEN_IPI4_MASTER {A72}\
     PS_GEN_IPI5_ENABLE {1}\
     PS_GEN_IPI5_MASTER {A72}\
     PS_GEN_IPI6_ENABLE {1}\
     PS_GEN_IPI6_MASTER {A72}\
     PS_GEN_IPI_PMCNOBUF_ENABLE {1}\
     PS_GEN_IPI_PMC_ENABLE {1}\
     PS_GEN_IPI_PSM_ENABLE {1}\
     PS_HSDP_EGRESS_TRAFFIC {JTAG}\
     PS_HSDP_INGRESS_TRAFFIC {JTAG}\
     PS_HSDP_MODE {None}\
     PS_I2C0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 46 .. 47}}}\
     PS_I2C1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 44 .. 45}}}\
     PS_I2CSYSMON_PERIPHERAL {{ENABLE 0} {IO {PS_MIO 23 .. 24}}}\
     PS_LPDMA0_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA1_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA2_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA3_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA4_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA5_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA6_ROUTE_THROUGH_FPD {1}\
     PS_LPDMA7_ROUTE_THROUGH_FPD {1}\
     PS_MIO7 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO9 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_NUM_FABRIC_RESETS {0}\
     PS_PCIE1_PERIPHERAL_ENABLE {0}\
     PS_PCIE2_PERIPHERAL_ENABLE {1}\
     PS_PCIE_EP_RESET1_IO {PS_MIO 18}\
     PS_PCIE_EP_RESET2_IO {PMC_MIO 39}\
     PS_PCIE_RESET {{ENABLE 1}}\
     PS_PCIE_ROOT_RESET1_IO {None}\
     PS_TTC0_PERIPHERAL_ENABLE {1}\
     PS_TTC1_PERIPHERAL_ENABLE {1}\
     PS_TTC2_PERIPHERAL_ENABLE {1}\
     PS_TTC3_PERIPHERAL_ENABLE {1}\
     PS_UART0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 42 .. 43}}}\
     PS_USB3_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 13 .. 25}}}\
     PS_USB_ROUTE_THROUGH_FPD {1}\
     PS_USE_FPD_AXI_NOC0 {1}\
     PS_USE_FPD_AXI_NOC1 {1}\
     PS_USE_FPD_CCI_NOC {1}\
     PS_USE_FPD_CCI_NOC0 {1}\
     PS_USE_NOC_FPD_AXI0 {0}\
     PS_USE_NOC_LPD_AXI0 {1}\
     PS_USE_PMCPL_CLK0 {1}\
     PS_USE_PMCPL_CLK1 {0}\
     PS_USE_PMCPL_CLK2 {0}\
     PS_USE_PMCPL_CLK3 {0}\
     PS_WWDT0_CLK {{ENABLE 1} {IO APB}}\
     PS_WWDT0_PERIPHERAL {{ENABLE 1} {IO EMIO}}\
     SMON_ALARMS {Set_Alarms_On}\
     SMON_ENABLE_TEMP_AVERAGING {0}\
     SMON_INTERFACE_TO_USE {None}\
     SMON_TEMP_AVERAGING_SAMPLES {0}\
   } \
   CONFIG.PS_PMC_CONFIG_APPLIED {0} \
 ] $versal_cips_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins DBG_HUB_INI] [get_bd_intf_pins axi_noc_0/M02_INI]
  connect_bd_intf_net -intf_net PCIE_REF_CLK_1 [get_bd_intf_pins PCIE_REF_CLK] [get_bd_intf_pins versal_cips_0/gt_refclk1]
  connect_bd_intf_net -intf_net S00_INI_0_1 [get_bd_intf_pins PL2DDR_S_AXI_INI] [get_bd_intf_pins axi_noc_0/S00_INI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTB [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_LPDDR4_0 [get_bd_intf_pins ch0_lpddr4_trip1] [get_bd_intf_pins axi_noc_0/CH0_LPDDR4_0]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_LPDDR4_1 [get_bd_intf_pins ch0_lpddr4_trip2] [get_bd_intf_pins axi_noc_0/CH0_LPDDR4_1]
  connect_bd_intf_net -intf_net axi_noc_0_CH1_LPDDR4_0 [get_bd_intf_pins ch1_lpddr4_trip1] [get_bd_intf_pins axi_noc_0/CH1_LPDDR4_0]
  connect_bd_intf_net -intf_net axi_noc_0_CH1_LPDDR4_1 [get_bd_intf_pins ch1_lpddr4_trip2] [get_bd_intf_pins axi_noc_0/CH1_LPDDR4_1]
  connect_bd_intf_net -intf_net axi_noc_0_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_noc_0/M00_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axi_noc_0_M00_AXI] [get_bd_intf_pins axi_noc_0/M00_AXI] [get_bd_intf_pins axis_ila_SHELL_BRAM/SLOT_0_AXI]
  connect_bd_intf_net -intf_net axi_noc_0_M00_INI [get_bd_intf_pins CPM2PL_M_AXI_INI] [get_bd_intf_pins axi_noc_0/M00_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M01_INI [get_bd_intf_pins PS2PL_M_AXI_INI] [get_bd_intf_pins axi_noc_0/M01_INI]
  connect_bd_intf_net -intf_net lpddr4_clk1_1 [get_bd_intf_pins lpddr4_clk1] [get_bd_intf_pins axi_noc_0/sys_clk0]
  connect_bd_intf_net -intf_net lpddr4_clk2_1 [get_bd_intf_pins lpddr4_clk2] [get_bd_intf_pins axi_noc_0/sys_clk1]
  connect_bd_intf_net -intf_net versal_cips_0_CPM_PCIE_NOC_0 [get_bd_intf_pins axi_noc_0/S08_AXI] [get_bd_intf_pins versal_cips_0/CPM_PCIE_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_AXI_NOC_0 [get_bd_intf_pins axi_noc_0/S06_AXI] [get_bd_intf_pins versal_cips_0/FPD_AXI_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_AXI_NOC_1 [get_bd_intf_pins axi_noc_0/S07_AXI] [get_bd_intf_pins versal_cips_0/FPD_AXI_NOC_1]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_0 [get_bd_intf_pins axi_noc_0/S00_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_1 [get_bd_intf_pins axi_noc_0/S01_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_1]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_2 [get_bd_intf_pins axi_noc_0/S02_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_2]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_3 [get_bd_intf_pins axi_noc_0/S03_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_3]
  connect_bd_intf_net -intf_net versal_cips_0_LPD_AXI_NOC_0 [get_bd_intf_pins axi_noc_0/S04_AXI] [get_bd_intf_pins versal_cips_0/LPD_AXI_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_PCIE1_GT [get_bd_intf_pins PCIE] [get_bd_intf_pins versal_cips_0/PCIE1_GT]
  connect_bd_intf_net -intf_net versal_cips_0_PMC_NOC_AXI_0 [get_bd_intf_pins axi_noc_0/S05_AXI] [get_bd_intf_pins versal_cips_0/PMC_NOC_AXI_0]

  # Create port connections
  connect_bd_net -net versal_cips_0_cpm_pcie_noc_axi0_clk [get_bd_pins axi_noc_0/aclk8] [get_bd_pins versal_cips_0/cpm_pcie_noc_axi0_clk]
  connect_bd_net -net versal_cips_0_dma1_axi_aresetn [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins versal_cips_0/dma1_axi_aresetn]
  connect_bd_net -net versal_cips_0_fpd_axi_noc_axi0_clk [get_bd_pins axi_noc_0/aclk6] [get_bd_pins versal_cips_0/fpd_axi_noc_axi0_clk]
  connect_bd_net -net versal_cips_0_fpd_axi_noc_axi1_clk [get_bd_pins axi_noc_0/aclk7] [get_bd_pins versal_cips_0/fpd_axi_noc_axi1_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi0_clk [get_bd_pins axi_noc_0/aclk0] [get_bd_pins versal_cips_0/fpd_cci_noc_axi0_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi1_clk [get_bd_pins axi_noc_0/aclk1] [get_bd_pins versal_cips_0/fpd_cci_noc_axi1_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi2_clk [get_bd_pins axi_noc_0/aclk2] [get_bd_pins versal_cips_0/fpd_cci_noc_axi2_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi3_clk [get_bd_pins axi_noc_0/aclk3] [get_bd_pins versal_cips_0/fpd_cci_noc_axi3_clk]
  connect_bd_net -net versal_cips_0_lpd_axi_noc_clk [get_bd_pins axi_noc_0/aclk4] [get_bd_pins versal_cips_0/lpd_axi_noc_clk]
  connect_bd_net -net versal_cips_0_pl0_ref_clk [get_bd_pins CPM_clk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_noc_0/aclk9] [get_bd_pins axis_ila_SHELL_BRAM/clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins versal_cips_0/dma1_intrfc_clk] [get_bd_pins versal_cips_0/pl0_ref_clk]
  connect_bd_net -net versal_cips_0_pmc_axi_noc_axi0_clk [get_bd_pins axi_noc_0/aclk5] [get_bd_pins versal_cips_0/pmc_axi_noc_axi0_clk]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins versal_cips_0/bridge1_usr_irq_req] [get_bd_pins versal_cips_0/cpm_irq0] [get_bd_pins versal_cips_0/cpm_irq1] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout1 [get_bd_pins CPM_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axis_ila_SHELL_BRAM/resetn] [get_bd_pins proc_sys_reset_0/interconnect_aresetn] [get_bd_pins versal_cips_0/dma1_intrfc_resetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set PCIE [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 PCIE ]

  set PCIE_REF_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REF_CLK ]

  set ch0_lpddr4_trip1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch0_lpddr4_trip1 ]

  set ch0_lpddr4_trip2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch0_lpddr4_trip2 ]

  set ch1_lpddr4_trip1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch1_lpddr4_trip1 ]

  set ch1_lpddr4_trip2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch1_lpddr4_trip2 ]

  set lpddr4_clk1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lpddr4_clk1 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200321000} \
   ] $lpddr4_clk1

  set lpddr4_clk2 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lpddr4_clk2 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200321000} \
   ] $lpddr4_clk2


  # Create ports

  # Create instance: static_shell
  create_hier_cell_static_shell [current_bd_instance .] static_shell

  # Create instance: user_role_0, and set properties
  set user_role_0 [ create_bd_cell -type container -reference user_role user_role_0 ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {user_role.bd} \
   CONFIG.ACTIVE_SYNTH_BD {user_role.bd} \
   CONFIG.ENABLE_DFX {true} \
   CONFIG.LIST_SIM_BD {user_role.bd} \
   CONFIG.LIST_SYNTH_BD {user_role.bd} \
   CONFIG.LOCK_PROPAGATE {true} \
 ] $user_role_0
  set_property APERTURES {{0x201_0000_0000 64K}} [get_bd_intf_pins /user_role_0/CPM2PL_S_AXI_INI]
  set_property APERTURES {{0x202_0000_0000 2M}} [get_bd_intf_pins /user_role_0/DBG_HUB_INI]
  set_property APERTURES {{0x0 2G} {0x8_0000_0000 8G}} [get_bd_intf_pins /user_role_0/PL2DDR_M_AXI_INI]
  set_property APERTURES {{0x201_8000_0000 32K}} [get_bd_intf_pins /user_role_0/PS2PL_S_AXI_INI]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_noc_0_CH0_LPDDR4_0 [get_bd_intf_ports ch0_lpddr4_trip1] [get_bd_intf_pins static_shell/ch0_lpddr4_trip1]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_LPDDR4_1 [get_bd_intf_ports ch0_lpddr4_trip2] [get_bd_intf_pins static_shell/ch0_lpddr4_trip2]
  connect_bd_intf_net -intf_net axi_noc_0_CH1_LPDDR4_0 [get_bd_intf_ports ch1_lpddr4_trip1] [get_bd_intf_pins static_shell/ch1_lpddr4_trip1]
  connect_bd_intf_net -intf_net axi_noc_0_CH1_LPDDR4_1 [get_bd_intf_ports ch1_lpddr4_trip2] [get_bd_intf_pins static_shell/ch1_lpddr4_trip2]
  connect_bd_intf_net -intf_net gt_refclk0_0_1 [get_bd_intf_ports PCIE_REF_CLK] [get_bd_intf_pins static_shell/PCIE_REF_CLK]
  connect_bd_intf_net -intf_net lpddr4_clk1_1 [get_bd_intf_ports lpddr4_clk1] [get_bd_intf_pins static_shell/lpddr4_clk1]
  connect_bd_intf_net -intf_net lpddr4_clk2_1 [get_bd_intf_ports lpddr4_clk2] [get_bd_intf_pins static_shell/lpddr4_clk2]
  connect_bd_intf_net -intf_net static_shell_CPM2PL_M_AXI_INI [get_bd_intf_pins static_shell/CPM2PL_M_AXI_INI] [get_bd_intf_pins user_role_0/CPM2PL_S_AXI_INI]
  connect_bd_intf_net -intf_net static_shell_DBG_HUB_INI [get_bd_intf_pins static_shell/DBG_HUB_INI] [get_bd_intf_pins user_role_0/DBG_HUB_INI]
  connect_bd_intf_net -intf_net static_shell_PS2PL_M_AXI_INI [get_bd_intf_pins static_shell/PS2PL_M_AXI_INI] [get_bd_intf_pins user_role_0/PS2PL_S_AXI_INI]
  connect_bd_intf_net -intf_net user_role_0_PL2DDR_M_AXI_INI [get_bd_intf_pins static_shell/PL2DDR_S_AXI_INI] [get_bd_intf_pins user_role_0/PL2DDR_M_AXI_INI]
  connect_bd_intf_net -intf_net versal_cips_0_PCIE0_GT [get_bd_intf_ports PCIE] [get_bd_intf_pins static_shell/PCIE]

  # Create port connections
  connect_bd_net -net CPM_areset_n_1 [get_bd_pins static_shell/CPM_axi_aresetn] [get_bd_pins user_role_0/CPM_areset_n]
  connect_bd_net -net static_shell_CPM_clk [get_bd_pins static_shell/CPM_clk] [get_bd_pins user_role_0/CPM_clk]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces user_role_0/PL2DDR_CDMA/Data] [get_bd_addr_segs static_shell/axi_noc_0/S00_INI/C1_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces user_role_0/PL2DDR_CDMA/Data] [get_bd_addr_segs static_shell/axi_noc_0/S00_INI/C1_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020100000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs user_role_0/CPM2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020100008000 -range 0x00008000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs user_role_0/PL2DDR_CDMA/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x020100010000 -range 0x00002000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs static_shell/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S08_AXI/C0_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S08_AXI/C0_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_0] [get_bd_addr_segs user_role_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_0] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S06_AXI/C2_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S06_AXI/C2_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_1] [get_bd_addr_segs user_role_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_1] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_1] [get_bd_addr_segs static_shell/axi_noc_0/S07_AXI/C3_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_AXI_NOC_1] [get_bd_addr_segs static_shell/axi_noc_0/S07_AXI/C3_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S00_AXI/C0_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S00_AXI/C0_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs static_shell/axi_noc_0/S01_AXI/C1_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs static_shell/axi_noc_0/S01_AXI/C1_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs static_shell/axi_noc_0/S02_AXI/C2_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs static_shell/axi_noc_0/S02_AXI/C2_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs static_shell/axi_noc_0/S03_AXI/C3_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs static_shell/axi_noc_0/S03_AXI/C3_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S04_AXI/C0_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs static_shell/axi_noc_0/S04_AXI/C0_DDR_LOW1x2] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs user_role_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs static_shell/axi_noc_0/S05_AXI/C1_DDR_LOW0x2] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces static_shell/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs static_shell/axi_noc_0/S05_AXI/C1_DDR_LOW1x2] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


