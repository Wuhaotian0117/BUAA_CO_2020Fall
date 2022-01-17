`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:51:22 10/15/2020 
// Design Name: 
// Module Name:    cpu_checker 
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
`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S51 4'b0101
`define S52 4'b0110
`define S6 4'b0111
`define S7 4'b1000
`define S8 4'b1001
`define S9 4'b1010
`define S10 4'b1011


module cpu_checker(
    input clk,
    input reset,
    input freq,
    input [7:0] char,
    output [1:0] format_type,
    output [3:0] error_code
    );
	 
	 reg [3:0] state = `S0;
	 reg [1:0] flag = 2'b00;   //用于区分两个序列
	 reg [3:0] Regd = 4'b0000; //用于计数十进制位数
	 reg [3:0] Regh = 4'b0000; //用于计数十六进制位数
	 
	 always@(posedge clk)begin
	   if (reset) begin
		state <= `S0;
		flag <= 2'b00;
		Regd <= 4'b0;
		Regh <= 4'b0;
		end
		else begin
		  case(state)
		    `S0 : begin
			         if (char == "^")
						state <= `S1;
						else begin
						state <= `S0;
						flag <= 2'b00;
						Regd <= 4'b0;
						Regh <= 4'b0;
						end
			 end
			 `S1 : begin //检测十进制数
			         if (char >= "0" && char <= "9")begin
						state <= `S1;
						Regd <= Regd + 1;
						end
						else if ((char == "@")&&((Regd >= 1)&&(Regd <= 4))) begin
						state <= `S2;
						Regd <= 4'b0;
						end
						else begin
						state <= `S0;
						Regd <= 4'b0;
						end
			  end
			  `S2 : begin   //检测十六进制数
			          if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f")) begin
						   if(Regh == 4'b0111) begin
							state <= `S3;
							Regh <= 4'b0;
							end
							else if (Regh < 4'b0111) begin
							state <= `S2;
							Regh <= Regh + 1;
							end
							else begin
							state <= `S0;
							Regh <= 4'b0;
							end
						 end
						 else begin
						 state <= `S0;
						 Regh <= 0;
						 end
			  end
			  `S3 : begin
			          if (char == ":") begin
						 state <= `S4;
						 end
						 else begin
						 state <= `S0;
						 end
			  end
			  `S4 : begin  //flag用于区分两种序列，S51,S52是不同的分支
			          if (char == " ") begin
						 state <= `S4;
						 end
						 else if (char == "$") begin
						 state <= `S51;
						 flag <= 2'b01;
						 end
						 else if (char == 8'd42) begin
						 state <= `S52;
						 flag <= 2'b10;
						 end
						 else begin
						 state <= `S0;
						 end
			 end
			 `S51 : begin  //检测十进制数
			          if (char >= "0" && char <= "9") begin
						 state <= `S51;
						 Regd <= Regd + 1;
						 end
						 else if (char == " ") begin
						 state <= `S51;
						 end
						 else if (char == "<") begin
						   if ((Regd <= 4)&&(Regd>=1)) begin
							state <= `S7;
							Regd <= 4'b0;
							end
							else begin
							state <= `S0;
							Regd <= 4'b0;
							end
						 end
						 else begin
						 state <= `S0;
						 Regd <= 4'b0;
						 end
			 end
			 `S52 : begin  //检测十六进制数
			          if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))begin
						   if (Regh == 4'b0111) begin
							state <= `S6;
							Regh <= 4'b0;
							end
							else if (Regh < 4'b0111) begin
							state <= `S52;
							Regh <= Regh + 1;
							end
							else begin
							state <= `S0;
							Regh <= 4'b0;
							end
						 end
						 else begin
						 state <= `S0;
						 Regh <= 4'b0;
						 end
			 end
			 `S6 : begin
			         if (char == " ") begin
						state <= `S6;
						end
						else if (char == "<") begin
						state <= `S7;
						end
						else begin
						state <= `S0;
						end
			 end
			 `S7 : begin
			          if (char == "=") begin
						 state <= `S8;
						 end
						 else begin
						 state <= `S0; 
						 end
			 end
			 `S8 : begin   //检测十六进制数
			         if (char == " ")begin
						state <= `S8;
						end
						else if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f")) begin
						  if (Regh == 4'b0111) begin
						  state <= `S9;
						  Regh <= 4'b0;
						  end
						  else if (Regh < 4'b0111) begin
						  state <= `S8;
						  Regh <= Regh + 1;
						  end
						  else begin
						  state <= `S0;
						  Regh <= 4'b0;
						  end
						end
						else begin
						state <= `S0;
						Regh <= 4'b0;
						end
			  end
			  `S9 : begin
			          if (char == "#")begin
						 state <= `S10;
						 end
						 else begin
						 state <= `S0;
						 end
			  end
			  `S10 : begin
			           if (char == "^")begin
						  state <= `S1;
						  flag <= 2'b00;
						  end
						  else begin
						  state <= `S0;
						  flag <= 2'b00;
						  Regd <= 4'b0;
						  Regh <= 4'b0;
						  end
			  end
		  endcase
		end
	 end
	 assign format_type = (state == `S10) ? flag : 2'b00;
	 assign error_code = 4'b0000;


endmodule
