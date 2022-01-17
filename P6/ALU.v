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
    input [3:0] ALUOp,
	 input isvari,
    input [31:0] A,
    input [31:0] B,
	 input [31:0] Instr,
    output reg [31:0] ALUout
    );
	 	 
	 wire [4:0] s;
	 assign s = isvari ? A[4:0] : Instr[10:6];
	 
	 always@(*) begin
	     case(ALUOp)
		      `ADDalu  : ALUout = A + B;
				`SUBalu  : ALUout = A - B;
				`ORalu   : ALUout = A | B;
				`ANDalu  : ALUout = A & B;
				`XORalu  : ALUout = A ^ B;
				`NORalu  : ALUout = ~(A | B);
				`SLTalu  : ALUout = ($signed(A) < $signed(B))? 32'b1 : 32'b0;
				`SLTUalu : ALUout = (A < B)? 32'b1 : 32'b0;
				`SLLalu  : ALUout = B << s;
				`SRLalu  : ALUout = B >> s;
				`SRAalu  : ALUout = $signed(B) >>> s;
				default:  ALUout= 32'bx;
		  endcase
	 end


endmodule
