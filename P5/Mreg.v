`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:55 12/15/2020 
// Design Name: 
// Module Name:    Mreg 
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
module Mreg(
    input Clk,
    input Reset,
    input [31:0] Instr_E,
    input [4:0] A3E,
    input [31:0] PC_E,
	 
	 input [31:0] ALUoutE,
	 input [31:0] RD2E,
	 
    output reg [31:0] Instr_M,
    output reg [4:0] A3M,
    output reg [31:0] PC_M,
    output reg [31:0] ALUoutM,
	 output reg [31:0] RD2M
    );
	 
	 always@(posedge Clk) begin
	     if(Reset) begin
		      Instr_M <= 32'b0;
				A3M     <= 5'b0;
				PC_M    <= 32'b0;
				ALUoutM <= 32'b0;
				RD2M    <= 32'b0;
		  end
		  else begin
		      Instr_M <= Instr_E;
				A3M     <= A3E;
				PC_M    <= PC_E;
				ALUoutM <= ALUoutE;
				RD2M    <= RD2E;		   
		  end
	 end


endmodule
