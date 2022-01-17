`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:30 12/16/2020 
// Design Name: 
// Module Name:    PartW 
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
module PartW(
    input [31:0] Instr_W,
    input [31:0] PC_W,
    input [4:0] A3W,
    input [31:0] ALUoutW,
    input [31:0] DMread,
	 output [4:0] W_RFDst,
	 output RFWr,
    output [31:0] WData,
    output [4:0] A3W2D,
    output [31:0] PC_W2D
    );
	 
	 wire [1:0] M2Sel;
	 wire [2:0] LDOp;
	 
	 wire [4:0] W_Dst;
	 assign W_RFDst = A3W;
	 
	 ControllerW CtrlW_instance(
	 .op(Instr_W[31:26]),
	 .funct(Instr_W[5:0]),
	 .Instr_W(Instr_W),
	 .W_RFDst(W_Dst),
	 .RFWr(RFWr),
	 .M2Sel(M2Sel),
	 .LDOp(LDOp)
	 );
	 
	 wire [31:0] LoadData;
	 Load Load_instance(
	 .DMreadW(DMread),
	 .addr(ALUoutW),
	 .LDOp(LDOp),
	 .LoadData(LoadData)
	 );
	 	 
	 wire [31:0] PCeg;
	 assign PCeg = PC_W + 8;
	 
	 MUX2 MUX2_instance(
	 .ALUout(ALUoutW),
	 .DMread(LoadData),
	 .PCeg(PCeg),
	 .M2Sel(M2Sel),
	 .M2out(WData)
	 );
	 
	 assign PC_W2D = PC_W;
	 assign A3W2D = A3W;

endmodule
