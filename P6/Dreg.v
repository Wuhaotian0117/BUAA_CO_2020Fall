`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:15 12/15/2020 
// Design Name: 
// Module Name:    Dreg 
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
module Dreg(
    input Clk,
    input Reset,
    input DregEn,
    input [31:0] Instr_F,
    input [31:0] PC_F,
	 input [31:0] PC4F,
    output reg [31:0] Instr_D,
    output reg [31:0] PC_D,
	 output reg [31:0] PC4D
    );
	 
	 always@(posedge Clk) begin
	     if(Reset) begin
		      Instr_D <= 32'b0;
				PC_D <= 32'b0;
				PC4D <= 32'b0;
		  end
		  else if(DregEn) begin
		      Instr_D <= Instr_F;
				PC_D <= PC_F;
				PC4D <= PC4F;
		  end
	 end


endmodule
