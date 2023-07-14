set SynModuleInfo {
  {SRCNAME kernel_Pipeline_VITIS_LOOP_27_1_VITIS_LOOP_28_2 MODELNAME kernel_Pipeline_VITIS_LOOP_27_1_VITIS_LOOP_28_2 RTLNAME kernel_kernel_Pipeline_VITIS_LOOP_27_1_VITIS_LOOP_28_2
    SUBMODULES {
      {MODELNAME kernel_flow_control_loop_pipe_sequential_init RTLNAME kernel_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME kernel_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME kernel_Pipeline_VITIS_LOOP_69_2_VITIS_LOOP_71_3 MODELNAME kernel_Pipeline_VITIS_LOOP_69_2_VITIS_LOOP_71_3 RTLNAME kernel_kernel_Pipeline_VITIS_LOOP_69_2_VITIS_LOOP_71_3
    SUBMODULES {
      {MODELNAME kernel_dcmp_64ns_64ns_1_2_no_dsp_1 RTLNAME kernel_dcmp_64ns_64ns_1_2_no_dsp_1 BINDTYPE op TYPE dcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME kernel_kernel_Pipeline_VITIS_LOOP_69_2_VITIS_LOOP_71_3_f_ROM_AUTO_1R RTLNAME kernel_kernel_Pipeline_VITIS_LOOP_69_2_VITIS_LOOP_71_3_f_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME kernel_Pipeline_VITIS_LOOP_88_4_VITIS_LOOP_90_5 MODELNAME kernel_Pipeline_VITIS_LOOP_88_4_VITIS_LOOP_90_5 RTLNAME kernel_kernel_Pipeline_VITIS_LOOP_88_4_VITIS_LOOP_90_5}
  {SRCNAME kernel_Pipeline_VITIS_LOOP_97_6 MODELNAME kernel_Pipeline_VITIS_LOOP_97_6 RTLNAME kernel_kernel_Pipeline_VITIS_LOOP_97_6}
  {SRCNAME kernel_Pipeline_VITIS_LOOP_104_7 MODELNAME kernel_Pipeline_VITIS_LOOP_104_7 RTLNAME kernel_kernel_Pipeline_VITIS_LOOP_104_7}
  {SRCNAME kernel MODELNAME kernel RTLNAME kernel IS_TOP 1
    SUBMODULES {
      {MODELNAME kernel_dmul_64ns_64ns_64_5_max_dsp_1 RTLNAME kernel_dmul_64ns_64ns_64_5_max_dsp_1 BINDTYPE op TYPE dmul IMPL maxdsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME kernel_ddiv_64ns_64ns_64_22_no_dsp_1 RTLNAME kernel_ddiv_64ns_64ns_64_22_no_dsp_1 BINDTYPE op TYPE ddiv IMPL fabric LATENCY 21 ALLOW_PRAGMA 1}
      {MODELNAME kernel_dadddsub_64ns_64ns_64_5_full_dsp_1 RTLNAME kernel_dadddsub_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME kernel_vp_RAM_AUTO_1R1W RTLNAME kernel_vp_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME kernel_gmem0_m_axi RTLNAME kernel_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME kernel_gmem1_m_axi RTLNAME kernel_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME kernel_control_s_axi RTLNAME kernel_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
