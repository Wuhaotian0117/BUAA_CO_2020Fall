`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:37 10/27/2020 
// Design Name: 
// Module Name:    BlockChecker 
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
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );
	 
	 parameter zero = 4'b0000;  //无关单词
	 parameter space = 4'b0001; //空格
	 
	 parameter begin_b = 4'b0010, begin_e = 4'b0011; //begin相关状态
    parameter begin_g = 4'b0100, begin_i = 4'b0101;
    parameter begin_n = 4'b0110;
	 
    parameter end_e = 4'b0111, end_n = 4'b1000;  //end相关状态
    parameter end_d = 4'b1001;
	 
	 
	 parameter S0 = 2'b00,S1 = 2'b01;  //表示匹配的状态
	 parameter S2 = 2'b10,S3 = 2'b11;
	 
	 reg [3:0] word = space;  //判断单词
	 reg [1:0] state = S0;   //判断匹配
	 
	 reg [31:0] count_begin = 32'b0;  //记录begin个数
	 reg [31:0] count_end = 32'b0;    //记录end个数
	 
	 //error 标志匹配出错,输出恒为0
	 reg error = 0; 
	 
	 
	 always@(posedge clk,posedge reset)begin  //读入单词时的状态转移
	 if (reset)begin
	     word <= space;
		  count_begin <= 32'b00;
		  count_end <= 32'b00;
	 end
	 else begin
	     case(word)
		      zero : begin
		          if (in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
		      end
				space : begin  //空格
				    if ((in=="B")||(in=="b")) begin
					     word <= begin_b;
					 end
					 else if ((in=="E")||(in=="e")) begin
					     word <= end_e;
					 end
					 else if(in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
				begin_b : begin
				    if ((in=="E")||(in=="e")) begin
					     word <= begin_e;
					 end
					 else if (in==" ") begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
			   begin_e : begin
				    if ((in=="G")||(in=="g")) begin
					     word <= begin_g;
					 end
					 else if (in==" ") begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
				begin_g : begin
				    if ((in=="I")||(in=="i")) begin
					     word <= begin_i;
					 end
					 else if (in==" ") begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
				begin_i : begin
				    if ((in=="N")||(in=="n")) begin
					     word <= begin_n;
						  count_begin = count_begin + 1;
					 end
					 else if (in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
				begin_n : begin
				    if (in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
						  count_begin = count_begin - 1;
					 end
				end
				end_e : begin
				    if ((in=="N")||(in=="n")) begin
					     word <= end_n;
					 end
					 else if (in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
				end_n : begin
				    if ((in=="D")||(in=="d")) begin
					     word <= end_d;
						  count_end = count_end + 1;
					 end
					 else if (in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
					 end
				end
				end_d : begin
				    if (in==" ")begin
					     word <= space;
					 end
					 else begin
					     word <= zero;
						  count_end = count_end - 1;
					 end
				end
		  endcase
	 end
	 end
	 
	 always@(posedge clk,posedge reset) begin  //输出状态转移
	     if (reset) begin
		      state = S0;
            error <= 0;				
		  end
		  else begin
		      case(state)
				    S0 : begin  //begin&end匹配
					     if (count_begin > count_end) begin
								   state = S1;
						  end
						  else if (count_begin == count_end)begin
						      state = S0;
						  end
						  else begin
								state = S2;
						  end
					 end
					 S1 : begin   //begin多于end,待匹配
					     if (count_begin > count_end) begin
						      state = S1;
						  end
						  else if (count_begin == count_end) begin
						      state = S0;
						  end
						  else begin
						      state = S2;
						  end
					 end
					 S2 : begin     //end多于begin，result恒为0，S3即匹配错误
					     if (count_begin < count_end) begin
						      state = S3;
								error = 1;
						  end
						  else if (count_begin == count_end) begin
						      state = S0;
						  end
					 end
					 S3 : begin
					     state = S3;
					 end
				endcase
		  end
	 end

    assign result = (state==S0);

endmodule
