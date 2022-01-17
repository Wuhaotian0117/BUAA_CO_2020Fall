`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:27 12/15/2020 
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
    input [31:0] WPC,
    input DMWr,
    input [31:0] MemWrite,
    output [31:0] MemRead
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
				$display("%d@%h: *%h <= %h", $time,WPC,addr,WriteData);  //按要求输出
		  end
	 end
	 
	 assign MemRead = DMreg[addr[11:2]];

endmodule
