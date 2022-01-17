`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:38 12/16/2020 
// Design Name: 
// Module Name:    PartM 
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
module PartM(
    input Clk,
    input Reset,
    input [31:0] Instr_M,
    input [31:0] PC_M,
    input [4:0] A3M,
    input [31:0] ALUoutM,
    input [31:0] RD2M,
    input [31:0] FWD_M,
	 
	 output [4:0] M_rt_addr,
	 output [4:0] M_RFDst,
	 output [1:0] Tnew_M,
	 
    output [31:0] Instr_M2W,
    output [31:0] PC_M2W,
    output [4:0] A3M2W,
    output [31:0] DMread,
    output [31:0] ALUoutM2W
    );
	 
	 assign M_rt_addr = Instr_M[20:16];
	 
	 wire DMWr;
	 ControllerM CtrlM_instance(
	 .op(Instr_M[31:26]),
	 .funct(Instr_M[5:0]),
	 .Instr_M(Instr_M),
	 .M_RFDst(M_RFDst),
	 .DMWr(DMWr),
	 .Tnew_M(Tnew_M)
	 );
	 
	 DM DMinstance(
	 .Clk(Clk),
	 .Reset(Reset),
	 .addr(ALUoutM),
	 .WPC(PC_M),
	 .DMWr(DMWr),
	 .MemWrite(FWD_M),
	 .MemRead(DMread)
	 );
	 
	 assign Instr_M2W = Instr_M;
	 assign PC_M2W = PC_M;
	 assign A3M2W = A3M;
	 assign ALUoutM2W = ALUoutM;


endmodule
