set SynModuleInfo {
  {SRCNAME ap_fixed_base MODELNAME ap_fixed_base RTLNAME kernel_ap_fixed_base}
  {SRCNAME {cordic_circ_apfixed<35, 3, 0>} MODELNAME cordic_circ_apfixed_35_3_0_s RTLNAME kernel_cordic_circ_apfixed_35_3_0_s}
  {SRCNAME {sin<33, 6>} MODELNAME sin_33_6_s RTLNAME kernel_sin_33_6_s
    SUBMODULES {
      {MODELNAME kernel_mul_6ns_34ns_35_1_1 RTLNAME kernel_mul_6ns_34ns_35_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME kernel_mul_33ns_41ns_73_1_1 RTLNAME kernel_mul_33ns_41ns_73_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME initialization MODELNAME initialization RTLNAME kernel_initialization
    SUBMODULES {
      {MODELNAME kernel_dadd_64ns_64ns_64_5_full_dsp_1 RTLNAME kernel_dadd_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME kernel_dmul_64ns_64ns_64_5_max_dsp_1 RTLNAME kernel_dmul_64ns_64ns_64_5_max_dsp_1 BINDTYPE op TYPE dmul IMPL maxdsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME kernel_ddiv_64ns_64ns_64_17_no_dsp_1 RTLNAME kernel_ddiv_64ns_64ns_64_17_no_dsp_1 BINDTYPE op TYPE ddiv IMPL fabric LATENCY 16 ALLOW_PRAGMA 1}
      {MODELNAME kernel_sitodp_32ns_64_3_no_dsp_1 RTLNAME kernel_sitodp_32ns_64_3_no_dsp_1 BINDTYPE op TYPE sitodp IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME kernel_flow_control_loop_pipe_sequential_init RTLNAME kernel_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME kernel_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME kernel_Pipeline_no_e_first_loop_no_e_in_first_loop MODELNAME kernel_Pipeline_no_e_first_loop_no_e_in_first_loop RTLNAME kernel_kernel_Pipeline_no_e_first_loop_no_e_in_first_loop
    SUBMODULES {
      {MODELNAME kernel_mul_62s_26s_86_1_1 RTLNAME kernel_mul_62s_26s_86_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME kernel_mux_239_8_32_1_1 RTLNAME kernel_mux_239_8_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME kernel_Pipeline_no_e_cpy_third_and_fourth_loop MODELNAME kernel_Pipeline_no_e_cpy_third_and_fourth_loop RTLNAME kernel_kernel_Pipeline_no_e_cpy_third_and_fourth_loop
    SUBMODULES {
      {MODELNAME kernel_mux_15_4_32_1_1 RTLNAME kernel_mux_15_4_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME kernel_Pipeline_first_loop_in_first_loop MODELNAME kernel_Pipeline_first_loop_in_first_loop RTLNAME kernel_kernel_Pipeline_first_loop_in_first_loop}
  {SRCNAME kernel_Pipeline_cpy_third_and_fourth_loop MODELNAME kernel_Pipeline_cpy_third_and_fourth_loop RTLNAME kernel_kernel_Pipeline_cpy_third_and_fourth_loop}
  {SRCNAME kernel_Pipeline_w_second_loop MODELNAME kernel_Pipeline_w_second_loop RTLNAME kernel_kernel_Pipeline_w_second_loop
    SUBMODULES {
      {MODELNAME kernel_mux_16_4_32_1_1 RTLNAME kernel_mux_16_4_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME kernel_Pipeline_6 MODELNAME kernel_Pipeline_6 RTLNAME kernel_kernel_Pipeline_6
    SUBMODULES {
      {MODELNAME kernel_mux_256_8_32_1_1 RTLNAME kernel_mux_256_8_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME kernel MODELNAME kernel RTLNAME kernel IS_TOP 1
    SUBMODULES {
      {MODELNAME kernel_dcmp_64ns_64ns_1_2_no_dsp_1 RTLNAME kernel_dcmp_64ns_64ns_1_2_no_dsp_1 BINDTYPE op TYPE dcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME kernel_sdiv_59ns_25s_32_63_seq_1 RTLNAME kernel_sdiv_59ns_25s_32_63_seq_1 BINDTYPE op TYPE sdiv IMPL auto_seq LATENCY 62 ALLOW_PRAGMA 1}
      {MODELNAME kernel_gmem0_m_axi RTLNAME kernel_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME kernel_gmem1_m_axi RTLNAME kernel_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME kernel_control_s_axi RTLNAME kernel_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
