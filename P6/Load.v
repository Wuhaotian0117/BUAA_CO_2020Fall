`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:21 12/27/2020 
// Design Name: 
// Module Name:    Load 
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
module Load(
    input [31:0] DMreadW,
	 input [31:0] addr,
    input [2:0] LDOp,
    output reg [31:0] LoadData
    );
	 
	 always@(*) begin
	     case(LDOp)
		      3'b000 : LoadData = DMreadW;  //lw
				3'b001 : begin //lb
				    case(addr[1:0])
					     2'b00 : LoadData = {{24{DMreadW[7]}},DMreadW[7:0]};
						  2'b01 : LoadData = {{24{DMreadW[15]}},DMreadW[15:8]};
						  2'b10 : LoadData = {{24{DMreadW[23]}},DMreadW[23:16]};
						  2'b11 : LoadData = {{24{DMreadW[31]}},DMreadW[31:24]};
					 endcase
				end
				3'b010 : begin //lbu
				    case(addr[1:0])
					     2'b00 : LoadData = {24'b0,DMreadW[7:0]};
						  2'b01 : LoadData = {24'b0,DMreadW[15:8]};
						  2'b10 : LoadData = {24'b0,DMreadW[23:16]};
						  2'b11 : LoadData = {24'b0,DMreadW[31:24]};
					 endcase
				end
				3'b011 : begin //lh
				    case(addr[1:0])
					     2'b00 : LoadData = {{16{DMreadW[15]}},DMreadW[15:0]};
						  2'b10 : LoadData = {{16{DMreadW[31]}},DMreadW[31:16]};
					 endcase
				end
				3'b100 : begin //lhu
				    case(addr[1:0])
					     2'b00 : LoadData = {16'b0,DMreadW[15:0]};
						  2'b10 : LoadData = {16'b0,DMreadW[31:16]};
					 endcase
				end
				default : LoadData = DMreadW;
		  endcase
	 end


endmodule
