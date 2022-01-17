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
	 
    output [31:0] ALUoutE,
    output [31:0] RD2E2M,
    output [31:0] Instr_E2M,
    output [31:0] PC_E2M,
    output [4:0] A3E2M
    );
	 
	 /*当前位点读取地址*/
	 assign E_rs_addr = Instr_E[25:21];
	 assign E_rt_addr = Instr_E[20:16];
	 
	 wire [2:0] ALUOp;
	 wire M3Sel;
	 wire isjal;
	 
	 ControllerE CtrlE_instance(
	 .op(Instr_E[31:26]),
	 .funct(Instr_E[5:0]),
	 .Instr_E(Instr_E),
	 .isjal(isjal),
	 .ALUOp(ALUOp),
	 .M3Sel(M3Sel),
	 .Tnew_E(Tnew_E),
	 .E_RFDst(E_RFDst)
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
	 .A(FWD_E1),
	 .B(M3out),
	 .ALUout(ALUout)
	 );

    assign RD2E2M = FWD_E2;
	 assign Instr_E2M = Instr_E;
	 assign PC_E2M = PC_E;
	 assign A3E2M = A3E;
	 
	 /*此处将jal的pc+8也走alu结果的通道*/
	 assign ALUoutE = isjal ? (PC_E + 8) : ALUout;

endmodule
