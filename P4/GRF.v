`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:03 12/01/2020 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input Clk,
    input Reset,
    input RFWr,      //写使能
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WData,   //写入数据
	 input [31:0] WPC,     //当前PC
    output [31:0] RD1,
    output [31:0] RD2
    );
	 
	 reg [31:0] GRFreg [0:31];
	 integer i = 0;
	 
	 always@(posedge Clk) begin
	 
	     if(Reset) begin
		      for(i = 0; i<= 31; i = i + 1)  //同步复位
				GRFreg[i] <= 32'b0;
		  end
		  
		  else if(RFWr && (A3!=5'b0)) begin
		      GRFreg[A3] <= WData;
				$display("@%h: $%d <= %h",WPC,A3,WData);  //按要求输出
		  end
	 end
	 
	 assign RD1 = GRFreg[A1];
    assign RD2 = GRFreg[A2];

endmodule
