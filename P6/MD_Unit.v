`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:41:53 12/27/2020 
// Design Name: 
// Module Name:    MD_Unit 
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
module MD_Unit(
    input Clk,
	 input Reset,
    input [31:0] D1,
    input [31:0] D2,
    input [2:0] MDop,
	 output start,
	 output reg busy,
    output [31:0] HIE,
    output [31:0] LOE
    );
	 
	 reg [2:0] state;
	 reg [3:0] cnt;
	 reg [31:0] HI,LO;
    reg [31:0] VHI,VLO;
	 
	 parameter IDLE = 3'b000,MUL = 3'b001,DIV = 3'b010;
    parameter mthi = 3'b001,mtlo = 3'b010,
	           mult = 3'b011,multu = 3'b100,
				  div = 3'b101,divu = 3'b110;
				   
	 initial begin
	         HI  <= 32'b0;
				LO  <= 32'b0;
				VHI <= 32'b0;
				VLO <= 32'b0;
				state <= IDLE;
				busy  <= 1'b0;
				cnt <= 4'b0;
	 end
	 
	 always@(posedge Clk) begin
	     if(Reset) begin
		      HI  <= 32'b0;
				LO  <= 32'b0;
				VHI <= 32'b0;
				VLO <= 32'b0;
				state <= IDLE;
				busy  <= 1'b0;
				cnt <= 4'b0;
		  end
		  else begin
		      case(state)
				    IDLE : begin
					     case(MDop)
						      mthi : begin
								    HI <= D1;
									 busy  <= 1'b0;
									 cnt   <= 4'b0;
								end
								mtlo : begin
								    LO <= D1;
									 busy  <= 1'b0;
									 cnt   <= 4'b0;
								end
								mult : begin  //mult
								    state <= MUL;
									 busy <= 1'b1;
									 cnt  <= 4'b1;
									 {VHI,VLO} <= $signed(D1) * $signed(D2);
								end
								multu : begin
								    state <= MUL;
									 busy <= 1'b1;
									 cnt  <= 4'b1;
									 {VHI,VLO} <= D1 * D2;
								end
								div : begin
								    state <= DIV;
									 busy <= 1'b1;
									 cnt  <= 4'b1;
									 VHI   <= $signed(D1) % $signed(D2);
									 VLO   <= $signed(D1) / $signed(D2);
								end
								divu : begin
								    state <= DIV;
									 busy <= 1'b1;
									 cnt  <= 4'b1;
									 VHI   <= D1 % D2;
									 VLO   <= D1 / D2;
								end
						  endcase
					 end
					 MUL : begin
					     if(cnt==5) begin
								HI <= VHI;
								LO <= VLO;
								cnt <= 4'b0;
								busy <= 1'b0;
								state <= IDLE;
						  end
						  else begin
						      cnt <= cnt + 4'b1;
						  end
					 end
					 DIV : begin
					     if(cnt==10) begin
						      HI <= VHI;
								LO <= VLO;
								cnt <= 4'b0;
								busy <= 1'b0;
								state <= IDLE;
						  end
						  else begin
						      cnt <= cnt + 4'b1;
						  end
					 end
				endcase
		  end
	 end
	 
	 assign start = (MDop==3'b011) || (MDop==3'b100) || (MDop==3'b101) || (MDop==3'b110);
	 
	 assign HIE = HI;
	 assign LOE = LO;
    			 
     	  
endmodule
