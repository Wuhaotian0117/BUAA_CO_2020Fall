`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:30 12/15/2020 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] addr,
    output [31:0] Instr
    );
	 
	 reg [31:0] IMreg [0:1023];
	 
	 initial begin
	     $readmemh("code.txt", IMreg);
	 end
	 
	 assign Instr = IMreg[addr[11:2]];


endmodule
