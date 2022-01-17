`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:34:47 09/19/2020 
// Design Name: 
// Module Name:    id_fsm 
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
`define S0 2'b00
`define S1 2'b01
`define S2 2'b11
module id_fsm(
    input [7:0] char,
    input clk,
    output out
    );
	 
	 parameter digit_one = 48,digit_nine= 57;
	 parameter upper_A = 65,upper_Z = 90;
	 parameter lower_a = 97,lower_z = 122;
	 
	 reg [1:0] status = `S0;
	 
	 always@(posedge clk) begin
	 case(status)
	 `S0 : begin
	          if (char >= digit_one && char <= digit_nine)
				 status <= `S0;
				 else if (char >= upper_A && char <= upper_Z)
				 status <= `S1;
				 else if (char >= lower_a && char <= lower_z)
				 status <= `S1;
				 else
				 status <= `S0;
			end
	 `S1 : begin
	          if (char >= digit_one && char <= digit_nine)
				 status <=`S2;
				 else if (char >= upper_A && char <= upper_Z)
				 status <= `S1;
				 else if (char >= lower_a && char <= lower_z)
				 status <= `S1;
				 else
				 status <= `S0;
			end
	 `S2 : begin
	          if (char >= digit_one && char <= digit_nine)
				 status <= `S2;
				 else if (char >= upper_A && char <= upper_Z)
				 status <= `S1;
				 else if (char >= lower_a && char <= lower_z)
				 status <= `S1;
				 else
				 status <= `S0;
			end
		default : status <= `S0;
	 endcase
	end
	assign out = (status == `S2) ? 1'b1 : 1'b0;


endmodule
