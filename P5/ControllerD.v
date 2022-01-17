`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:52:03 12/15/2020 
// Design Name: 
// Module Name:    ControllerD 
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
module ControllerD(
    input [5:0] op,
    input [5:0] funct,
	 input [31:0] Instr_D,
	 input zero,
	 
    output [1:0] EXTOp,
    output [2:0] NPCOp,
	 output [1:0] M1Sel,
    output [1:0] Tuse_rs,
    output [1:0] Tuse_rt,
	 output isjump
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

    assign EXTOp = ori ? 2'b01 :
                   lui ? 2'b10 :
                   2'b00; 
	 
    assign NPCOp = beq ? 3'b001 : 
	                (jal || j) ? 3'b010 :
						 (jr || jalr)  ? 3'b011 : 
						 3'b000;
	 
    assign M1Sel = jal ? 2'b10 :
	                (addu || subu || jalr) ? 2'b01 :
						 2'b00; 
	 
	 assign Tuse_rs = (beq || jr || jalr)? 2'b00 : 
	                  (addu || subu || ori || lw || sw || addi)? 2'b01 : 
	                  2'b11;
							
	 assign Tuse_rt = (beq)? 2'b00 : 
	                  (addu || subu)? 2'b01 : 
	                  (sw)? 2'b10 : 
							2'b11;
    
	 assign isjump = (beq&&zero) || j || jal || jr || jalr;
	 
endmodule
