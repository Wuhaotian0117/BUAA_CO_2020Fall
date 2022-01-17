`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:36 12/15/2020 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input Clk,
    input Reset,
    input RFWr,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WData,
    input [31:0] WPC,
    output [31:0] RD1,
    output [31:0] RD2
    );
	 
	 reg [31:0] GRFreg [0:31];
	 
	 integer i;
	 always@(posedge Clk) begin
	 
	     if(Reset) begin
		      for(i = 0; i <= 31; i = i + 1)
				GRFreg[i] <= 32'b0;
		  end
		  else if(RFWr && (A3!=5'b0)) begin
		      GRFreg[A3] <= WData;
				$display("%d@%h: $%d <= %h", $time, WPC,A3,WData);
		  end
	 end
	 
	 assign RD1 = (A3==A1&&A3!=0&&RFWr)? WData : GRFreg[A1];
	 assign RD2 = (A3==A2&&A3!=0&&RFWr)? WData : GRFreg[A2];


endmodule
