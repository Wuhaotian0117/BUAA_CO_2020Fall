`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:46:58 12/15/2020 
// Design Name: 
// Module Name:    PartD 
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
module PartD(
    input Clk,
    input Reset,
	 input RFWr,
    input [31:0] Instr_D,
    input [31:0] PC_D,
	 input [31:0] PC4D,
	 
    input [31:0] FWD_D1,
    input [31:0] FWD_D2,
	 input [31:0] PC_W,
    input [4:0] A3W,
    input [31:0] WData,

	 output [31:0] Instr_D2E,
	 output [31:0] PC_D2E,
	 output [4:0] A3D2E,
    output [31:0] EXToutD,
    output [31:0] RD1D,
    output [31:0] RD2D,	 
	 output [31:0] NPC,
	 
	 output [4:0] D_rs_addr,
	 output [4:0] D_rt_addr,
	 
	 output [1:0] Tuse_rs,
	 output [1:0] Tuse_rt,
	 output isjump,
	 output ismuldiv
    );
	 
	 assign D_rs_addr = Instr_D[25:21];
	 assign D_rt_addr = Instr_D[20:16];
	 
	 wire [1:0] EXTOp;
	 wire [2:0] NPCOp;
	 wire [1:0] M1Sel;
	 wire zero;
	 wire isge;
	 wire isgreat;
	 
	 ControllerD CtrlD_instance(
	 .op(Instr_D[31:26]),
	 .funct(Instr_D[5:0]),
	 .Instr_D(Instr_D),
	 .zero(zero),
	 .isge(isge),
	 .isgreat(isgreat),
	 
	 .EXTOp(EXTOp),
	 .NPCOp(NPCOp),
	 .M1Sel(M1Sel),
	 .Tuse_rs(Tuse_rs),
	 .Tuse_rt(Tuse_rt),
	 .isjump(isjump),
	 .ismuldiv(ismuldiv)
	 );
	 
	 CMP CMP_instance(
	 .A(FWD_D1),
	 .B(FWD_D2),
	 .zero(zero),
	 .isge(isge),
	 .isgreat(isgreat)
	 );
	 	 
	 wire [4:0] A1,A2;
	 assign A1 = Instr_D[25:21];
	 assign A2 = Instr_D[20:16];
	 
	 assign Instr_D2E = Instr_D;
	 assign PC_D2E = PC_D;
	 
	 MUX1 MUX1_instance(
	 .rt(Instr_D[20:16]),
	 .rd(Instr_D[15:11]),
	 .M1Sel(M1Sel),
	 .M1out(A3D2E)
	 );
	 
    GRF GRF_instance(
	 .Clk(Clk),
	 .Reset(Reset),
	 .RFWr(RFWr),
	 .A1(A1),
	 .A2(A2),
	 .A3(A3W),
	 .WData(WData),
	 .WPC(PC_W),
	 .RD1(RD1D),
	 .RD2(RD2D)
	 );
	 
	 
	 EXT EXT_instance(
	 .EXTOp(EXTOp),
	 .imm(Instr_D[15:0]),
	 .EXTout(EXToutD)
	 );
	 
	 
	 NPC NPC_instance(
	 .PC(PC4D),
	 .NPCOp(NPCOp),
	 .Instr(Instr_D),
	 .RA(FWD_D1),
	 .NPC(NPC)
	 );

endmodule
