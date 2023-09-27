############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project fpga
set_top kernel
add_files fpga/kernel.cpp
add_files -tb fpga/16_16_200000_0.000010.ref -cflags "-Wno-unknown-pragmas"
add_files -tb fpga/checker.h -cflags "-Wno-unknown-pragmas"
add_files -tb fpga/kernel.h -cflags "-Wno-unknown-pragmas"
add_files -tb fpga/reference.h -cflags "-Wno-unknown-pragmas"
add_files -tb fpga/testbench.cpp -cflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vitis
set_part {xczu7ev-ffvc1156-2-e}
create_clock -period 10 -name default
config_cosim -enable_dataflow_profiling -enable_fifo_sizing -tool xsim -trace_level all
config_export -flow syn -format ip_catalog -output C:/Users/Leonardo/Documents/GitHub/MdP-Poisson2DJacobi/fpga -rtl verilog -vivado_clock 4
config_interface -m_axi_alignment_byte_size 64 -m_axi_latency 64 -m_axi_max_widen_bitwidth 512
config_rtl -register_reset_num 3
set_clock_uncertainty 1.08
source "./fpga/solution1/directives.tcl"
csim_design -argv {-fcommon} -clean
csynth_design
cosim_design -enable_dataflow_profiling -enable_fifo_sizing -trace_level all
export_design -rtl verilog -format ip_catalog -output C:/Users/Leonardo/Documents/GitHub/MdP-Poisson2DJacobi/fpga
