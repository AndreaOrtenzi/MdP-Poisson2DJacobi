MULTIDISCIPLINARY PROJECT

The goal of this project is to implement a stencil algorithm applied to a Poisson 2D problem, investigate its numerous optimizations, achieve adequate performance, and compare to other architectures that have made use of various parallelization approaches.

To do this, we choose to simulate the operation of an FPGA using Vitis, a tool provided accessible by Xilinx, to produce an RTL code that can subsequently be performed on a physical board.

Therefore, the fundamental goal of the project has been to write code that is portable, and performs as well as possible while utilizing as many optimizations as the architecture permits.

Vitis Sotware download is available here: https://www.xilinx.com/support/download.html. Version we used is Vitis 2023.1.

We used the simulated board Zynq Ultrascale+ ZCU106 Evaluation Platform with Simulation, Synthesis and Co-simulation steps offered by the tool.

Please refer to report for more.
