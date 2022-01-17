`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:08 12/15/2020 
// Design Name: 
// Module Name:    MUX2 
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
module MUX2(
    input [31:0] ALUout,
    input [31:0] DMread,
    input [31:0] PCeg,
    input [1:0] M2Sel,
    output [31:0] M2out
    );
	 
	 assign M2out = (M2Sel==2'b00)? ALUout : 
	                (M2Sel==2'b01)? DMread :
						 (M2Sel==2'b10)? PCeg   :
						                        32'b0;
endmodule
