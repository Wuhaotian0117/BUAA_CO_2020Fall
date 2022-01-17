`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:51 10/24/2020 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );
	 
	 reg [2:0] count = 3'b000;
	 reg flag = 0;
	 
	 always@(posedge Clk) begin
	   if (Reset) begin
		    count <= 3'b000;
			 flag <= 0;
		end
		else begin
		    if (En) begin
			   if (count == 3'b111) begin
				  count <= 3'b000;
				  flag <= 1;
				end
				else begin
				  count <= count + 1;
				end
			 end
			 else begin
			     count <= count;
			 end
		end
	 end

    assign Overflow = (flag == 1);
	 assign Output = {count[2],((~count[2]&count[1])|(count[2]&~count[1])),((~count[1]&count[0])|(count[1]&~count[0]))};

endmodule
