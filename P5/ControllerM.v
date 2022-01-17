`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:53 12/16/2020 
// Design Name: 
// Module Name:    ControllerM 
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
`include "Head.v"
module ControllerM(
    input [5:0] op,
	 input [5:0] funct,
	 input [31:0] Instr_M,
	 output [4:0] M_RFDst,
	 output DMWr,
	 output [1:0] Tnew_M
    );
	 
	 wire addu,subu,ori,lw,sw,beq,lui,j,jal,jr;
	 wire addi;
	 wire jalr;
	 
	 assign addu = (op==`RType)&&(funct==`ADDU);
	 assign subu = (op==`RType)&&(funct==`SUBU);
	 assign addi = (op==`ADDI); /**/
	 assign ori  = (op==`ORI);
	 assign lw   = (op==`LW);
	 assign sw   = (op==`SW);
	 assign beq  = (op==`BEQ);
	 assign lui  = (op==`LUI);
	 assign j    = (op==`J);
	 assign jal  = (op==`JAL);
	 assign jr   = (op==`RType)&&(funct==`JR);
	 assign jalr = (op==`RType)&&(funct==`JALR); /**/
	 
	 assign DMWr = sw;
	 
	 assign M_RFDst = (addu || subu || jalr)? Instr_M[15:11] : 
	                   jal ? 31 :
							 (ori || lui || lw || addi)? Instr_M[20:16] : 5'b0; 
	 
	 assign Tnew_M = lw ? 2'b01 : 2'b00;


endmodule
