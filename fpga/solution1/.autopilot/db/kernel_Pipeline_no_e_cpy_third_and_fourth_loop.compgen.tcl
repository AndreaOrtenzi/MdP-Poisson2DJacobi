# This script segment is generated automatically by AutoPilot

set id 944
set name kernel_mux_15_4_32_1_1
set corename simcore_mux
set op mux
set stage_num 1
set din0_width 32
set din0_signed 0
set din1_width 32
set din1_signed 0
set din2_width 32
set din2_signed 0
set din3_width 32
set din3_signed 0
set din4_width 32
set din4_signed 0
set din5_width 32
set din5_signed 0
set din6_width 32
set din6_signed 0
set din7_width 32
set din7_signed 0
set din8_width 32
set din8_signed 0
set din9_width 32
set din9_signed 0
set din10_width 32
set din10_signed 0
set din11_width 32
set din11_signed 0
set din12_width 32
set din12_signed 0
set din13_width 32
set din13_signed 0
set din14_width 32
set din14_signed 0
set din15_width 4
set din15_signed 0
set dout_width 32
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mux} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set op mux
set corename Multiplexer
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_pipemux] == "::AESL_LIB_VIRTEX::xil_gen_pipemux"} {
eval "::AESL_LIB_VIRTEX::xil_gen_pipemux { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    stage_num ${stage_num} \
    din0_width ${din0_width} \
    din0_signed ${din0_signed} \
    din1_width ${din1_width} \
    din1_signed ${din1_signed} \
    din2_width ${din2_width} \
    din2_signed ${din2_signed} \
    din3_width ${din3_width} \
    din3_signed ${din3_signed} \
    din4_width ${din4_width} \
    din4_signed ${din4_signed} \
    din5_width ${din5_width} \
    din5_signed ${din5_signed} \
    din6_width ${din6_width} \
    din6_signed ${din6_signed} \
    din7_width ${din7_width} \
    din7_signed ${din7_signed} \
    din8_width ${din8_width} \
    din8_signed ${din8_signed} \
    din9_width ${din9_width} \
    din9_signed ${din9_signed} \
    din10_width ${din10_width} \
    din10_signed ${din10_signed} \
    din11_width ${din11_width} \
    din11_signed ${din11_signed} \
    din12_width ${din12_width} \
    din12_signed ${din12_signed} \
    din13_width ${din13_width} \
    din13_signed ${din13_signed} \
    din14_width ${din14_width} \
    din14_signed ${din14_signed} \
    din15_width ${din15_width} \
    din15_signed ${din15_signed} \
    dout_width ${dout_width} \
}"
} else {
puts "@W \[IMPL-101\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_pipemux, check your platform lib"
}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 949 \
    name vp_252 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_252 \
    op interface \
    ports { vp_252 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 950 \
    name vp_251 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_251 \
    op interface \
    ports { vp_251 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 951 \
    name vp_250 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_250 \
    op interface \
    ports { vp_250 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 952 \
    name vp_249 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_249 \
    op interface \
    ports { vp_249 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 953 \
    name vp_248 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_248 \
    op interface \
    ports { vp_248 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 954 \
    name vp_247 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_247 \
    op interface \
    ports { vp_247 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 955 \
    name vp_246 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_246 \
    op interface \
    ports { vp_246 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 956 \
    name vp_245 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_245 \
    op interface \
    ports { vp_245 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 957 \
    name vp_244 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_244 \
    op interface \
    ports { vp_244 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 958 \
    name vp_243 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_243 \
    op interface \
    ports { vp_243 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 959 \
    name vp_242 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_242 \
    op interface \
    ports { vp_242 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 960 \
    name vp_241 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_241 \
    op interface \
    ports { vp_241 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 961 \
    name vp_240 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_240 \
    op interface \
    ports { vp_240 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 962 \
    name vp_239 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_239 \
    op interface \
    ports { vp_239 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 963 \
    name vp_460_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_460_reload \
    op interface \
    ports { vp_460_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 964 \
    name vp_459_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_459_reload \
    op interface \
    ports { vp_459_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 965 \
    name vp_444_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_444_reload \
    op interface \
    ports { vp_444_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 966 \
    name vp_443_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_443_reload \
    op interface \
    ports { vp_443_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 967 \
    name vp_428_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_428_reload \
    op interface \
    ports { vp_428_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 968 \
    name vp_427_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_427_reload \
    op interface \
    ports { vp_427_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 969 \
    name vp_412_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_412_reload \
    op interface \
    ports { vp_412_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 970 \
    name vp_411_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_411_reload \
    op interface \
    ports { vp_411_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 971 \
    name vp_396_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_396_reload \
    op interface \
    ports { vp_396_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 972 \
    name vp_395_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_395_reload \
    op interface \
    ports { vp_395_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 973 \
    name vp_380_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_380_reload \
    op interface \
    ports { vp_380_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 974 \
    name vp_379_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_379_reload \
    op interface \
    ports { vp_379_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 975 \
    name vp_364_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_364_reload \
    op interface \
    ports { vp_364_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 976 \
    name vp_363_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_363_reload \
    op interface \
    ports { vp_363_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 977 \
    name vp_348_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_348_reload \
    op interface \
    ports { vp_348_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 978 \
    name vp_347_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_347_reload \
    op interface \
    ports { vp_347_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 979 \
    name vp_332_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_332_reload \
    op interface \
    ports { vp_332_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 980 \
    name vp_331_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_331_reload \
    op interface \
    ports { vp_331_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 981 \
    name vp_316_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_316_reload \
    op interface \
    ports { vp_316_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 982 \
    name vp_315_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_315_reload \
    op interface \
    ports { vp_315_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 983 \
    name vp_300_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_300_reload \
    op interface \
    ports { vp_300_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 984 \
    name vp_299_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_299_reload \
    op interface \
    ports { vp_299_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 985 \
    name vp_284_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_284_reload \
    op interface \
    ports { vp_284_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 986 \
    name vp_283_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_283_reload \
    op interface \
    ports { vp_283_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 987 \
    name vp_268_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_268_reload \
    op interface \
    ports { vp_268_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 988 \
    name vp_267_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_267_reload \
    op interface \
    ports { vp_267_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 989 \
    name vp_16 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_16 \
    op interface \
    ports { vp_16 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 990 \
    name vp_15 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_15 \
    op interface \
    ports { vp_15 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 991 \
    name vp_14 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_14 \
    op interface \
    ports { vp_14 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 992 \
    name vp_13 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_13 \
    op interface \
    ports { vp_13 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 993 \
    name vp_12 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_12 \
    op interface \
    ports { vp_12 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 994 \
    name vp_11 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_11 \
    op interface \
    ports { vp_11 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 995 \
    name vp_10 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_10 \
    op interface \
    ports { vp_10 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 996 \
    name vp_9 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_9 \
    op interface \
    ports { vp_9 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 997 \
    name vp_8 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_8 \
    op interface \
    ports { vp_8 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 998 \
    name vp_7 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_7 \
    op interface \
    ports { vp_7 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 999 \
    name vp_6 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_6 \
    op interface \
    ports { vp_6 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1000 \
    name vp_5 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_5 \
    op interface \
    ports { vp_5 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1001 \
    name vp_4 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_4 \
    op interface \
    ports { vp_4 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1002 \
    name vp_3 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_3 \
    op interface \
    ports { vp_3 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1003 \
    name vp_2 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_2 \
    op interface \
    ports { vp_2 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1004 \
    name vp_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_1 \
    op interface \
    ports { vp_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1005 \
    name vp_461_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_461_reload \
    op interface \
    ports { vp_461_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1006 \
    name vp_462_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_462_reload \
    op interface \
    ports { vp_462_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1007 \
    name vp_463_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_463_reload \
    op interface \
    ports { vp_463_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1008 \
    name vp_464_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_464_reload \
    op interface \
    ports { vp_464_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1009 \
    name vp_465_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_465_reload \
    op interface \
    ports { vp_465_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1010 \
    name vp_466_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_466_reload \
    op interface \
    ports { vp_466_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1011 \
    name vp_467_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_467_reload \
    op interface \
    ports { vp_467_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1012 \
    name vp_468_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_468_reload \
    op interface \
    ports { vp_468_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1013 \
    name vp_469_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_469_reload \
    op interface \
    ports { vp_469_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1014 \
    name vp_470_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_470_reload \
    op interface \
    ports { vp_470_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1015 \
    name vp_471_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_471_reload \
    op interface \
    ports { vp_471_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1016 \
    name vp_472_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_472_reload \
    op interface \
    ports { vp_472_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1017 \
    name vp_473_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_473_reload \
    op interface \
    ports { vp_473_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1018 \
    name vp_474_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_474_reload \
    op interface \
    ports { vp_474_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1019 \
    name vp_253_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_253_reload \
    op interface \
    ports { vp_253_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1020 \
    name vp_254_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_254_reload \
    op interface \
    ports { vp_254_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1021 \
    name vp_255_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_255_reload \
    op interface \
    ports { vp_255_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1022 \
    name vp_256_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_256_reload \
    op interface \
    ports { vp_256_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1023 \
    name vp_257_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_257_reload \
    op interface \
    ports { vp_257_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1024 \
    name vp_258_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_258_reload \
    op interface \
    ports { vp_258_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1025 \
    name vp_259_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_259_reload \
    op interface \
    ports { vp_259_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1026 \
    name vp_260_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_260_reload \
    op interface \
    ports { vp_260_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1027 \
    name vp_261_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_261_reload \
    op interface \
    ports { vp_261_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1028 \
    name vp_262_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_262_reload \
    op interface \
    ports { vp_262_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1029 \
    name vp_263_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_263_reload \
    op interface \
    ports { vp_263_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1030 \
    name vp_264_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_264_reload \
    op interface \
    ports { vp_264_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1031 \
    name vp_265_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_265_reload \
    op interface \
    ports { vp_265_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1032 \
    name vp_266_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_266_reload \
    op interface \
    ports { vp_266_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1033 \
    name vp_282_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_282_reload \
    op interface \
    ports { vp_282_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1034 \
    name vp_298_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_298_reload \
    op interface \
    ports { vp_298_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1035 \
    name vp_314_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_314_reload \
    op interface \
    ports { vp_314_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1036 \
    name vp_330_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_330_reload \
    op interface \
    ports { vp_330_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1037 \
    name vp_346_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_346_reload \
    op interface \
    ports { vp_346_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1038 \
    name vp_362_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_362_reload \
    op interface \
    ports { vp_362_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1039 \
    name vp_378_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_378_reload \
    op interface \
    ports { vp_378_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1040 \
    name vp_394_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_394_reload \
    op interface \
    ports { vp_394_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1041 \
    name vp_410_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_410_reload \
    op interface \
    ports { vp_410_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1042 \
    name vp_426_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_426_reload \
    op interface \
    ports { vp_426_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1043 \
    name vp_442_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_442_reload \
    op interface \
    ports { vp_442_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1044 \
    name vp_458_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_458_reload \
    op interface \
    ports { vp_458_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1045 \
    name vp_269_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_269_reload \
    op interface \
    ports { vp_269_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1046 \
    name vp_285_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_285_reload \
    op interface \
    ports { vp_285_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1047 \
    name vp_301_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_301_reload \
    op interface \
    ports { vp_301_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1048 \
    name vp_317_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_317_reload \
    op interface \
    ports { vp_317_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1049 \
    name vp_333_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_333_reload \
    op interface \
    ports { vp_333_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1050 \
    name vp_349_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_349_reload \
    op interface \
    ports { vp_349_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1051 \
    name vp_365_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_365_reload \
    op interface \
    ports { vp_365_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1052 \
    name vp_381_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_381_reload \
    op interface \
    ports { vp_381_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1053 \
    name vp_397_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_397_reload \
    op interface \
    ports { vp_397_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1054 \
    name vp_413_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_413_reload \
    op interface \
    ports { vp_413_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1055 \
    name vp_429_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_429_reload \
    op interface \
    ports { vp_429_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1056 \
    name vp_445_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_445_reload \
    op interface \
    ports { vp_445_reload { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1057 \
    name vp_529_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_529_out \
    op interface \
    ports { vp_529_out { O 32 vector } vp_529_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1058 \
    name vp_528_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_528_out \
    op interface \
    ports { vp_528_out { O 32 vector } vp_528_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1059 \
    name vp_527_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_527_out \
    op interface \
    ports { vp_527_out { O 32 vector } vp_527_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1060 \
    name vp_526_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_526_out \
    op interface \
    ports { vp_526_out { O 32 vector } vp_526_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1061 \
    name vp_525_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_525_out \
    op interface \
    ports { vp_525_out { O 32 vector } vp_525_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1062 \
    name vp_524_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_524_out \
    op interface \
    ports { vp_524_out { O 32 vector } vp_524_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1063 \
    name vp_523_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_523_out \
    op interface \
    ports { vp_523_out { O 32 vector } vp_523_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1064 \
    name vp_522_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_522_out \
    op interface \
    ports { vp_522_out { O 32 vector } vp_522_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1065 \
    name vp_521_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_521_out \
    op interface \
    ports { vp_521_out { O 32 vector } vp_521_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1066 \
    name vp_520_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_520_out \
    op interface \
    ports { vp_520_out { O 32 vector } vp_520_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1067 \
    name vp_519_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_519_out \
    op interface \
    ports { vp_519_out { O 32 vector } vp_519_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1068 \
    name vp_518_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_518_out \
    op interface \
    ports { vp_518_out { O 32 vector } vp_518_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1069 \
    name vp_517_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_517_out \
    op interface \
    ports { vp_517_out { O 32 vector } vp_517_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1070 \
    name vp_516_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_516_out \
    op interface \
    ports { vp_516_out { O 32 vector } vp_516_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1071 \
    name vp_515_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_515_out \
    op interface \
    ports { vp_515_out { O 32 vector } vp_515_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1072 \
    name vp_514_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_514_out \
    op interface \
    ports { vp_514_out { O 32 vector } vp_514_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1073 \
    name vp_513_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_513_out \
    op interface \
    ports { vp_513_out { O 32 vector } vp_513_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1074 \
    name vp_512_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_512_out \
    op interface \
    ports { vp_512_out { O 32 vector } vp_512_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1075 \
    name vp_511_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_511_out \
    op interface \
    ports { vp_511_out { O 32 vector } vp_511_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1076 \
    name vp_510_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_510_out \
    op interface \
    ports { vp_510_out { O 32 vector } vp_510_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1077 \
    name vp_509_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_509_out \
    op interface \
    ports { vp_509_out { O 32 vector } vp_509_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1078 \
    name vp_508_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_508_out \
    op interface \
    ports { vp_508_out { O 32 vector } vp_508_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1079 \
    name vp_507_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_507_out \
    op interface \
    ports { vp_507_out { O 32 vector } vp_507_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1080 \
    name vp_506_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_506_out \
    op interface \
    ports { vp_506_out { O 32 vector } vp_506_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1081 \
    name vp_505_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_505_out \
    op interface \
    ports { vp_505_out { O 32 vector } vp_505_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1082 \
    name vp_504_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_504_out \
    op interface \
    ports { vp_504_out { O 32 vector } vp_504_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1083 \
    name vp_503_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_503_out \
    op interface \
    ports { vp_503_out { O 32 vector } vp_503_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1084 \
    name vp_502_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_502_out \
    op interface \
    ports { vp_502_out { O 32 vector } vp_502_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1085 \
    name vp_501_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_501_out \
    op interface \
    ports { vp_501_out { O 32 vector } vp_501_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1086 \
    name vp_500_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_500_out \
    op interface \
    ports { vp_500_out { O 32 vector } vp_500_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1087 \
    name vp_499_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_499_out \
    op interface \
    ports { vp_499_out { O 32 vector } vp_499_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1088 \
    name vp_498_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_498_out \
    op interface \
    ports { vp_498_out { O 32 vector } vp_498_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1089 \
    name vp_497_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_497_out \
    op interface \
    ports { vp_497_out { O 32 vector } vp_497_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1090 \
    name vp_496_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_496_out \
    op interface \
    ports { vp_496_out { O 32 vector } vp_496_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1091 \
    name vp_495_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_495_out \
    op interface \
    ports { vp_495_out { O 32 vector } vp_495_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1092 \
    name vp_494_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_494_out \
    op interface \
    ports { vp_494_out { O 32 vector } vp_494_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1093 \
    name vp_493_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_493_out \
    op interface \
    ports { vp_493_out { O 32 vector } vp_493_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1094 \
    name vp_492_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_492_out \
    op interface \
    ports { vp_492_out { O 32 vector } vp_492_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1095 \
    name vp_491_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_491_out \
    op interface \
    ports { vp_491_out { O 32 vector } vp_491_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1096 \
    name vp_490_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_490_out \
    op interface \
    ports { vp_490_out { O 32 vector } vp_490_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1097 \
    name vp_489_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_489_out \
    op interface \
    ports { vp_489_out { O 32 vector } vp_489_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1098 \
    name vp_488_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_488_out \
    op interface \
    ports { vp_488_out { O 32 vector } vp_488_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1099 \
    name vp_487_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_487_out \
    op interface \
    ports { vp_487_out { O 32 vector } vp_487_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1100 \
    name vp_486_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_486_out \
    op interface \
    ports { vp_486_out { O 32 vector } vp_486_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1101 \
    name vp_485_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_485_out \
    op interface \
    ports { vp_485_out { O 32 vector } vp_485_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1102 \
    name vp_484_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_484_out \
    op interface \
    ports { vp_484_out { O 32 vector } vp_484_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1103 \
    name vp_483_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_483_out \
    op interface \
    ports { vp_483_out { O 32 vector } vp_483_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1104 \
    name vp_482_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_482_out \
    op interface \
    ports { vp_482_out { O 32 vector } vp_482_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1105 \
    name vp_481_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_481_out \
    op interface \
    ports { vp_481_out { O 32 vector } vp_481_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1106 \
    name vp_480_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_480_out \
    op interface \
    ports { vp_480_out { O 32 vector } vp_480_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1107 \
    name vp_479_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_479_out \
    op interface \
    ports { vp_479_out { O 32 vector } vp_479_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1108 \
    name vp_478_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_478_out \
    op interface \
    ports { vp_478_out { O 32 vector } vp_478_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1109 \
    name vp_477_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_477_out \
    op interface \
    ports { vp_477_out { O 32 vector } vp_477_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1110 \
    name vp_476_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_476_out \
    op interface \
    ports { vp_476_out { O 32 vector } vp_476_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1111 \
    name vp_475_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_475_out \
    op interface \
    ports { vp_475_out { O 32 vector } vp_475_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1112 \
    name vp_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_vp_out \
    op interface \
    ports { vp_out { O 32 vector } vp_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName kernel_flow_control_loop_pipe_sequential_init_U
set CompName kernel_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix kernel_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


