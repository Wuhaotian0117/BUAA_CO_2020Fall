`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:37 12/16/2020 
// Design Name: 
// Module Name:    PartE 
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
module PartE(
    input Clk,
	 input Reset,
    input [31:0] Instr_E,
    input [31:0] PC_E,
    input [4:0] A3E,
    input [31:0] EXToutE,
	 input [31:0] FWD_E1,
	 input [31:0] FWD_E2,
	 
	 output [4:0] E_rs_addr,
	 output [4:0] E_rt_addr,
	 output [4:0] E_RFDst,
	 output [1:0] Tnew_E,
	 output start,
	 output busy,
	 
    output [31:0] ALUoutE,
    output [31:0] RD2E2M,
    output [31:0] Instr_E2M,
    output [31:0] PC_E2M,
    output [4:0] A3E2M
    );
	 
	 /*当前位点读取地址*/
	 assign E_rs_addr = Instr_E[25:21];
	 assign E_rt_addr = Instr_E[20:16];
	 
	 wire [3:0] ALUOp;
	 wire M3Sel;
	 wire isjal;
	 wire isvari;
	 wire [2:0] MDop;
	 wire [1:0] ismd;
	 
	 wire [4:0] E_Dst;
	 assign E_RFDst = A3E;
	 
	 ControllerE CtrlE_instance(
	 .op(Instr_E[31:26]),
	 .funct(Instr_E[5:0]),
	 .Instr_E(Instr_E),
	 .isjal(isjal),
	 .isvari(isvari),
	 .ismd(ismd),
	 .ALUOp(ALUOp),
	 .M3Sel(M3Sel),
	 .MDop(MDop),
	 .Tnew_E(Tnew_E),
	 .E_RFDst(E_Dst)
	 );
	 
	 wire [31:0] M3out;
	 /*vaule of grf or ext32imm*/
	 MUX3 MUX3instance(
	 .grf(FWD_E2),
	 .EXTout(EXToutE),
	 .M3Sel(M3Sel),
	 .M3out(M3out)
	 );
	 
	 wire [31:0] ALUout;
	  
	 /*ALU*/
	 ALU ALUinstance(
	 .ALUOp(ALUOp),
	 .isvari(isvari),
	 .A(FWD_E1),
	 .B(M3out),
	 .Instr(Instr_E),
	 .ALUout(ALUout)
	 );
    
	 //MD unit
	 wire [31:0] HIE,LOE;
	 
	 MD_Unit MD_instance(
	 .Clk(Clk),
	 .Reset(Reset),
	 .D1(FWD_E1),
	 .D2(FWD_E2),
	 .MDop(MDop),
	 .start(start),
	 .busy(busy),
	 .HIE(HIE),
	 .LOE(LOE)
	 );
	 
    assign RD2E2M = FWD_E2;
	 assign Instr_E2M = Instr_E;
	 assign PC_E2M = PC_E;
	 assign A3E2M = A3E;
	 
	 /*此处将jal的pc+8也走alu结果的通道*/
	 /*此处将hi和lo和读取结果也走alu计算通道*/
	 assign ALUoutE = isjal ? (PC_E + 8) : 
	                  (ismd==2'b01)? HIE : 
							(ismd==2'b10)? LOE :
							ALUout;

endmodule
