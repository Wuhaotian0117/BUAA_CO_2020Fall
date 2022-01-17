`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:12 10/24/2020 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
	 
	 parameter S0 = 2'b00, S1 = 2'b01;
	 parameter S2 = 2'b10, S3 = 2'b11;
	 reg [1:0] state = S0;
	 
	 always@(posedge clk, posedge clr) begin
	     if (clr) begin
		    state <= S0;
		  end
		  else begin
		      case(state)
				    S0 : begin
					     if((in>="0")&&(in<="9"))
						  state <= S1;
						  else if ((in=="+")||(in=="*")) begin
						  state <= S3;
						  end
						  else 
						  state <= S3;
					 end
					 S1 : begin
					     if((in>="0")&&(in<="9")) begin
						  state <= S3;
						  end
						  else if((in=="+")||(in=="*")) begin
						  state <= S2;
						  end
						  else begin
						  state <= S3;
						  end
					 end
					 S2 : begin
					     if ((in>="0")&&(in<="9"))begin
						  state <= S1;
						  end
						  else if((in=="+")||(in=="*"))begin
						  state <= S3;
						  end
						  else 
						  state <= S3;
					 end
					 S3 : begin
					     state <= S3;
					 end
				endcase
		  end
	 end
	 assign out = (state == S1);


endmodule
