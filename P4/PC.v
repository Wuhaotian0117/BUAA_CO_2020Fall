`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:20:54 12/01/2020 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input Clk,
    input Reset,
    input [31:0] NPC,
    output reg [31:0] PC
    );
	 
	 always@(posedge Clk) begin   //Í¬²½¸´Î»
	     if(Reset) begin
		      PC <= 32'h0000_3000;
		  end
		  else begin
		      PC <= NPC;
		  end
	 end


endmodule
