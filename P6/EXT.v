`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:30 12/15/2020 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [1:0] EXTOp,
    input [15:0] imm,
    output reg [31:0] EXTout
    );
	 
	 parameter sign   = 2'b00,  //符号扩展
	           unsign = 2'b01,  //无符号扩展
				  lui    = 2'b10;  //加载立即数至高位
				  
	always@(*) begin
	     case(EXTOp)
		      sign   : EXTout = {{16{imm[15]}},imm[15:0]};
				unsign : EXTout = {16'b0,imm[15:0]};
				lui    : EXTout = {imm[15:0],16'b0};
				default: EXTout = 32'bx;
		  endcase
	 end


endmodule
