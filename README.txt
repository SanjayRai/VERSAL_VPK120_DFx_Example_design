The exmaple build  Versal  CIPS  example (CPM-PCIE xDMA, NoC, DDR, MMIO-BRAM) with TCL Scripts.

* The Design was initial created in Vivado IPI  and converted to TCL script.

Reuirements:
1. Vivado 2022.1

Build instructions:

To Build the  design from scripts (linux command) :
    1. cd  vivado_project
    2. ./build_all

To  view and analyze an implemented  design in Vivado GUI :
    1. cd vivado_project
    2. vivado project_X/project_X.xpr



Optional partial steps :

To  Build just the IP in IPI  from script
    1. cd IP
    2. vivado -source vivado_project.tcl
    3. build_BD

To view or re-customize the IPI generated IP in Vivado GUI :
    1. cd IP
    2. vivado -source vivado_project.tcl
    3. customize_BD

#Versal (works for both VCK190 & VPK120 ) Specific  Tandem + DFx  enablement parameters.
# PR Enablement
set_param hd.enablePR 2591
set_param bitstream.enablePR 8519

# PC Enablement (Tandem)
set_param hd.enablePC 3475
set_param bitstream.enablePC 7635

# PR + PC Enablement (Tandem)
set_param hd.enableTandemPR 6379
set_param bitstream.enableTandemPR 4731

#  Seperate Stage_1 and Stage_2  during Tandem pdi generation  for testin gpurpouses.
set_property HD.TANDEM_BITSTREAMS SEPARATE [current_design]
