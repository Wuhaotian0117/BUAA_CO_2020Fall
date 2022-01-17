`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:45 12/01/2020 
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
    output reg [31:0] ext
    );
	 
	 parameter sign   = 2'b00,   //符号扩展
	           unsign = 2'b01,   //无符号扩展
 				  lui    = 2'b10;   //加载至高位
	 
	 always@(*) begin
	     case(EXTOp)
		      sign   : ext = {{16{imm[15]}},imm[15:0]};
				unsign : ext = {16'b0,imm[15:0]};
				lui    : ext = {imm[15:0],16'b0};
				default: ext = 32'bx;
		  endcase
	 end
	 
	 /*assign ext = (EXTOp==2'b00)? {{16{imm[15]}},imm[15:0]} : 
	              (EXTOp==2'b01)? {16'b0,imm[15:0]} :
					  (EXTOp==2'b10)? {imm[15:0],16'b0} :
					                                    32'b0;*/


endmodule
