`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:22 12/16/2020 
// Design Name: 
// Module Name:    ControllerW 
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
module ControllerW(
    input [5:0] op,
    input [5:0] funct,
	 input [31:0] Instr_W,
	 output [4:0] W_RFDst,
    output RFWr,
	 output [1:0] M2Sel
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
	 
	 assign RFWr = addu || subu || ori || lw || lui || jal || addi || jalr;
	
	 assign M2Sel = lw  ? 2'b01 :
	                (jal || jalr) ? 2'b10 :
						 2'b00;
    
	 assign W_RFDst = (addu || subu || jalr)? Instr_W[15:11] : 
	                   jal ? 31 :
							 (ori || lui || lw || addi)? Instr_W[20:16] : 5'b0; 

endmodule
