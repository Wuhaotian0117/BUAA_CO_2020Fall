`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:48:32 12/17/2020 
// Design Name: 
// Module Name:    ForwardUnit 
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
module ForwardUnit(
    input [4:0] D_rs_addr,
    input [4:0] D_rt_addr,
    input [4:0] E_rs_addr,
    input [4:0] E_rt_addr,
    input [4:0] M_rt_addr,
    input [4:0] M_RFDst,
	 input [4:0] W_RFDst,
	 input [31:0] D_rs,
	 input [31:0] D_rt,
	 input [31:0] E_rs,
	 input [31:0] E_rt,
	 input [31:0] M_rt,
    input [31:0] WDM,
	 input [31:0] WDW,
    output [31:0] FWD_D1,
    output [31:0] FWD_D2,
    output [31:0] FWD_E1,
    output [31:0] FWD_E2,
    output [31:0] FWD_M
    );
	 
	 assign FWD_D1 = (D_rs_addr==5'b0)? 0 : 
                    (D_rs_addr==M_RFDst)? WDM : 
						  D_rs;
						  
	 assign FWD_D2 = (D_rt_addr==5'b0)? 0 : 
	                 (D_rt_addr==M_RFDst)? WDM :
						  D_rt;
						  
	 assign FWD_E1 = (E_rs_addr==5'b0)? 0 :
	                 (E_rs_addr==M_RFDst)? WDM :
						  (E_rs_addr==W_RFDst)? WDW :
						  E_rs;
						  
	 assign FWD_E2 = (E_rt_addr==5'b0)? 0 :
	                 (E_rt_addr==M_RFDst)? WDM :
						  (E_rt_addr==W_RFDst)? WDW :
						  E_rt;
						  
	 assign FWD_M = (M_rt_addr==5'b0)? 0 :
	                (M_rt_addr==W_RFDst)? WDW : 
						 M_rt;
                    						  
	 
endmodule
