// ==============================================================
// Generated by Vitis HLS v2023.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module kernel_kernel_Pipeline_6 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        m_axi_gmem0_AWVALID,
        m_axi_gmem0_AWREADY,
        m_axi_gmem0_AWADDR,
        m_axi_gmem0_AWID,
        m_axi_gmem0_AWLEN,
        m_axi_gmem0_AWSIZE,
        m_axi_gmem0_AWBURST,
        m_axi_gmem0_AWLOCK,
        m_axi_gmem0_AWCACHE,
        m_axi_gmem0_AWPROT,
        m_axi_gmem0_AWQOS,
        m_axi_gmem0_AWREGION,
        m_axi_gmem0_AWUSER,
        m_axi_gmem0_WVALID,
        m_axi_gmem0_WREADY,
        m_axi_gmem0_WDATA,
        m_axi_gmem0_WSTRB,
        m_axi_gmem0_WLAST,
        m_axi_gmem0_WID,
        m_axi_gmem0_WUSER,
        m_axi_gmem0_ARVALID,
        m_axi_gmem0_ARREADY,
        m_axi_gmem0_ARADDR,
        m_axi_gmem0_ARID,
        m_axi_gmem0_ARLEN,
        m_axi_gmem0_ARSIZE,
        m_axi_gmem0_ARBURST,
        m_axi_gmem0_ARLOCK,
        m_axi_gmem0_ARCACHE,
        m_axi_gmem0_ARPROT,
        m_axi_gmem0_ARQOS,
        m_axi_gmem0_ARREGION,
        m_axi_gmem0_ARUSER,
        m_axi_gmem0_RVALID,
        m_axi_gmem0_RREADY,
        m_axi_gmem0_RDATA,
        m_axi_gmem0_RLAST,
        m_axi_gmem0_RID,
        m_axi_gmem0_RFIFONUM,
        m_axi_gmem0_RUSER,
        m_axi_gmem0_RRESP,
        m_axi_gmem0_BVALID,
        m_axi_gmem0_BREADY,
        m_axi_gmem0_BRESP,
        m_axi_gmem0_BID,
        m_axi_gmem0_BUSER,
        sext_ln202,
        v,
        v_494,
        v_495,
        v_496,
        v_497,
        v_498,
        v_499,
        v_500,
        v_501,
        v_502,
        v_503,
        v_504,
        v_505,
        v_506,
        v_507,
        v_14,
        v_478,
        v_479,
        v_256,
        v_257,
        v_258,
        v_259,
        v_260,
        v_261,
        v_262,
        v_263,
        v_264,
        v_265,
        v_266,
        v_267,
        v_268,
        v_269,
        v_270,
        v_271,
        v_272,
        v_273,
        v_274,
        v_275,
        v_276,
        v_277,
        v_278,
        v_279,
        v_280,
        v_281,
        v_282,
        v_283,
        v_284,
        v_285,
        v_286,
        v_287,
        v_288,
        v_289,
        v_290,
        v_291,
        v_292,
        v_293,
        v_294,
        v_295,
        v_296,
        v_297,
        v_298,
        v_299,
        v_300,
        v_301,
        v_302,
        v_303,
        v_304,
        v_305,
        v_306,
        v_307,
        v_308,
        v_309,
        v_310,
        v_311,
        v_312,
        v_313,
        v_314,
        v_315,
        v_316,
        v_317,
        v_318,
        v_319,
        v_320,
        v_321,
        v_322,
        v_323,
        v_324,
        v_325,
        v_326,
        v_327,
        v_328,
        v_329,
        v_330,
        v_331,
        v_332,
        v_333,
        v_334,
        v_335,
        v_336,
        v_337,
        v_338,
        v_339,
        v_340,
        v_341,
        v_342,
        v_343,
        v_344,
        v_345,
        v_346,
        v_347,
        v_348,
        v_349,
        v_350,
        v_351,
        v_352,
        v_353,
        v_354,
        v_355,
        v_356,
        v_357,
        v_358,
        v_359,
        v_360,
        v_361,
        v_362,
        v_363,
        v_364,
        v_365,
        v_366,
        v_367,
        v_368,
        v_369,
        v_370,
        v_371,
        v_372,
        v_373,
        v_374,
        v_375,
        v_376,
        v_377,
        v_378,
        v_379,
        v_380,
        v_381,
        v_382,
        v_383,
        v_384,
        v_385,
        v_386,
        v_387,
        v_388,
        v_389,
        v_390,
        v_391,
        v_392,
        v_393,
        v_394,
        v_395,
        v_396,
        v_397,
        v_398,
        v_399,
        v_400,
        v_401,
        v_402,
        v_403,
        v_404,
        v_405,
        v_406,
        v_407,
        v_408,
        v_409,
        v_410,
        v_411,
        v_412,
        v_413,
        v_414,
        v_415,
        v_416,
        v_417,
        v_418,
        v_419,
        v_420,
        v_421,
        v_422,
        v_423,
        v_424,
        v_425,
        v_426,
        v_427,
        v_428,
        v_429,
        v_430,
        v_431,
        v_432,
        v_433,
        v_434,
        v_435,
        v_436,
        v_437,
        v_438,
        v_439,
        v_440,
        v_441,
        v_442,
        v_443,
        v_444,
        v_445,
        v_446,
        v_447,
        v_448,
        v_449,
        v_450,
        v_451,
        v_452,
        v_453,
        v_454,
        v_455,
        v_456,
        v_457,
        v_458,
        v_459,
        v_460,
        v_461,
        v_462,
        v_463,
        v_464,
        v_465,
        v_466,
        v_467,
        v_468,
        v_469,
        v_470,
        v_471,
        v_472,
        v_473,
        v_474,
        v_475,
        v_476,
        v_477,
        v_239,
        v_480,
        v_481,
        v_482,
        v_483,
        v_484,
        v_485,
        v_486,
        v_487,
        v_488,
        v_489,
        v_490,
        v_491,
        v_492,
        v_493,
        v_254
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output   m_axi_gmem0_AWVALID;
input   m_axi_gmem0_AWREADY;
output  [63:0] m_axi_gmem0_AWADDR;
output  [0:0] m_axi_gmem0_AWID;
output  [31:0] m_axi_gmem0_AWLEN;
output  [2:0] m_axi_gmem0_AWSIZE;
output  [1:0] m_axi_gmem0_AWBURST;
output  [1:0] m_axi_gmem0_AWLOCK;
output  [3:0] m_axi_gmem0_AWCACHE;
output  [2:0] m_axi_gmem0_AWPROT;
output  [3:0] m_axi_gmem0_AWQOS;
output  [3:0] m_axi_gmem0_AWREGION;
output  [0:0] m_axi_gmem0_AWUSER;
output   m_axi_gmem0_WVALID;
input   m_axi_gmem0_WREADY;
output  [511:0] m_axi_gmem0_WDATA;
output  [63:0] m_axi_gmem0_WSTRB;
output   m_axi_gmem0_WLAST;
output  [0:0] m_axi_gmem0_WID;
output  [0:0] m_axi_gmem0_WUSER;
output   m_axi_gmem0_ARVALID;
input   m_axi_gmem0_ARREADY;
output  [63:0] m_axi_gmem0_ARADDR;
output  [0:0] m_axi_gmem0_ARID;
output  [31:0] m_axi_gmem0_ARLEN;
output  [2:0] m_axi_gmem0_ARSIZE;
output  [1:0] m_axi_gmem0_ARBURST;
output  [1:0] m_axi_gmem0_ARLOCK;
output  [3:0] m_axi_gmem0_ARCACHE;
output  [2:0] m_axi_gmem0_ARPROT;
output  [3:0] m_axi_gmem0_ARQOS;
output  [3:0] m_axi_gmem0_ARREGION;
output  [0:0] m_axi_gmem0_ARUSER;
input   m_axi_gmem0_RVALID;
output   m_axi_gmem0_RREADY;
input  [511:0] m_axi_gmem0_RDATA;
input   m_axi_gmem0_RLAST;
input  [0:0] m_axi_gmem0_RID;
input  [8:0] m_axi_gmem0_RFIFONUM;
input  [0:0] m_axi_gmem0_RUSER;
input  [1:0] m_axi_gmem0_RRESP;
input   m_axi_gmem0_BVALID;
output   m_axi_gmem0_BREADY;
input  [1:0] m_axi_gmem0_BRESP;
input  [0:0] m_axi_gmem0_BID;
input  [0:0] m_axi_gmem0_BUSER;
input  [57:0] sext_ln202;
input  [31:0] v;
input  [31:0] v_494;
input  [31:0] v_495;
input  [31:0] v_496;
input  [31:0] v_497;
input  [31:0] v_498;
input  [31:0] v_499;
input  [31:0] v_500;
input  [31:0] v_501;
input  [31:0] v_502;
input  [31:0] v_503;
input  [31:0] v_504;
input  [31:0] v_505;
input  [31:0] v_506;
input  [31:0] v_507;
input  [31:0] v_14;
input  [31:0] v_478;
input  [31:0] v_479;
input  [31:0] v_256;
input  [31:0] v_257;
input  [31:0] v_258;
input  [31:0] v_259;
input  [31:0] v_260;
input  [31:0] v_261;
input  [31:0] v_262;
input  [31:0] v_263;
input  [31:0] v_264;
input  [31:0] v_265;
input  [31:0] v_266;
input  [31:0] v_267;
input  [31:0] v_268;
input  [31:0] v_269;
input  [31:0] v_270;
input  [31:0] v_271;
input  [31:0] v_272;
input  [31:0] v_273;
input  [31:0] v_274;
input  [31:0] v_275;
input  [31:0] v_276;
input  [31:0] v_277;
input  [31:0] v_278;
input  [31:0] v_279;
input  [31:0] v_280;
input  [31:0] v_281;
input  [31:0] v_282;
input  [31:0] v_283;
input  [31:0] v_284;
input  [31:0] v_285;
input  [31:0] v_286;
input  [31:0] v_287;
input  [31:0] v_288;
input  [31:0] v_289;
input  [31:0] v_290;
input  [31:0] v_291;
input  [31:0] v_292;
input  [31:0] v_293;
input  [31:0] v_294;
input  [31:0] v_295;
input  [31:0] v_296;
input  [31:0] v_297;
input  [31:0] v_298;
input  [31:0] v_299;
input  [31:0] v_300;
input  [31:0] v_301;
input  [31:0] v_302;
input  [31:0] v_303;
input  [31:0] v_304;
input  [31:0] v_305;
input  [31:0] v_306;
input  [31:0] v_307;
input  [31:0] v_308;
input  [31:0] v_309;
input  [31:0] v_310;
input  [31:0] v_311;
input  [31:0] v_312;
input  [31:0] v_313;
input  [31:0] v_314;
input  [31:0] v_315;
input  [31:0] v_316;
input  [31:0] v_317;
input  [31:0] v_318;
input  [31:0] v_319;
input  [31:0] v_320;
input  [31:0] v_321;
input  [31:0] v_322;
input  [31:0] v_323;
input  [31:0] v_324;
input  [31:0] v_325;
input  [31:0] v_326;
input  [31:0] v_327;
input  [31:0] v_328;
input  [31:0] v_329;
input  [31:0] v_330;
input  [31:0] v_331;
input  [31:0] v_332;
input  [31:0] v_333;
input  [31:0] v_334;
input  [31:0] v_335;
input  [31:0] v_336;
input  [31:0] v_337;
input  [31:0] v_338;
input  [31:0] v_339;
input  [31:0] v_340;
input  [31:0] v_341;
input  [31:0] v_342;
input  [31:0] v_343;
input  [31:0] v_344;
input  [31:0] v_345;
input  [31:0] v_346;
input  [31:0] v_347;
input  [31:0] v_348;
input  [31:0] v_349;
input  [31:0] v_350;
input  [31:0] v_351;
input  [31:0] v_352;
input  [31:0] v_353;
input  [31:0] v_354;
input  [31:0] v_355;
input  [31:0] v_356;
input  [31:0] v_357;
input  [31:0] v_358;
input  [31:0] v_359;
input  [31:0] v_360;
input  [31:0] v_361;
input  [31:0] v_362;
input  [31:0] v_363;
input  [31:0] v_364;
input  [31:0] v_365;
input  [31:0] v_366;
input  [31:0] v_367;
input  [31:0] v_368;
input  [31:0] v_369;
input  [31:0] v_370;
input  [31:0] v_371;
input  [31:0] v_372;
input  [31:0] v_373;
input  [31:0] v_374;
input  [31:0] v_375;
input  [31:0] v_376;
input  [31:0] v_377;
input  [31:0] v_378;
input  [31:0] v_379;
input  [31:0] v_380;
input  [31:0] v_381;
input  [31:0] v_382;
input  [31:0] v_383;
input  [31:0] v_384;
input  [31:0] v_385;
input  [31:0] v_386;
input  [31:0] v_387;
input  [31:0] v_388;
input  [31:0] v_389;
input  [31:0] v_390;
input  [31:0] v_391;
input  [31:0] v_392;
input  [31:0] v_393;
input  [31:0] v_394;
input  [31:0] v_395;
input  [31:0] v_396;
input  [31:0] v_397;
input  [31:0] v_398;
input  [31:0] v_399;
input  [31:0] v_400;
input  [31:0] v_401;
input  [31:0] v_402;
input  [31:0] v_403;
input  [31:0] v_404;
input  [31:0] v_405;
input  [31:0] v_406;
input  [31:0] v_407;
input  [31:0] v_408;
input  [31:0] v_409;
input  [31:0] v_410;
input  [31:0] v_411;
input  [31:0] v_412;
input  [31:0] v_413;
input  [31:0] v_414;
input  [31:0] v_415;
input  [31:0] v_416;
input  [31:0] v_417;
input  [31:0] v_418;
input  [31:0] v_419;
input  [31:0] v_420;
input  [31:0] v_421;
input  [31:0] v_422;
input  [31:0] v_423;
input  [31:0] v_424;
input  [31:0] v_425;
input  [31:0] v_426;
input  [31:0] v_427;
input  [31:0] v_428;
input  [31:0] v_429;
input  [31:0] v_430;
input  [31:0] v_431;
input  [31:0] v_432;
input  [31:0] v_433;
input  [31:0] v_434;
input  [31:0] v_435;
input  [31:0] v_436;
input  [31:0] v_437;
input  [31:0] v_438;
input  [31:0] v_439;
input  [31:0] v_440;
input  [31:0] v_441;
input  [31:0] v_442;
input  [31:0] v_443;
input  [31:0] v_444;
input  [31:0] v_445;
input  [31:0] v_446;
input  [31:0] v_447;
input  [31:0] v_448;
input  [31:0] v_449;
input  [31:0] v_450;
input  [31:0] v_451;
input  [31:0] v_452;
input  [31:0] v_453;
input  [31:0] v_454;
input  [31:0] v_455;
input  [31:0] v_456;
input  [31:0] v_457;
input  [31:0] v_458;
input  [31:0] v_459;
input  [31:0] v_460;
input  [31:0] v_461;
input  [31:0] v_462;
input  [31:0] v_463;
input  [31:0] v_464;
input  [31:0] v_465;
input  [31:0] v_466;
input  [31:0] v_467;
input  [31:0] v_468;
input  [31:0] v_469;
input  [31:0] v_470;
input  [31:0] v_471;
input  [31:0] v_472;
input  [31:0] v_473;
input  [31:0] v_474;
input  [31:0] v_475;
input  [31:0] v_476;
input  [31:0] v_477;
input  [31:0] v_239;
input  [31:0] v_480;
input  [31:0] v_481;
input  [31:0] v_482;
input  [31:0] v_483;
input  [31:0] v_484;
input  [31:0] v_485;
input  [31:0] v_486;
input  [31:0] v_487;
input  [31:0] v_488;
input  [31:0] v_489;
input  [31:0] v_490;
input  [31:0] v_491;
input  [31:0] v_492;
input  [31:0] v_493;
input  [31:0] v_254;

reg ap_idle;
reg m_axi_gmem0_WVALID;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg   [0:0] empty_48_reg_2780;
reg    ap_block_state2_io;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] exitcond4_fu_2159_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    gmem0_blk_n_W;
wire    ap_block_pp0_stage0;
reg    ap_block_pp0_stage0_11001;
wire   [31:0] tmp_21_fu_2179_p258;
reg   [31:0] tmp_21_reg_2774;
wire   [0:0] empty_48_fu_2697_p2;
wire    ap_block_pp0_stage0_01001;
reg   [479:0] shiftreg_fu_578;
wire   [479:0] empty_45_fu_2739_p3;
wire    ap_loop_init;
reg   [8:0] loop_index_fu_582;
wire   [8:0] empty_fu_2165_p2;
reg   [8:0] ap_sig_allocacmp_loop_index_load;
wire   [7:0] tmp_21_fu_2179_p257;
wire   [3:0] empty_46_fu_2171_p1;
wire   [447:0] tmp_39_fu_2722_p4;
wire   [479:0] tmp_40_fu_2732_p3;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_done_reg = 1'b0;
end

kernel_mux_256_8_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .din2_WIDTH( 32 ),
    .din3_WIDTH( 32 ),
    .din4_WIDTH( 32 ),
    .din5_WIDTH( 32 ),
    .din6_WIDTH( 32 ),
    .din7_WIDTH( 32 ),
    .din8_WIDTH( 32 ),
    .din9_WIDTH( 32 ),
    .din10_WIDTH( 32 ),
    .din11_WIDTH( 32 ),
    .din12_WIDTH( 32 ),
    .din13_WIDTH( 32 ),
    .din14_WIDTH( 32 ),
    .din15_WIDTH( 32 ),
    .din16_WIDTH( 32 ),
    .din17_WIDTH( 32 ),
    .din18_WIDTH( 32 ),
    .din19_WIDTH( 32 ),
    .din20_WIDTH( 32 ),
    .din21_WIDTH( 32 ),
    .din22_WIDTH( 32 ),
    .din23_WIDTH( 32 ),
    .din24_WIDTH( 32 ),
    .din25_WIDTH( 32 ),
    .din26_WIDTH( 32 ),
    .din27_WIDTH( 32 ),
    .din28_WIDTH( 32 ),
    .din29_WIDTH( 32 ),
    .din30_WIDTH( 32 ),
    .din31_WIDTH( 32 ),
    .din32_WIDTH( 32 ),
    .din33_WIDTH( 32 ),
    .din34_WIDTH( 32 ),
    .din35_WIDTH( 32 ),
    .din36_WIDTH( 32 ),
    .din37_WIDTH( 32 ),
    .din38_WIDTH( 32 ),
    .din39_WIDTH( 32 ),
    .din40_WIDTH( 32 ),
    .din41_WIDTH( 32 ),
    .din42_WIDTH( 32 ),
    .din43_WIDTH( 32 ),
    .din44_WIDTH( 32 ),
    .din45_WIDTH( 32 ),
    .din46_WIDTH( 32 ),
    .din47_WIDTH( 32 ),
    .din48_WIDTH( 32 ),
    .din49_WIDTH( 32 ),
    .din50_WIDTH( 32 ),
    .din51_WIDTH( 32 ),
    .din52_WIDTH( 32 ),
    .din53_WIDTH( 32 ),
    .din54_WIDTH( 32 ),
    .din55_WIDTH( 32 ),
    .din56_WIDTH( 32 ),
    .din57_WIDTH( 32 ),
    .din58_WIDTH( 32 ),
    .din59_WIDTH( 32 ),
    .din60_WIDTH( 32 ),
    .din61_WIDTH( 32 ),
    .din62_WIDTH( 32 ),
    .din63_WIDTH( 32 ),
    .din64_WIDTH( 32 ),
    .din65_WIDTH( 32 ),
    .din66_WIDTH( 32 ),
    .din67_WIDTH( 32 ),
    .din68_WIDTH( 32 ),
    .din69_WIDTH( 32 ),
    .din70_WIDTH( 32 ),
    .din71_WIDTH( 32 ),
    .din72_WIDTH( 32 ),
    .din73_WIDTH( 32 ),
    .din74_WIDTH( 32 ),
    .din75_WIDTH( 32 ),
    .din76_WIDTH( 32 ),
    .din77_WIDTH( 32 ),
    .din78_WIDTH( 32 ),
    .din79_WIDTH( 32 ),
    .din80_WIDTH( 32 ),
    .din81_WIDTH( 32 ),
    .din82_WIDTH( 32 ),
    .din83_WIDTH( 32 ),
    .din84_WIDTH( 32 ),
    .din85_WIDTH( 32 ),
    .din86_WIDTH( 32 ),
    .din87_WIDTH( 32 ),
    .din88_WIDTH( 32 ),
    .din89_WIDTH( 32 ),
    .din90_WIDTH( 32 ),
    .din91_WIDTH( 32 ),
    .din92_WIDTH( 32 ),
    .din93_WIDTH( 32 ),
    .din94_WIDTH( 32 ),
    .din95_WIDTH( 32 ),
    .din96_WIDTH( 32 ),
    .din97_WIDTH( 32 ),
    .din98_WIDTH( 32 ),
    .din99_WIDTH( 32 ),
    .din100_WIDTH( 32 ),
    .din101_WIDTH( 32 ),
    .din102_WIDTH( 32 ),
    .din103_WIDTH( 32 ),
    .din104_WIDTH( 32 ),
    .din105_WIDTH( 32 ),
    .din106_WIDTH( 32 ),
    .din107_WIDTH( 32 ),
    .din108_WIDTH( 32 ),
    .din109_WIDTH( 32 ),
    .din110_WIDTH( 32 ),
    .din111_WIDTH( 32 ),
    .din112_WIDTH( 32 ),
    .din113_WIDTH( 32 ),
    .din114_WIDTH( 32 ),
    .din115_WIDTH( 32 ),
    .din116_WIDTH( 32 ),
    .din117_WIDTH( 32 ),
    .din118_WIDTH( 32 ),
    .din119_WIDTH( 32 ),
    .din120_WIDTH( 32 ),
    .din121_WIDTH( 32 ),
    .din122_WIDTH( 32 ),
    .din123_WIDTH( 32 ),
    .din124_WIDTH( 32 ),
    .din125_WIDTH( 32 ),
    .din126_WIDTH( 32 ),
    .din127_WIDTH( 32 ),
    .din128_WIDTH( 32 ),
    .din129_WIDTH( 32 ),
    .din130_WIDTH( 32 ),
    .din131_WIDTH( 32 ),
    .din132_WIDTH( 32 ),
    .din133_WIDTH( 32 ),
    .din134_WIDTH( 32 ),
    .din135_WIDTH( 32 ),
    .din136_WIDTH( 32 ),
    .din137_WIDTH( 32 ),
    .din138_WIDTH( 32 ),
    .din139_WIDTH( 32 ),
    .din140_WIDTH( 32 ),
    .din141_WIDTH( 32 ),
    .din142_WIDTH( 32 ),
    .din143_WIDTH( 32 ),
    .din144_WIDTH( 32 ),
    .din145_WIDTH( 32 ),
    .din146_WIDTH( 32 ),
    .din147_WIDTH( 32 ),
    .din148_WIDTH( 32 ),
    .din149_WIDTH( 32 ),
    .din150_WIDTH( 32 ),
    .din151_WIDTH( 32 ),
    .din152_WIDTH( 32 ),
    .din153_WIDTH( 32 ),
    .din154_WIDTH( 32 ),
    .din155_WIDTH( 32 ),
    .din156_WIDTH( 32 ),
    .din157_WIDTH( 32 ),
    .din158_WIDTH( 32 ),
    .din159_WIDTH( 32 ),
    .din160_WIDTH( 32 ),
    .din161_WIDTH( 32 ),
    .din162_WIDTH( 32 ),
    .din163_WIDTH( 32 ),
    .din164_WIDTH( 32 ),
    .din165_WIDTH( 32 ),
    .din166_WIDTH( 32 ),
    .din167_WIDTH( 32 ),
    .din168_WIDTH( 32 ),
    .din169_WIDTH( 32 ),
    .din170_WIDTH( 32 ),
    .din171_WIDTH( 32 ),
    .din172_WIDTH( 32 ),
    .din173_WIDTH( 32 ),
    .din174_WIDTH( 32 ),
    .din175_WIDTH( 32 ),
    .din176_WIDTH( 32 ),
    .din177_WIDTH( 32 ),
    .din178_WIDTH( 32 ),
    .din179_WIDTH( 32 ),
    .din180_WIDTH( 32 ),
    .din181_WIDTH( 32 ),
    .din182_WIDTH( 32 ),
    .din183_WIDTH( 32 ),
    .din184_WIDTH( 32 ),
    .din185_WIDTH( 32 ),
    .din186_WIDTH( 32 ),
    .din187_WIDTH( 32 ),
    .din188_WIDTH( 32 ),
    .din189_WIDTH( 32 ),
    .din190_WIDTH( 32 ),
    .din191_WIDTH( 32 ),
    .din192_WIDTH( 32 ),
    .din193_WIDTH( 32 ),
    .din194_WIDTH( 32 ),
    .din195_WIDTH( 32 ),
    .din196_WIDTH( 32 ),
    .din197_WIDTH( 32 ),
    .din198_WIDTH( 32 ),
    .din199_WIDTH( 32 ),
    .din200_WIDTH( 32 ),
    .din201_WIDTH( 32 ),
    .din202_WIDTH( 32 ),
    .din203_WIDTH( 32 ),
    .din204_WIDTH( 32 ),
    .din205_WIDTH( 32 ),
    .din206_WIDTH( 32 ),
    .din207_WIDTH( 32 ),
    .din208_WIDTH( 32 ),
    .din209_WIDTH( 32 ),
    .din210_WIDTH( 32 ),
    .din211_WIDTH( 32 ),
    .din212_WIDTH( 32 ),
    .din213_WIDTH( 32 ),
    .din214_WIDTH( 32 ),
    .din215_WIDTH( 32 ),
    .din216_WIDTH( 32 ),
    .din217_WIDTH( 32 ),
    .din218_WIDTH( 32 ),
    .din219_WIDTH( 32 ),
    .din220_WIDTH( 32 ),
    .din221_WIDTH( 32 ),
    .din222_WIDTH( 32 ),
    .din223_WIDTH( 32 ),
    .din224_WIDTH( 32 ),
    .din225_WIDTH( 32 ),
    .din226_WIDTH( 32 ),
    .din227_WIDTH( 32 ),
    .din228_WIDTH( 32 ),
    .din229_WIDTH( 32 ),
    .din230_WIDTH( 32 ),
    .din231_WIDTH( 32 ),
    .din232_WIDTH( 32 ),
    .din233_WIDTH( 32 ),
    .din234_WIDTH( 32 ),
    .din235_WIDTH( 32 ),
    .din236_WIDTH( 32 ),
    .din237_WIDTH( 32 ),
    .din238_WIDTH( 32 ),
    .din239_WIDTH( 32 ),
    .din240_WIDTH( 32 ),
    .din241_WIDTH( 32 ),
    .din242_WIDTH( 32 ),
    .din243_WIDTH( 32 ),
    .din244_WIDTH( 32 ),
    .din245_WIDTH( 32 ),
    .din246_WIDTH( 32 ),
    .din247_WIDTH( 32 ),
    .din248_WIDTH( 32 ),
    .din249_WIDTH( 32 ),
    .din250_WIDTH( 32 ),
    .din251_WIDTH( 32 ),
    .din252_WIDTH( 32 ),
    .din253_WIDTH( 32 ),
    .din254_WIDTH( 32 ),
    .din255_WIDTH( 32 ),
    .din256_WIDTH( 8 ),
    .dout_WIDTH( 32 ))
mux_256_8_32_1_1_U2481(
    .din0(v),
    .din1(v_494),
    .din2(v_495),
    .din3(v_496),
    .din4(v_497),
    .din5(v_498),
    .din6(v_499),
    .din7(v_500),
    .din8(v_501),
    .din9(v_502),
    .din10(v_503),
    .din11(v_504),
    .din12(v_505),
    .din13(v_506),
    .din14(v_507),
    .din15(v_14),
    .din16(v_478),
    .din17(v_479),
    .din18(v_256),
    .din19(v_257),
    .din20(v_258),
    .din21(v_259),
    .din22(v_260),
    .din23(v_261),
    .din24(v_262),
    .din25(v_263),
    .din26(v_264),
    .din27(v_265),
    .din28(v_266),
    .din29(v_267),
    .din30(v_268),
    .din31(v_269),
    .din32(v_270),
    .din33(v_271),
    .din34(v_272),
    .din35(v_273),
    .din36(v_274),
    .din37(v_275),
    .din38(v_276),
    .din39(v_277),
    .din40(v_278),
    .din41(v_279),
    .din42(v_280),
    .din43(v_281),
    .din44(v_282),
    .din45(v_283),
    .din46(v_284),
    .din47(v_285),
    .din48(v_286),
    .din49(v_287),
    .din50(v_288),
    .din51(v_289),
    .din52(v_290),
    .din53(v_291),
    .din54(v_292),
    .din55(v_293),
    .din56(v_294),
    .din57(v_295),
    .din58(v_296),
    .din59(v_297),
    .din60(v_298),
    .din61(v_299),
    .din62(v_300),
    .din63(v_301),
    .din64(v_302),
    .din65(v_303),
    .din66(v_304),
    .din67(v_305),
    .din68(v_306),
    .din69(v_307),
    .din70(v_308),
    .din71(v_309),
    .din72(v_310),
    .din73(v_311),
    .din74(v_312),
    .din75(v_313),
    .din76(v_314),
    .din77(v_315),
    .din78(v_316),
    .din79(v_317),
    .din80(v_318),
    .din81(v_319),
    .din82(v_320),
    .din83(v_321),
    .din84(v_322),
    .din85(v_323),
    .din86(v_324),
    .din87(v_325),
    .din88(v_326),
    .din89(v_327),
    .din90(v_328),
    .din91(v_329),
    .din92(v_330),
    .din93(v_331),
    .din94(v_332),
    .din95(v_333),
    .din96(v_334),
    .din97(v_335),
    .din98(v_336),
    .din99(v_337),
    .din100(v_338),
    .din101(v_339),
    .din102(v_340),
    .din103(v_341),
    .din104(v_342),
    .din105(v_343),
    .din106(v_344),
    .din107(v_345),
    .din108(v_346),
    .din109(v_347),
    .din110(v_348),
    .din111(v_349),
    .din112(v_350),
    .din113(v_351),
    .din114(v_352),
    .din115(v_353),
    .din116(v_354),
    .din117(v_355),
    .din118(v_356),
    .din119(v_357),
    .din120(v_358),
    .din121(v_359),
    .din122(v_360),
    .din123(v_361),
    .din124(v_362),
    .din125(v_363),
    .din126(v_364),
    .din127(v_365),
    .din128(v_366),
    .din129(v_367),
    .din130(v_368),
    .din131(v_369),
    .din132(v_370),
    .din133(v_371),
    .din134(v_372),
    .din135(v_373),
    .din136(v_374),
    .din137(v_375),
    .din138(v_376),
    .din139(v_377),
    .din140(v_378),
    .din141(v_379),
    .din142(v_380),
    .din143(v_381),
    .din144(v_382),
    .din145(v_383),
    .din146(v_384),
    .din147(v_385),
    .din148(v_386),
    .din149(v_387),
    .din150(v_388),
    .din151(v_389),
    .din152(v_390),
    .din153(v_391),
    .din154(v_392),
    .din155(v_393),
    .din156(v_394),
    .din157(v_395),
    .din158(v_396),
    .din159(v_397),
    .din160(v_398),
    .din161(v_399),
    .din162(v_400),
    .din163(v_401),
    .din164(v_402),
    .din165(v_403),
    .din166(v_404),
    .din167(v_405),
    .din168(v_406),
    .din169(v_407),
    .din170(v_408),
    .din171(v_409),
    .din172(v_410),
    .din173(v_411),
    .din174(v_412),
    .din175(v_413),
    .din176(v_414),
    .din177(v_415),
    .din178(v_416),
    .din179(v_417),
    .din180(v_418),
    .din181(v_419),
    .din182(v_420),
    .din183(v_421),
    .din184(v_422),
    .din185(v_423),
    .din186(v_424),
    .din187(v_425),
    .din188(v_426),
    .din189(v_427),
    .din190(v_428),
    .din191(v_429),
    .din192(v_430),
    .din193(v_431),
    .din194(v_432),
    .din195(v_433),
    .din196(v_434),
    .din197(v_435),
    .din198(v_436),
    .din199(v_437),
    .din200(v_438),
    .din201(v_439),
    .din202(v_440),
    .din203(v_441),
    .din204(v_442),
    .din205(v_443),
    .din206(v_444),
    .din207(v_445),
    .din208(v_446),
    .din209(v_447),
    .din210(v_448),
    .din211(v_449),
    .din212(v_450),
    .din213(v_451),
    .din214(v_452),
    .din215(v_453),
    .din216(v_454),
    .din217(v_455),
    .din218(v_456),
    .din219(v_457),
    .din220(v_458),
    .din221(v_459),
    .din222(v_460),
    .din223(v_461),
    .din224(v_462),
    .din225(v_463),
    .din226(v_464),
    .din227(v_465),
    .din228(v_466),
    .din229(v_467),
    .din230(v_468),
    .din231(v_469),
    .din232(v_470),
    .din233(v_471),
    .din234(v_472),
    .din235(v_473),
    .din236(v_474),
    .din237(v_475),
    .din238(v_476),
    .din239(v_477),
    .din240(v_239),
    .din241(v_480),
    .din242(v_481),
    .din243(v_482),
    .din244(v_483),
    .din245(v_484),
    .din246(v_485),
    .din247(v_486),
    .din248(v_487),
    .din249(v_488),
    .din250(v_489),
    .din251(v_490),
    .din252(v_491),
    .din253(v_492),
    .din254(v_493),
    .din255(v_254),
    .din256(tmp_21_fu_2179_p257),
    .dout(tmp_21_fu_2179_p258)
);

kernel_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((exitcond4_fu_2159_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            loop_index_fu_582 <= empty_fu_2165_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            loop_index_fu_582 <= 9'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if ((ap_loop_init == 1'b1)) begin
            shiftreg_fu_578 <= 480'd0;
        end else if ((ap_enable_reg_pp0_iter1 == 1'b1)) begin
            shiftreg_fu_578 <= empty_45_fu_2739_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((exitcond4_fu_2159_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        empty_48_reg_2780 <= empty_48_fu_2697_p2;
        tmp_21_reg_2774 <= tmp_21_fu_2179_p258;
    end
end

always @ (*) begin
    if (((exitcond4_fu_2159_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_loop_index_load = 9'd0;
    end else begin
        ap_sig_allocacmp_loop_index_load = loop_index_fu_582;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (empty_48_reg_2780 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        gmem0_blk_n_W = m_axi_gmem0_WREADY;
    end else begin
        gmem0_blk_n_W = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (empty_48_reg_2780 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        m_axi_gmem0_WVALID = 1'b1;
    end else begin
        m_axi_gmem0_WVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_io));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_io));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_io = ((empty_48_reg_2780 == 1'd1) & (m_axi_gmem0_WREADY == 1'b0));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign empty_45_fu_2739_p3 = ((empty_48_reg_2780[0:0] == 1'b1) ? 480'd0 : tmp_40_fu_2732_p3);

assign empty_46_fu_2171_p1 = ap_sig_allocacmp_loop_index_load[3:0];

assign empty_48_fu_2697_p2 = ((empty_46_fu_2171_p1 == 4'd15) ? 1'b1 : 1'b0);

assign empty_fu_2165_p2 = (ap_sig_allocacmp_loop_index_load + 9'd1);

assign exitcond4_fu_2159_p2 = ((ap_sig_allocacmp_loop_index_load == 9'd256) ? 1'b1 : 1'b0);

assign m_axi_gmem0_ARADDR = 64'd0;

assign m_axi_gmem0_ARBURST = 2'd0;

assign m_axi_gmem0_ARCACHE = 4'd0;

assign m_axi_gmem0_ARID = 1'd0;

assign m_axi_gmem0_ARLEN = 32'd0;

assign m_axi_gmem0_ARLOCK = 2'd0;

assign m_axi_gmem0_ARPROT = 3'd0;

assign m_axi_gmem0_ARQOS = 4'd0;

assign m_axi_gmem0_ARREGION = 4'd0;

assign m_axi_gmem0_ARSIZE = 3'd0;

assign m_axi_gmem0_ARUSER = 1'd0;

assign m_axi_gmem0_ARVALID = 1'b0;

assign m_axi_gmem0_AWADDR = 64'd0;

assign m_axi_gmem0_AWBURST = 2'd0;

assign m_axi_gmem0_AWCACHE = 4'd0;

assign m_axi_gmem0_AWID = 1'd0;

assign m_axi_gmem0_AWLEN = 32'd0;

assign m_axi_gmem0_AWLOCK = 2'd0;

assign m_axi_gmem0_AWPROT = 3'd0;

assign m_axi_gmem0_AWQOS = 4'd0;

assign m_axi_gmem0_AWREGION = 4'd0;

assign m_axi_gmem0_AWSIZE = 3'd0;

assign m_axi_gmem0_AWUSER = 1'd0;

assign m_axi_gmem0_AWVALID = 1'b0;

assign m_axi_gmem0_BREADY = 1'b0;

assign m_axi_gmem0_RREADY = 1'b0;

assign m_axi_gmem0_WDATA = {{tmp_21_reg_2774}, {shiftreg_fu_578}};

assign m_axi_gmem0_WID = 1'd0;

assign m_axi_gmem0_WLAST = 1'b0;

assign m_axi_gmem0_WSTRB = 64'd18446744073709551615;

assign m_axi_gmem0_WUSER = 1'd0;

assign tmp_21_fu_2179_p257 = ap_sig_allocacmp_loop_index_load[7:0];

assign tmp_39_fu_2722_p4 = {{shiftreg_fu_578[479:32]}};

assign tmp_40_fu_2732_p3 = {{tmp_21_reg_2774}, {tmp_39_fu_2722_p4}};

endmodule //kernel_kernel_Pipeline_6
