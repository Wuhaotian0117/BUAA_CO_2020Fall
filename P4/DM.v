`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:12 12/01/2020 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input Clk,
    input Reset,
    input [31:0] addr,
	 input [31:0] pc,
    input DMWr,
    input [31:0] MemWrite,   //写入数据
    output [31:0] MemRead    //读出数据
    );
	 
	 reg [31:0] DMreg [0:1023];
	 
	 wire [31:0] WriteData;
	 assign WriteData = MemWrite;   //视情况合成真正写入数据，比如sb或者是sh
	 
	 integer i = 0;
	 
	 always@(posedge Clk) begin
	     if(Reset) begin
		      for(i = 0; i < 1024; i = i + 1)
				DMreg[i] <= 32'b0;
		  end
		  else if(DMWr) begin
		      DMreg[addr[11:2]] <= WriteData;
				$display("@%h: *%h <= %h",pc,addr,WriteData);  //按要求输出
		  end
	 end
	 
	 assign MemRead = DMreg[addr[11:2]];  //读出数据

endmodule
