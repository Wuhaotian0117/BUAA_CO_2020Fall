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
	 
	 reg [31:0] IMreg [0:4095];
	 
	 initial begin
	     $readmemh("code.txt", IMreg);
	 end
	 
	 wire [31:0] getaddr;
	 assign getaddr = addr - 32'h3000;
	 assign Instr = IMreg[getaddr[13:2]];

endmodule
