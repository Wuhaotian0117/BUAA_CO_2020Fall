`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:31 12/15/2020 
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
`include "Head.v"
module ALU(
    input [2:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] ALUout
    );
	 
	 parameter ADD = 3'b000,
	           SUB = 3'b001,
				  OR =  3'b010;
	 
	 always@(*) begin
	     case(ALUOp)
		      ADD : ALUout = A + B;
				SUB : ALUout = A - B;
				OR  : ALUout = A | B;
				default:  ALUout= 32'bx;
		  endcase
	 end


endmodule
