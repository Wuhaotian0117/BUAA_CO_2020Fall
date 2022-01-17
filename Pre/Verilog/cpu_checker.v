`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:58 09/24/2020 
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
`define S0 5'b00000
`define S1 5'b00001
`define S2 5'b00010
`define S3 5'b00011
`define S4 5'b00100
`define S5 5'b00101
`define S6 5'b00110
`define S71 5'b00111
`define S72 5'b01000
`define S81 5'b01001
`define S82 5'b01010
`define S9 5'b01011
`define S10 5'b01100
`define S11 5'b01101
`define S12 5'b01110
`define S13 5'b01111
`define S14 5'b10000

//前面宏定义了状态
module cpu_checker(
    input [7:0] char,
    input clk,
    input reset,
    output [1:0] format_type
    );
	 reg [4:0] status = `S0;
	 reg [1:0] flag = 2'b00;
	 reg [3:0] Regd = 4'b0000; //用于计数十进制位数
	 reg [3:0] Regh = 4'b0000; //用于计数十六进制位数
	 
	 always@(posedge clk)begin
	   if (reset)begin
	      status <= `S0;
	      flag <= 2'b00;
	      Regd <= 4'b0000;
			Regh <= 4'b0000;
	   end
	   else begin
	      case(status)
	      `S0 : begin
			         if(char == "^")
						status <= `S1;
						else begin
						status <= `S0;
						flag <= 2'b00;
						end
			     end
			`S1 : begin  //最前的字符“^”
			         if(char >= "0" && char <= "9") begin
						status <= `S2;
						Regd <= Regd + 1;  //累计十进制数字个数
						end
						else 
						status <= `S0;
			     end
			`S2 : begin  //十进制数字
			         if (char >= "0" && char <= "9")begin
						   if (Regd >= 4'b0100) begin
						   status <= `S0;
						   Regd <= 4'b0;
						   end
						   else begin
							Regd <= Regd + 1;
						   status <= `S2;
						   end
						end
						else if (char == "@") begin
						status <= `S3;
						Regd <= 4'b0;
						end
						else
						status <= `S0;
				  end
			`S3 : begin //字符”@“
                  if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))begin
						status <= `S4;
						Regh <= Regh +1;  //记录十六进制个数
						end
                  else
						status <= `S0;
			     end
         `S4 : begin //十六进制数字
                  if (char == ":") begin
						   if (Regh == 4'b1000) begin  //十六进制数字必须8位
                     status <= `S5;
						   Regh <= 4'b0;
						   end
						   else begin
						   status <= `S0;
						   Regh <= 4'b0;
						   end
					   end
						else if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f")) begin
						status <= `S4;
						Regh <= Regh + 1;
                  end
                  else
                  status <= `S0;							
              end
         `S5 : begin //字符“:”
                  if (char == " ")
                  status <= `S6;
                  else if (char == "$")begin
						status <= `S71;
						flag <= 2'b01;
						end
						else if (char == "*")begin
						status <= `S72;
						flag <= 2'b10;
						end
						else
						status <= `S0;
				  end	
			`S6 : begin //空格
			          if (char == " ")
						 status <= `S6;
						 else if (char == "$")begin
						 status <= `S71;
						 flag <= 2'b01;
						 end
						 else if (char == "*")begin
						 status <= `S72;
						 flag <= 2'b10;
						 end
						 else
						 status <= `S0;
					end
			`S71 : begin //字符“$”
			           if (char >= "0" && char <= "9")begin
						  status <= `S81;
						  Regd <= Regd + 1;
						  end
						  else
						  status <= `S0;
				   end
			`S72 : begin  //字符“*”
			          if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))begin
						 status <= `S82;
						 Regh <= Regh + 1;
						 end
						 else
						 status <= `S0;
					end
			`S81 : begin //十进制数字
			          if (char >= "0" && char <= "9")begin
						    if (Regd >= 4'b0100) begin
							 status <= `S0;
							 Regd <= 4'b0;
							 end
							 else begin
						    status <= `S81;
							 Regd <= Regd + 1;
							 end
						 end
						 else if (char == " ")
						 status <= `S9;
						 else if (char == "<")
						 status <= `S10;
						 else
						 status <= `S0;
			      end
			`S82 : begin //十六进制数字
						 if (char == " ") begin
						    if (Regh == 4'b1000) begin
						    status <= `S9;
							 Regh <= 4'b0;
							 end
						    else begin
							 status <= `S0;
							 Regh <= 4'b0;
						    end
						 end
						 else if (char == "<") begin
						         if (Regh == 4'b1000) begin
									status <= `S10;
									Regh <= 4'b0;
									end
									else begin
									status <= `S0;
									Regh <= 4'b0;
									end
						 end
						 else if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))begin
						 status <= `S82;
						 Regh <= Regh + 1;
						 end
						 else
						 status <= `S0;
			     end
			`S9 : begin //空格
			         if(char == " ")
						status <= `S9;
						else if (char == "<")
						status <= `S10;
						else
						status <= `S0;
			      end
			`S10 : begin //字符“<”
			          if (char == "=")
						 status <= `S11;
						 else 
						 status <= `S0;
					end
			`S11 : begin //字符“=”
			          if (char == " ")
						 status <= `S12;
						 else if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f")) begin
						 status <= `S13;
						 Regh <= Regh + 1;
						 end
						 else
						 status <= `S0;
			      end
			`S12 : begin //空格
			          if (char == " ")
						 status <= `S12;
						 else if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f"))begin
						 status <= `S13;
						 Regh <= Regh +1;
						 end
						 else
						 status <= `S0;
					end
			`S13 : begin //十六进制数字
			          if ((char >= "0" && char <= "9")||(char >= "a" && char <= "f")) begin
						 status <= `S13;
						 Regh <= Regh + 1;
						 end
						 else if (char == "#") begin
						         if (Regh == 4'b1000) begin
						         status <= `S14;
									Regh <= 4'b0;
									end
									else begin
									status <= `S0;
									Regh <= 4'b0;
									end
						 end
						 else
						 status <= `S0;
					end
			`S14 : begin
			          if (char == "^") begin
						 status <= `S1;
						 flag <= 2'b00;
						 end
						 else
						 status <= `S0;
					end
			default : status <= `S0;
	      endcase
	   end
	 end
    assign format_type = (status == `S14) ? flag : 2'b00;

endmodule
