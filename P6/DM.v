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
	 input [1:0] STOp,
    input [31:0] MemWrite,
    output [31:0] MemRead
    );
	 
	 reg [31:0] DMreg [0:4095];
	 
	 reg [31:0] WriteData;
	 always@(*) begin
	     case(STOp)
		      2'b00 : WriteData = MemWrite;  //sw
				2'b01 : begin  //sh
				    case(addr[1:0])
					     2'b00 : WriteData = {DMreg[addr[13:2]][31:16],MemWrite[15:0]};
						  2'b10 : WriteData = {MemWrite[15:0],DMreg[addr[13:2]][15:0]};
					 endcase
				end
				2'b10 : begin  //sb
				    case(addr[1:0])
					     2'b00 : WriteData = {DMreg[addr[13:2]][31:8],MemWrite[7:0]};
						  2'b01 : WriteData = {DMreg[addr[13:2]][31:16],MemWrite[7:0],DMreg[addr[13:2]][7:0]};
						  2'b10 : WriteData = {DMreg[addr[13:2]][31:24],MemWrite[7:0],DMreg[addr[13:2]][15:0]};
						  2'b11 : WriteData = {MemWrite[7:0],DMreg[addr[13:2]][23:0]};
					 endcase
				end
				default : WriteData = 32'b0;
		  endcase
	 end
	 
	 integer i = 0;
	 always@(posedge Clk) begin
	     if(Reset) begin
		      for(i = 0; i <= 4095; i = i + 1)
				DMreg[i] <= 32'b0;
		  end
		  else if(DMWr) begin		  
		      if(STOp==2'b00) begin
		          DMreg[addr[13:2]] <= WriteData;
				    $display("%d@%h: *%h <= %h", $time,WPC,addr,WriteData);  //按要求输出
				end				
				else begin
				    DMreg[addr[13:2]] <= WriteData;
				    $display("%d@%h: *%h <= %h", $time,WPC,{addr[31:2],2'b00},WriteData);  //按要求输出
				end
		  end
	 end
	 
	 assign MemRead = DMreg[addr[13:2]];

endmodule
