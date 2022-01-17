`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:26 09/18/2020 
// Design Name: 
// Module Name:    code 
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
`define zero 64'b0
module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output [63:0] Output0,
    output [63:0] Output1
    );
	 reg [3:0] clk1 = 4'b0;
	 reg [63:0] count0;
	 reg [63:0] count1;
	 
	 initial
	 begin
	 count0 <= `zero;
	 count1 <= `zero;
	 end
	 
	 always@(posedge Clk)
	 begin
	    if (Reset)
	    begin
	       count0 <= `zero;
		    count1 <= `zero;
		    clk1 <= 4'b0;
	    end
	    else if (!Reset && En)
	    begin
	       if (Slt == 1)
	       begin
			    //clk1 <= clk1 + 1;
			    if ( (clk1 + 1)== 4'b0100)
			    begin
			    count1 <= count1 +1;
			    clk1 <= 4'b0;
             end
             else 
			    begin
				 clk1 <= clk1 + 1;
             count1 <= count1;
             end			 
			 end
			 else if (Slt == 0)
			 begin
			 count0 <= count0 + 1;
			 end
		 end
	 end
	 assign Output0 = count0,Output1 = count1;
		    

endmodule
