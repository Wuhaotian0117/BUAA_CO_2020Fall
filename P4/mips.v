`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:28 12/01/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(clk,reset);
    input clk;
    input reset;
	 
	 wire [31:0] NPC;    //32λ�ε�ַ
	 wire [31:0] PC;     //32λ��ǰ��ַ
	 PC PCinstance(
	 .Clk(clk),
	 .Reset(reset),
	 .NPC(NPC),
	 .PC(PC)
	 );
	 
	 wire [31:0] Instr;  //����ָ��
	 
	 IM IMinstance(
	 .addr(PC),
	 .Instr(Instr)
	 );
	 
	 //�����ź�
	 wire [2:0] NPCOp;
	 wire [1:0] M1Sel;
	 wire [1:0] M2Sel;
	 wire M3Sel;
	 wire RFWr;
	 wire [1:0] EXTOp;
	 wire [2:0] ALUOp;
	 wire DMWr;
	 
	 Controller Ctrlinstance(
	 .op(Instr[31:26]),
	 .funct(Instr[5:0]),
	 .NPCOp(NPCOp),
	 .M1Sel(M1Sel),
	 .M2Sel(M2Sel),
	 .M3Sel(M3Sel),
	 .RFWr(RFWr),
	 .EXTOp(EXTOp),
	 .ALUOp(ALUOp),
	 .DMWr(DMWr)
	 );
	 
	 //�ֱ��Ӧָ����Ӧ��5λ��ȡGRF���±�
	 wire [4:0] A1,A2,A3;
	 assign A1 = Instr[25:21];
	 assign A2 = Instr[20:16];
	 
	 MUX1 MUX1instance(
	 .rt(Instr[20:16]),
	 .rd(Instr[15:11]),
	 .M1Sel(M1Sel),
	 .M1out(A3)
	 );
	 
	 
	 wire [31:0] WData;  //д������
	 wire [31:0] RD1,RD2;  //������������
	 
	 GRF GRFinstance(
	 .Clk(clk),
	 .Reset(reset),
	 .RFWr(RFWr),
	 .A1(A1),
	 .A2(A2),
	 .A3(A3),
	 .WData(WData),
	 .WPC(PC),
	 .RD1(RD1),
	 .RD2(RD2)
	 );
	 
	 
	 //ALU�����������ݣ��Լ�����ļ�����
	 wire [31:0] A,B,ALUout;
	 wire zero;
	 
	 assign A = RD1;
	 ALU ALUinstance(
	 .ALUOp(ALUOp),
	 .A(A),
	 .B(B),
	 .C(ALUout),
	 .zero(zero)
	 );
	 
	 wire [31:0] DMout;
	 DM DMinstance(
	 .Clk(clk),
	 .Reset(reset),
	 .addr(ALUout),
	 .pc(PC),
	 .DMWr(DMWr),
	 .MemWrite(RD2),
	 .MemRead(DMout)
	 );
	 
	 //ext��չ���
	 wire [31:0] EXTout;
	 EXT EXTinstance(
	 .EXTOp(EXTOp),
	 .imm(Instr[15:0]),
	 .ext(EXTout)
	 );
	 
	 //PC_4Ϊ��ǰPC+4��ֵ
	 wire [31:0] PC_4;
	 MUX2 MUX2instance(
	 .ALUout(ALUout),
	 .DMread(DMout),
	 .PC_4(PC_4),
	 .M2Sel(M2Sel),
	 .M2out(WData)
	 );
	 
	 MUX3 MUX3instance(
	 .grf(RD2),
	 .extout(EXTout),
	 .M3Sel(M3Sel),
	 .M3out(B)
	 );
	 
	
	 NPC NPCinstance(
	 .PC(PC),
	 .NPCOp(NPCOp),
	 .Instr(Instr),
	 .RA(RD1),
	 .zero(zero),
	 .NPC(NPC),
	 .PC4(PC_4)
	 );
	 
	 
	 
	 	 
	  

endmodule
