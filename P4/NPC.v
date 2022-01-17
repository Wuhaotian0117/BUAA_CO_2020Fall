`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:55 12/01/2020 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC,
    input [2:0] NPCOp,
    input [31:0] Instr,
    input [31:0] RA,
    input zero,
    output reg [31:0] NPC,
    output [31:0] PC4
    );
	 
	 parameter PC_4 = 3'b000,
	           BEQ  = 3'b001,
				  JAL  = 3'b010,
				  JR   = 3'b011;
				  
	 always@(*) begin
	     case(NPCOp)
		      PC_4 : NPC = PC + 4;
				BEQ  : NPC = (zero==1)? PC + 4 + {{14{Instr[15]}},Instr[15:0],2'b00} : PC + 4;
				JAL  : NPC = {PC[31:28],Instr[25:0],2'b00};
				JR   : NPC = RA;	      //¼Ä´æÆ÷ÖÐµØÖ·
		  endcase
	 end
	 
    assign PC4 = PC + 4;
endmodule
