`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:46:56 12/01/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [2:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] C,
    output zero
    );
	 
	 parameter ADD = 3'b000,
	           SUB = 3'b001,
				  OR =  3'b010,
				  SLT = 3'b011;
	
	 always@(*) begin
	     case(ALUOp)
		      ADD : C = A + B;
				SUB : C = A - B;
				OR  : C = A | B;
				SLT : C = (A < B)? 32'b1 : 32'b0;
				default: C = 32'bx;
		  endcase
	 end
	 
	 assign zero = (A==B)? 1'b1 : 1'b0;
	 
	 /*assign C = (ALUOp==ADD)? A + B :
	            (ALUOp==SUB)? A - B :
					(ALIOp==OR)?  A | B :
					                     32'b0;*/


endmodule
