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
    input [31:0] MemWrite,   //д������
    output [31:0] MemRead    //��������
    );
	 
	 reg [31:0] DMreg [0:1023];
	 
	 wire [31:0] WriteData;
	 assign WriteData = MemWrite;   //������ϳ�����д�����ݣ�����sb������sh
	 
	 integer i = 0;
	 
	 always@(posedge Clk) begin
	     if(Reset) begin
		      for(i = 0; i < 1024; i = i + 1)
				DMreg[i] <= 32'b0;
		  end
		  else if(DMWr) begin
		      DMreg[addr[11:2]] <= WriteData;
				$display("@%h: *%h <= %h",pc,addr,WriteData);  //��Ҫ�����
		  end
	 end
	 
	 assign MemRead = DMreg[addr[11:2]];  //��������

endmodule
