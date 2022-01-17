`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:13 12/01/2020 
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
    input [31:0] addr,    //µÿ÷∑
    output [31:0] Instr   //÷∏¡Ó
    );
	 
	 reg [31:0] IMreg [0:1023];
    
	 initial begin
	     $readmemh("code.txt", IMreg);
	 end
	 
	 assign Instr = IMreg[addr[11:2]];

endmodule
