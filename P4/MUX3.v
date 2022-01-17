`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:39 12/01/2020 
// Design Name: 
// Module Name:    MUX3 
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
module MUX3(
    input [31:0] grf,
    input [31:0] extout,
    input M3Sel,
    output [31:0] M3out
    );
	 
	 assign M3out = (M3Sel==0)? grf : extout;

endmodule
