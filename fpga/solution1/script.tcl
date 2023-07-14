############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project fpga
set_top kernel
add_files fpga/kernel.cpp
add_files -tb ../../../Desktop/reference/16_16_200000_0.000010.ref -cflags "-Wno-unknown-pragmas"
add_files -tb fpga/checker.h -cflags "-Wno-unknown-pragmas"
add_files -tb fpga/testbench.cpp -cflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xczu28dr-ffvg1517-2-e}
create_clock -period 10 -name default
config_cosim -tool xsim
config_export -flow syn -format ip_catalog -rtl verilog -vivado_clock 10
source "./fpga/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -flow syn -rtl verilog -format ip_catalog
