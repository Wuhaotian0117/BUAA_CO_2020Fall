`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:02 12/15/2020 
// Design Name: 
// Module Name:    Ereg 
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
module Ereg(
    input Clk,
    input Reset,
    input EClr,
    input [31:0] Instr_D,
	 input [31:0] PC_D,
	 input [4:0] A3D,
    input [31:0] EXToutD,
	 input [31:0] RD1D,
    input [31:0] RD2D,
    output reg [31:0] Instr_E,
	 output reg [31:0] PC_E,
	 output reg [4:0] A3E,
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [31:0] EXToutE
    );
	 
	 always@(posedge Clk) begin
	     if(Reset || EClr) begin
		      Instr_E <= 32'b0;
				RD1E    <= 32'b0;
				RD2E    <= 32'b0;
				A3E     <= 5'b0;
				EXToutE <= 32'b0;
				PC_E    <= 32'b0;
		  end
		  else begin
		      Instr_E <= Instr_D;
				RD1E    <= RD1D;
				RD2E    <= RD2D;
				A3E     <= A3D;
				EXToutE <= EXToutD;
				PC_E    <= PC_D;
		  end
	 end


endmodule
