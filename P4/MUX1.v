`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:45:05 12/01/2020 
// Design Name: 
// Module Name:    MUX1 
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
module MUX1(
    input [4:0] rt,
    input [4:0] rd,
    input [1:0] M1Sel,
    output [4:0] M1out
    );
	 
	 assign M1out = (M1Sel==2'b00)? rt :
	                (M1Sel==2'b01)? rd :
						 (M1Sel==2'b10)? 31 :
						                    5'b00000;
endmodule
