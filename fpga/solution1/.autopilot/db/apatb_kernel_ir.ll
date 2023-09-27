; ModuleID = 'C:/Users/Leonardo/Documents/GitHub/MdP-Poisson2DJacobi/fpga/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>" = type { %"struct.ap_fixed_base<32, 5, true, AP_TRN, AP_WRAP, 0>" }
%"struct.ap_fixed_base<32, 5, true, AP_TRN, AP_WRAP, 0>" = type { %"struct.ssdm_int<32, true>" }
%"struct.ssdm_int<32, true>" = type { i32 }

; Function Attrs: inaccessiblemem_or_argmemonly noinline
define void @apatb_kernel_ir(%"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"* noalias nocapture nonnull "maxi" %v_out, i1* noalias nocapture nonnull "maxi" %convFPGA, i32* noalias nocapture nonnull "maxi" %numIter) local_unnamed_addr #0 {
entry:
  %v_out_copy = alloca [256 x i32], align 512
  %convFPGA_copy = alloca [1 x i1], align 512
  %numIter_copy = alloca [1 x i32], align 512
  %0 = bitcast %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"* %v_out to [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]*
  %1 = bitcast i1* %convFPGA to [1 x i1]*
  %2 = bitcast i32* %numIter to [1 x i32]*
  call fastcc void @copy_in([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* nonnull %0, [256 x i32]* nonnull align 512 %v_out_copy, [1 x i1]* nonnull %1, [1 x i1]* nonnull align 512 %convFPGA_copy, [1 x i32]* nonnull %2, [1 x i32]* nonnull align 512 %numIter_copy)
  %3 = getelementptr inbounds [1 x i1], [1 x i1]* %convFPGA_copy, i64 0, i64 0
  %4 = getelementptr inbounds [1 x i32], [1 x i32]* %numIter_copy, i64 0, i64 0
  call void @apatb_kernel_hw([256 x i32]* %v_out_copy, i1* %3, i32* %4)
  call void @copy_back([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %0, [256 x i32]* %v_out_copy, [1 x i1]* %1, [1 x i1]* %convFPGA_copy, [1 x i32]* %2, [1 x i32]* %numIter_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_in([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* noalias readonly "unpacked"="0", [256 x i32]* noalias nocapture align 512 "unpacked"="1.0", [1 x i1]* noalias readonly "unpacked"="2", [1 x i1]* noalias align 512 "unpacked"="3", [1 x i32]* noalias readonly "unpacked"="4", [1 x i32]* noalias align 512 "unpacked"="5") unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"([256 x i32]* align 512 %1, [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %0)
  call fastcc void @onebyonecpy_hls.p0a1i1([1 x i1]* align 512 %3, [1 x i1]* %2)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* align 512 %5, [1 x i32]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @"onebyonecpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"([256 x i32]* noalias nocapture align 512 "unpacked"="0.0" %dst, [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"([256 x i32]* %dst, [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* nonnull %src, i64 256)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @"arraycpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"([256 x i32]* nocapture "unpacked"="0.0" %dst, [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"], [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [256 x i32], [256 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %1, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0a1i1([1 x i1]* noalias align 512 %dst, [1 x i1]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1 x i1]* %dst, null
  %1 = icmp eq [1 x i1]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1i1([1 x i1]* nonnull %dst, [1 x i1]* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @arraycpy_hls.p0a1i1([1 x i1]* %dst, [1 x i1]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1 x i1]* %src, null
  %1 = icmp eq [1 x i1]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [1 x i1], [1 x i1]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [1 x i1], [1 x i1]* %src, i64 0, i64 %for.loop.idx2
  %3 = bitcast i1* %src.addr to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  store i1 %5, i1* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* noalias align 512 %dst, [1 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1 x i32]* %dst, null
  %1 = icmp eq [1 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1i32([1 x i32]* nonnull %dst, [1 x i32]* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @arraycpy_hls.p0a1i32([1 x i32]* %dst, [1 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1 x i32]* %src, null
  %1 = icmp eq [1 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [1 x i32], [1 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [1 x i32], [1 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_out([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* noalias "unpacked"="0", [256 x i32]* noalias nocapture readonly align 512 "unpacked"="1.0", [1 x i1]* noalias "unpacked"="2", [1 x i1]* noalias readonly align 512 "unpacked"="3", [1 x i32]* noalias "unpacked"="4", [1 x i32]* noalias readonly align 512 "unpacked"="5") unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>.28"([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %0, [256 x i32]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0a1i1([1 x i1]* %2, [1 x i1]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* %4, [1 x i32]* align 512 %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @"onebyonecpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>.28"([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* noalias "unpacked"="0" %dst, [256 x i32]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>.31"([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* nonnull %dst, [256 x i32]* %src, i64 256)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @"arraycpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>.31"([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* "unpacked"="0" %dst, [256 x i32]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [256 x i32], [256 x i32]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"], [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %1, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_kernel_hw([256 x i32]*, i1*, i32*)

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_back([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* noalias "unpacked"="0", [256 x i32]* noalias nocapture readonly align 512 "unpacked"="1.0", [1 x i1]* noalias "unpacked"="2", [1 x i1]* noalias readonly align 512 "unpacked"="3", [1 x i32]* noalias "unpacked"="4", [1 x i32]* noalias readonly align 512 "unpacked"="5") unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a256struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>.28"([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %0, [256 x i32]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0a1i1([1 x i1]* %2, [1 x i1]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* %4, [1 x i32]* align 512 %5)
  ret void
}

define void @kernel_hw_stub_wrapper([256 x i32]*, i1*, i32*) #5 {
entry:
  %3 = alloca [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]
  %4 = bitcast i1* %1 to [1 x i1]*
  %5 = bitcast i32* %2 to [1 x i32]*
  call void @copy_out([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %3, [256 x i32]* %0, [1 x i1]* null, [1 x i1]* %4, [1 x i32]* null, [1 x i32]* %5)
  %6 = bitcast [256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %3 to %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"*
  %7 = bitcast [1 x i1]* %4 to i1*
  %8 = bitcast [1 x i32]* %5 to i32*
  call void @kernel_hw_stub(%"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"* %6, i1* %7, i32* %8)
  call void @copy_in([256 x %"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"]* %3, [256 x i32]* %0, [1 x i1]* null, [1 x i1]* %4, [1 x i32]* null, [1 x i32]* %5)
  ret void
}

declare void @kernel_hw_stub(%"struct.ap_fixed<32, 5, AP_TRN, AP_WRAP, 0>"*, i1*, i32*)

attributes #0 = { inaccessiblemem_or_argmemonly noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
