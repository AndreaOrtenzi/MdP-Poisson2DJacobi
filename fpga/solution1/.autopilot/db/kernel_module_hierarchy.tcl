set ModuleHierarchy {[{
"Name" : "kernel","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_initialization_fu_4503","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "init_loop","ID" : "2","Type" : "pipeline",
		"SubInsts" : [
		{"Name" : "y_ap_fixed_base_fu_2014","ID" : "3","Type" : "pipeline"},
		{"Name" : "grp_sin_33_6_s_fu_2019","ID" : "4","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "5","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2024","ID" : "6","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "7","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2029","ID" : "8","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "9","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2034","ID" : "10","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "11","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2039","ID" : "12","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "13","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2044","ID" : "14","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "15","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2049","ID" : "16","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "17","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2054","ID" : "18","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "19","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2059","ID" : "20","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "21","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2064","ID" : "22","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "23","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2069","ID" : "24","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "25","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2074","ID" : "26","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "27","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2079","ID" : "28","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "29","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2084","ID" : "30","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "31","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2089","ID" : "32","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "33","Type" : "pipeline"},]},
		{"Name" : "grp_sin_33_6_s_fu_2094","ID" : "34","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "grp_cordic_circ_apfixed_35_3_0_s_fu_60","ID" : "35","Type" : "pipeline"},]},]},]},
	{"Name" : "grp_kernel_Pipeline_6_fu_6951","ID" : "36","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "Loop 1","ID" : "37","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "while_loop","ID" : "38","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_kernel_Pipeline_no_e_first_loop_no_e_in_first_loop_fu_4507","ID" : "39","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "no_e_first_loop_no_e_in_first_loop","ID" : "40","Type" : "pipeline"},]},
	{"Name" : "grp_kernel_Pipeline_no_e_cpy_third_and_fourth_loop_fu_5431","ID" : "41","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "no_e_cpy_third_and_fourth_loop","ID" : "42","Type" : "pipeline"},]},
	{"Name" : "grp_kernel_Pipeline_first_loop_in_first_loop_fu_5599","ID" : "43","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "first_loop_in_first_loop","ID" : "44","Type" : "pipeline"},]},
	{"Name" : "grp_kernel_Pipeline_cpy_third_and_fourth_loop_fu_6522","ID" : "45","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "cpy_third_and_fourth_loop","ID" : "46","Type" : "pipeline"},]},
	{"Name" : "grp_kernel_Pipeline_w_second_loop_fu_6690","ID" : "47","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "w_second_loop","ID" : "48","Type" : "pipeline"},]},]},]
}]}