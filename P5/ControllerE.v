`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:22 12/16/2020 
// Design Name: 
// Module Name:    ControllerE 
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
module ControllerE(
    input [5:0] op,
    input [5:0] funct,
	 input [31:0] Instr_E,
	 output isjal,
    output [2:0] ALUOp,
    output M3Sel,
	 output [1:0] Tnew_E,
	 output [4:0] E_RFDst
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
	 assign jalr = (op==`RType)&&(funct==`JALR);
	 
	 assign M3Sel = ori || lw || sw || lui || addi;
	 
    assign ALUOp = subu ? 3'b001 : 
	                ori ? 3'b010 : 
                   3'b000;
						 
    assign isjal = jal || jalr;
							 
    assign E_RFDst = (addu || subu || jalr)? Instr_E[15:11] : 
	                   jal ? 31 :
							 (ori || lw || lui || addi)? Instr_E[20:16] : 5'b0;
							 
    assign Tnew_E = (addu || subu || ori || jal || lui || addi || jalr)? 2'b01 : 
                     lw ? 2'b10 : 
                     2'b00;							
                  						
endmodule
