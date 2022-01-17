`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:48:11 12/01/2020 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] op,
    input [5:0] funct,
    output [2:0] NPCOp,
    output [1:0] M1Sel,
    output [1:0] M2Sel,
    output M3Sel,
    output RFWr,
    output [1:0] EXTOp,
    output [2:0] ALUOp,
    output DMWr
    );
	 
	 wire addu,subu,ori,lw,sw,lui,sltu;
	 wire beq,jal,jr;
	 
	 parameter RType = 6'b000000;
	 parameter ADDU  = 6'b100001,
	           SUBU  = 6'b100011,
				  ORI   = 6'b001101,
				  LW    = 6'b100011,
				  SW    = 6'b101011,
				  BEQ   = 6'b000100,
				  LUI   = 6'b001111,
				  JAL   = 6'b000011,
				  JR    = 6'b001000,
				  SLTU  = 6'b101011;
				  
				  
	 assign addu = (op==RType)&&(funct==ADDU);
	 assign subu = (op==RType)&&(funct==SUBU);
	 assign ori  = (op==ORI);
	 assign lw   = (op==LW);
	 assign sw   = (op==SW);
	 assign beq  = (op==BEQ);
	 assign lui  = (op==LUI);
	 assign jal  = (op==JAL);
	 assign jr   = (op==RType)&&(funct==JR);
	 assign sltu = (op==RType)&&(funct==SLTU);
	 
	 assign NPCOp = beq ? 3'b001 : 
	                jal ? 3'b010 :
						 jr  ? 3'b011 : 
						                   3'b000;
	
	 assign M1Sel = jal ? 2'b10 :
	                (addu||subu||sltu) ? 2'b01 :
						 2'b00;
						 
	 assign M2Sel = lw  ? 2'b01 :
	                jal ? 2'b10 :
						 2'b00;
						 
	 assign M3Sel = ori || lw || sw || lui;
	 
	 assign RFWr = addu || subu || ori || lw || lui || jal || sltu;
	 
    assign EXTOp = ori ? 2'b01 :
                   lui ? 2'b10 :
                   2'b00;
						 
    assign ALUOp = subu ? 3'b001 : 
	                ori ? 3'b010 : 
						 sltu ? 3'b011 :
                   3'b000;
						 
	 assign DMWr = sw;

endmodule
