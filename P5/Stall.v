`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:24 12/17/2020 
// Design Name: 
// Module Name:    Stall 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Stall(
    input [1:0] Tuse_rs,
    input [1:0] Tuse_rt,
    input [1:0] Tnew_E,
    input [1:0] Tnew_M,
    input [4:0] D_rs_addr,
    input [4:0] D_rt_addr,
	 input [4:0] E_RFDst,
    input [4:0] M_RFDst,
    output stall
    );
	 
	 wire stall_rs_e,stall_rs_m;
	 wire stall_rt_e,stall_rt_m;
	 wire stall_rs,stall_rt;
	 
	 assign stall_rs_e = (Tuse_rs < Tnew_E) && (D_rs_addr!=0 && D_rs_addr==E_RFDst);
	 assign stall_rs_m = (Tuse_rs < Tnew_M) && (D_rs_addr!=0 && D_rs_addr==M_RFDst);
	 
	 assign stall_rt_e = (Tuse_rt < Tnew_E) && (D_rt_addr!=0 && D_rt_addr==E_RFDst);
	 assign stall_rt_m = (Tuse_rt < Tnew_M) && (D_rt_addr!=0 && D_rt_addr==M_RFDst);

    assign stall_rs = stall_rs_e || stall_rs_m;
	 assign stall_rt = stall_rt_e || stall_rt_m;
	 
	 assign stall = stall_rs || stall_rt;

endmodule
