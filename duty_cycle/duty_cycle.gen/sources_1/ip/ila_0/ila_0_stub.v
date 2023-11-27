// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Mon Aug 14 16:41:58 2023
// Host        : NIKHIL_TYAGI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/tyagi/xiling demo MTP/single_loop_pi
//               controller_dutycycle/duty_cycle/duty_cycle.gen/sources_1/ip/ila_0/ila_0_stub.v}
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2023.1" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6)
/* synthesis syn_black_box black_box_pad_pin="probe0[0:0],probe1[15:0],probe2[9:0],probe3[18:0],probe4[0:0],probe5[0:0],probe6[9:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input clk /* synthesis syn_isclock = 1 */;
  input [0:0]probe0;
  input [15:0]probe1;
  input [9:0]probe2;
  input [18:0]probe3;
  input [0:0]probe4;
  input [0:0]probe5;
  input [9:0]probe6;
endmodule
