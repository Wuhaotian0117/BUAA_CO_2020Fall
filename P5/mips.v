`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:17:56 12/15/2020 
// Design Name: 
// Module Name:    mips 
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
`default_nettype none
module mips(
    input wire clk,
    input wire reset
    );
	 
	 wire [31:0] PC,Instr_F;
	 wire [31:0] PCin,Npcout;
	 wire [31:0] PC4F;
	 wire isjump;
	 
	 assign PCin = isjump? Npcout : (PC+4);
	 assign PC4F = PC + 4;
	 
	 PC PCinstance(
	 .Clk(clk),
	 .Reset(reset),
	 .NPC(PCin),
	 .PCEn(PCEn),
	 .PC(PC)
	 );
	 
	 IM IMinstance(
	 .addr(PC),
	 .Instr(Instr_F)
	 );
	 
	 wire [4:0] D_rs_addr,D_rt_addr;
	 wire [4:0] E_rs_addr,E_rt_addr;
    wire [4:0] M_rt_addr;
	 wire [4:0] E_RFDst;
    wire [4:0] M_RFDst;
	 wire [4:0] W_RFDst;
	 wire [31:0] FWD_D1,FWD_D2;
	 wire [31:0] FWD_E1,FWD_E2;
	 wire [31:0] FWD_M;
	 
	 ForwardUnit FWDinstance(
	 .D_rs_addr(D_rs_addr),
	 .D_rt_addr(D_rt_addr),
	 .E_rs_addr(E_rs_addr),
	 .E_rt_addr(E_rt_addr),
	 .M_rt_addr(M_rt_addr),
	 .M_RFDst(M_RFDst),
	 .W_RFDst(W_RFDst),
	 .D_rs(RD1D2E),
	 .D_rt(RD2D2E),
	 .E_rs(RD1E),
	 .E_rt(RD2E),
	 .M_rt(RD2M),
	 .WDM(ALUoutM),
	 .WDW(WData),
	 .FWD_D1(FWD_D1),
	 .FWD_D2(FWD_D2),
	 .FWD_E1(FWD_E1),
	 .FWD_E2(FWD_E2),
	 .FWD_M(FWD_M)
	 );
	 
	 wire [1:0] Tuse_rs,Tuse_rt;
	 wire [1:0] Tnew_E;
	 wire [1:0] Tnew_M;
	 wire stall;
	 
	 Stall stall_Unit(
	 .Tuse_rs(Tuse_rs),
	 .Tuse_rt(Tuse_rt),
	 .Tnew_E(Tnew_E),
	 .Tnew_M(Tnew_M),
	 .D_rs_addr(D_rs_addr),
	 .D_rt_addr(D_rt_addr),
	 .E_RFDst(E_RFDst),
	 .M_RFDst(M_RFDst),
	 .stall(stall)
	 );
	 
	 wire PCEn,DregEn,EClr;
	 assign PCEn = ~stall;
	 assign DregEn = ~stall;
	 assign EClr = stall;
	  	 
	 /*D 级寄存器及模块*/
	 wire [31:0] Instr_D,PC_D;
	 wire [31:0] PC4D;
	 
	 Dreg Dreg_instance(
	 .Clk(clk),
	 .Reset(reset),
	 .DregEn(DregEn), /**/
	 .Instr_F(Instr_F),
	 .PC_F(PC),
	 .PC4F(PC4F),
	 .Instr_D(Instr_D),
	 .PC_D(PC_D),
	 .PC4D(PC4D)
	 );
	 
	 wire [31:0] Instr_D2E;
	 wire [31:0] PC_D2E;
	 wire [4:0] A3D2E; 	 
	 wire [31:0] RD1D2E,RD2D2E;
	 wire [31:0] EXToutD2E;
	 
	 PartD PartD_instance(
	 .Clk(clk),
	 .Reset(reset),
	 .RFWr(RFWr),  /**/
	 .Instr_D(Instr_D),
	 .PC_D(PC_D),
	 .PC4D(PC4D),
	 
	 .FWD_D1(FWD_D1),  /**/
	 .FWD_D2(FWD_D2),  /**/
	 .PC_W(PC_W2D),
	 .A3W(A3W2D),
	 .WData(WData),
	 .zero(zero),
	 .Instr_D2E(Instr_D2E),
	 .PC_D2E(PC_D2E),
	 .A3D2E(A3D2E),
	 .EXToutD(EXToutD2E),
	 .RD1D(RD1D2E),
	 .RD2D(RD2D2E),
	 .NPC(Npcout),
	 .D_rs_addr(D_rs_addr),
	 .D_rt_addr(D_rt_addr),
	 .Tuse_rs(Tuse_rs),
	 .Tuse_rt(Tuse_rt),
	 .isjump(isjump)
	 );
	 
	 wire zero;
	 CMP CMPinstance(
	 .A(FWD_D1),
	 .B(FWD_D2),
	 .zero(zero)
	 );
	 
	 /*E 级寄存器及模块*/
	 wire [31:0] Instr_E,PC_E;
	 wire [4:0] A3E;
	 wire [31:0] RD1E,RD2E;
	 wire [31:0] EXToutE;
	 
	 Ereg Ereg_instance(
	 .Clk(clk),
	 .Reset(reset),
	 .EClr(EClr),  /**/
	 .Instr_D(Instr_D2E),
	 .PC_D(PC_D2E),
	 .A3D(A3D2E),
	 .EXToutD(EXToutD2E),
	 .RD1D(FWD_D1),
	 .RD2D(FWD_D2),
	 .Instr_E(Instr_E),
	 .PC_E(PC_E),
	 .A3E(A3E), 
	 .RD1E(RD1E),
	 .RD2E(RD2E), 
	 .EXToutE(EXToutE)	 	 
	 );
	 
	 wire [31:0] ALUoutE2M;
	 wire [31:0] Instr_E2M,PC_E2M;
	 wire [4:0] A3E2M;
	 wire [31:0] RD2E2M;
	 
	 PartE PartE_instance(
	 .Instr_E(Instr_E),
	 .PC_E(PC_E),
	 .A3E(A3E),
	 .EXToutE(EXToutE),
	 .FWD_E1(FWD_E1), /**/
	 .FWD_E2(FWD_E2), /**/
	 
	 .E_rs_addr(E_rs_addr),
	 .E_rt_addr(E_rt_addr),
	 .E_RFDst(E_RFDst),
	 .Tnew_E(Tnew_E),  /*  */
	 
	 .ALUoutE(ALUoutE2M),
	 .RD2E2M(RD2E2M),
	 .Instr_E2M(Instr_E2M),
	 .PC_E2M(PC_E2M),
	 .A3E2M(A3E2M)
	 );
	 
	 
	 /*M 级寄存器及模块*/
	 wire [31:0] Instr_M,PC_M;
	 wire [4:0] A3M;
	 wire [31:0] RD2M;
	 wire [31:0] ALUoutM;
	 
	 Mreg Mreg_instance(
	 .Clk(clk),
	 .Reset(reset),
	 .Instr_E(Instr_E2M),
	 .A3E(A3E2M),
	 .PC_E(PC_E2M),
	 
	 .ALUoutE(ALUoutE2M),
	 .RD2E(RD2E2M),
	 .Instr_M(Instr_M),
	 .A3M(A3M),
	 .PC_M(PC_M),
	 .ALUoutM(ALUoutM),
	 .RD2M(RD2M)
	 );
	 
	 wire [31:0] Instr_M2W,PC_M2W;
	 wire [4:0] A3M2W;
	 wire [31:0] ALUoutM2W;
	 wire [31:0] DMreadM2W;
	 
	 PartM PartM_instance(
	 .Clk(clk),
	 .Reset(reset),
	 .Instr_M(Instr_M),
	 .PC_M(PC_M),
	 .A3M(A3M),
	 .ALUoutM(ALUoutM),
	 .RD2M(RD2M),
	 .FWD_M(FWD_M), /**/
	 
	 .M_rt_addr(M_rt_addr),
	 .M_RFDst(M_RFDst),
	 .Tnew_M(Tnew_M),
	 
	 .Instr_M2W(Instr_M2W),
	 .PC_M2W(PC_M2W),
	 .A3M2W(A3M2W),
	 .DMread(DMreadM2W),
	 .ALUoutM2W(ALUoutM2W)
	 );
	 
	  
	 /*W 级寄存器及模块*/
	 wire [31:0] Instr_W,PC_W;
	 wire [4:0] A3W;
	 wire [31:0] ALUoutW,DMreadW;
	 
	 Wreg Wreg_instance(
	 .Clk(clk),
	 .Reset(reset),
	 .Instr_M(Instr_M2W),
	 .A3M(A3M2W),
	 .PC_M(PC_M2W),
	 
	 .ALUoutM(ALUoutM2W),
	 .DMreadM(DMreadM2W),
	 
	 .Instr_W(Instr_W),	 
	 .A3W(A3W),
	 .PC_W(PC_W),
	 .ALUoutW(ALUoutW),
	 .DMreadW(DMreadW)
	 );
	 
	 wire RFWr;
	 wire [31:0] WData;
	 wire [4:0] A3W2D;
	 wire [31:0] PC_W2D;
	 
	 PartW PartW_instance(
	 .Instr_W(Instr_W),
	 .PC_W(PC_W),
	 .A3W(A3W),
	 .ALUoutW(ALUoutW),
	 .DMread(DMreadW),
	 .W_RFDst(W_RFDst),
	 .RFWr(RFWr),
	 .WData(WData),
	 .A3W2D(A3W2D),
	 .PC_W2D(PC_W2D)
	 );
	 
	 
endmodule
