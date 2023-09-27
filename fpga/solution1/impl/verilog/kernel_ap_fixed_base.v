// ==============================================================
// Generated by Vitis HLS v2023.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module kernel_ap_fixed_base (
        ap_ready,
        d,
        ap_return
);


output   ap_ready;
input  [63:0] d;
output  [31:0] ap_return;

wire   [63:0] bitcast_ln724_fu_48_p1;
wire   [10:0] tmp9_fu_64_p4;
wire   [51:0] empty_52_fu_78_p1;
wire   [52:0] tmp_39_cast_cast_cast_fu_82_p3;
wire   [53:0] tmp_39_cast_cast_cast_cast_fu_90_p1;
wire   [0:0] tmp_fu_56_p3;
wire   [53:0] sub_i_i_fu_94_p2;
wire   [62:0] empty_fu_52_p1;
wire   [11:0] conv3_i_i_fu_74_p1;
wire   [11:0] sub_fu_114_p2;
wire   [0:0] cmp29_fu_120_p2;
wire   [11:0] sub30_fu_126_p2;
wire   [11:0] sub31_fu_132_p2;
wire  signed [11:0] cond_fu_138_p3;
wire   [53:0] man_0_fu_100_p3;
wire   [6:0] tmp_181_fu_166_p4;
wire   [31:0] empty_53_fu_156_p1;
wire  signed [31:0] cond_cast_fu_146_p1;
wire   [0:0] icmp_fu_176_p2;
wire   [31:0] shl_fu_182_p2;
wire   [53:0] sh_prom_cast_cast_cast_cast_fu_196_p1;
wire   [53:0] shr_fu_200_p2;
wire   [0:0] cmp_fu_108_p2;
wire   [0:0] tmp_182_fu_210_p3;
wire   [0:0] not_cmp_fu_218_p2;
wire   [0:0] sel_tmp_fu_224_p2;
wire   [0:0] cmp32_fu_150_p2;
wire   [0:0] sel_tmp2_fu_238_p2;
wire   [31:0] sel_tmp_cast_fu_230_p3;
wire   [0:0] sel_tmp6_demorgan_fu_252_p2;
wire   [0:0] sel_tmp8_demorgan_fu_258_p2;
wire   [31:0] sel_tmp3_fu_244_p3;
wire   [31:0] storemerge_fu_188_p3;
wire   [0:0] cmp40_fu_160_p2;
wire   [0:0] sel_tmp12_fu_272_p2;
wire   [0:0] tmp16_fu_278_p2;
wire   [0:0] sel_tmp14_fu_284_p2;
wire   [31:0] empty_54_fu_206_p1;
wire   [31:0] sel_tmp9_fu_264_p3;
wire    ap_ce_reg;

assign ap_ready = 1'b1;

assign bitcast_ln724_fu_48_p1 = d;

assign cond_cast_fu_146_p1 = cond_fu_138_p3;

assign cond_fu_138_p3 = ((cmp29_fu_120_p2[0:0] == 1'b1) ? sub30_fu_126_p2 : sub31_fu_132_p2);

assign conv3_i_i_fu_74_p1 = tmp9_fu_64_p4;

assign empty_52_fu_78_p1 = bitcast_ln724_fu_48_p1[51:0];

assign empty_53_fu_156_p1 = man_0_fu_100_p3[31:0];

assign empty_54_fu_206_p1 = shr_fu_200_p2[31:0];

assign empty_fu_52_p1 = bitcast_ln724_fu_48_p1[62:0];

assign icmp_fu_176_p2 = ((tmp_181_fu_166_p4 == 7'd0) ? 1'b1 : 1'b0);

assign man_0_fu_100_p3 = ((tmp_fu_56_p3[0:0] == 1'b1) ? sub_i_i_fu_94_p2 : tmp_39_cast_cast_cast_cast_fu_90_p1);

assign not_cmp_fu_218_p2 = (cmp_fu_108_p2 ^ 1'd1);

assign sel_tmp12_fu_272_p2 = (sel_tmp6_demorgan_fu_252_p2 ^ 1'd1);

assign sel_tmp14_fu_284_p2 = (tmp16_fu_278_p2 & cmp29_fu_120_p2);

assign sel_tmp2_fu_238_p2 = (not_cmp_fu_218_p2 & cmp32_fu_150_p2);

assign sel_tmp3_fu_244_p3 = ((sel_tmp2_fu_238_p2[0:0] == 1'b1) ? empty_53_fu_156_p1 : sel_tmp_cast_fu_230_p3);

assign sel_tmp6_demorgan_fu_252_p2 = (cmp_fu_108_p2 | cmp32_fu_150_p2);

assign sel_tmp8_demorgan_fu_258_p2 = (sel_tmp6_demorgan_fu_252_p2 | cmp29_fu_120_p2);

assign sel_tmp9_fu_264_p3 = ((sel_tmp8_demorgan_fu_258_p2[0:0] == 1'b1) ? sel_tmp3_fu_244_p3 : storemerge_fu_188_p3);

assign sel_tmp_cast_fu_230_p3 = ((sel_tmp_fu_224_p2[0:0] == 1'b1) ? 32'd4294967295 : 32'd0);

assign sel_tmp_fu_224_p2 = (tmp_182_fu_210_p3 & not_cmp_fu_218_p2);

assign sh_prom_cast_cast_cast_cast_fu_196_p1 = $unsigned(cond_cast_fu_146_p1);

assign shl_fu_182_p2 = empty_53_fu_156_p1 << cond_cast_fu_146_p1;

assign shr_fu_200_p2 = $signed(man_0_fu_100_p3) >>> sh_prom_cast_cast_cast_cast_fu_196_p1;

assign storemerge_fu_188_p3 = ((icmp_fu_176_p2[0:0] == 1'b1) ? shl_fu_182_p2 : 32'd0);

assign sub30_fu_126_p2 = ($signed(sub_fu_114_p2) + $signed(12'd4069));

assign sub31_fu_132_p2 = (12'd27 - sub_fu_114_p2);

assign sub_fu_114_p2 = (12'd1075 - conv3_i_i_fu_74_p1);

assign sub_i_i_fu_94_p2 = (54'd0 - tmp_39_cast_cast_cast_cast_fu_90_p1);

assign tmp16_fu_278_p2 = (sel_tmp12_fu_272_p2 & cmp40_fu_160_p2);

assign tmp9_fu_64_p4 = {{bitcast_ln724_fu_48_p1[62:52]}};

assign tmp_181_fu_166_p4 = {{cond_fu_138_p3[11:5]}};

assign tmp_182_fu_210_p3 = bitcast_ln724_fu_48_p1[32'd63];

assign tmp_39_cast_cast_cast_cast_fu_90_p1 = tmp_39_cast_cast_cast_fu_82_p3;

assign tmp_39_cast_cast_cast_fu_82_p3 = {{1'd1}, {empty_52_fu_78_p1}};

assign tmp_fu_56_p3 = bitcast_ln724_fu_48_p1[32'd63];

assign ap_return = ((sel_tmp14_fu_284_p2[0:0] == 1'b1) ? empty_54_fu_206_p1 : sel_tmp9_fu_264_p3);

assign cmp29_fu_120_p2 = (($signed(sub_fu_114_p2) > $signed(12'd27)) ? 1'b1 : 1'b0);

assign cmp32_fu_150_p2 = ((sub_fu_114_p2 == 12'd27) ? 1'b1 : 1'b0);

assign cmp40_fu_160_p2 = ((cond_fu_138_p3 < 12'd54) ? 1'b1 : 1'b0);

assign cmp_fu_108_p2 = ((empty_fu_52_p1 == 63'd0) ? 1'b1 : 1'b0);

endmodule //kernel_ap_fixed_base
