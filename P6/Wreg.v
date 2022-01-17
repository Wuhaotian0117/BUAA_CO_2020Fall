`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:35:34 12/15/2020 
// Design Name: 
// Module Name:    Wreg 
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
module Wreg(
    input Clk,
    input Reset,
    input [31:0] Instr_M,
    input [4:0] A3M,
    input [31:0] PC_M,
	 
    input [31:0] DMreadM,
	 input [31:0] ALUoutM,
	 
    output reg [31:0] Instr_W,
    output reg [4:0] A3W,
    output reg [31:0] PC_W,
    output reg [31:0] ALUoutW,
	 output reg [31:0] DMreadW
    );
	 
	 always@(posedge Clk) begin
	     if(Reset) begin
		      Instr_W <= 32'b0;
				A3W     <= 5'b0;
				PC_W    <= 32'b0;
				ALUoutW <= 32'b0;
				DMreadW <= 32'b0;
		  end
		  else begin
		      Instr_W <= Instr_M;
				A3W     <= A3M;		
				PC_W    <= PC_M;
				ALUoutW <= ALUoutM;
				DMreadW <= DMreadM;
		  end
	 end


endmodule
