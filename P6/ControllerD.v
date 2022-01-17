`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:52:03 12/15/2020 
// Design Name: 
// Module Name:    ControllerD 
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
`include "Head.v"
module ControllerD(
    input [5:0] op,
    input [5:0] funct,
	 input [31:0] Instr_D,
	 input zero,
	 input isge,
	 input isgreat,
	 
    output [1:0] EXTOp,
    output [2:0] NPCOp,
	 output [1:0] M1Sel,
    output [1:0] Tuse_rs,
    output [1:0] Tuse_rt,
	 output isjump,
	 output ismuldiv
    );
	 
	 wire add,addu,sub,subu,andr,orr,xorr,norr,slt,sltu;
	 wire sll,srl,sra,sllv,srlv,srav;
	 wire addi,addiu,andi,ori,xori,lui,slti,sltiu;
	 wire lb,lbu,lh,lhu,lw;
	 wire sb,sh,sw;
	 wire beq,bne,blez,bgtz,bltz,bgez;
	 wire j,jal,jalr,jr;
	 wire mfhi,mflo,mthi,mtlo;
	 wire mult,multu,div,divu;
	 
	 //cal_r 16
	 assign add  = (op==`RType)&&(funct==`ADD),
	        addu = (op==`RType)&&(funct==`ADDU),
			  sub  = (op==`RType)&&(funct==`SUB),
			  subu = (op==`RType)&&(funct==`SUBU),
			  andr = (op==`RType)&&(funct==`AND),
			  orr  = (op==`RType)&&(funct==`OR),
			  xorr = (op==`RType)&&(funct==`XOR),
			  norr = (op==`RType)&&(funct==`NOR),
			  slt  = (op==`RType)&&(funct==`SLT),
			  sltu = (op==`RType)&&(funct==`SLTU);
			  
	 assign sll  = (op==`RType)&&(funct==`SLL),
	        srl  = (op==`RType)&&(funct==`SRL),
			  sra  = (op==`RType)&&(funct==`SRA),
			  sllv = (op==`RType)&&(funct==`SLLV),
			  srlv = (op==`RType)&&(funct==`SRLV),
			  srav = (op==`RType)&&(funct==`SRAV);
	 
	 //cal_i	8	  
	 assign addi = (op==`ADDI),
	        addiu = (op==`ADDIU),
			  andi = (op==`ANDI),
			  ori  = (op==`ORI),
			  xori = (op==`XORI),
			  lui  = (op==`LUI),
			  slti = (op==`SLTI),
			  sltiu = (op==`SLTIU);
	
    //load and store 8
	 assign lb  = (op==`LB),
	        lbu = (op==`LBU),
	        lh  = (op==`LH),
			  lhu = (op==`LHU),
			  lw  = (op==`LW);
	 assign sw  = (op==`SW),
           sb  = (op==`SB),
           sh  = (op==`SH);   
	 //branch 6
    assign beq  = (op==`BEQ),
           bne  = (op==`BNE),
			  blez = (op==`BLEZ),
			  bgtz = (op==`BGTZ),
			  bltz = (op==`BLTZ)&&(Instr_D[20:16]==5'b0),
			  bgez = (op==`BGEZ)&&(Instr_D[20:16]==5'b1);
	 //jump 4  
	 assign j    = (op==`J),
	        jal  = (op==`JAL),
	        jr   = (op==`RType)&&(funct==`JR),
	        jalr = (op==`RType)&&(funct==`JALR); /**/
    
	 //md instr
	 assign mfhi = (op==`RType)&&(funct==`MFHI),
	        mflo = (op==`RType)&&(funct==`MFLO),
			  mthi = (op==`RType)&&(funct==`MTHI),
			  mtlo = (op==`RType)&&(funct==`MTLO);
	 
	 assign mult  = (op==`RType)&&(funct==`MULT),
	        multu = (op==`RType)&&(funct==`MULTU),
			  div   = (op==`RType)&&(funct==`DIV),
			  divu  = (op==`RType)&&(funct==`DIVU);
	 
	 //class the instr
    wire cal_r,cal_i,shif,shifv,load,store,branch,jump,md;
    
    assign cal_r = add || addu || sub || subu || andr || orr || xorr || norr || slt || sltu;
				
	 assign shif = sll || srl || sra; 
	 
	 assign shifv = sllv || srlv || srav;
	 
	 assign cal_i = addi || addiu || andi || ori || xori || lui || slti || sltiu;
	 
	 assign load = lb || lbu || lh || lhu || lw;
	 
	 assign store = sw || sb || sh;
	 
	 assign branch = beq || bne || blez || bgtz || bltz || bgez;
	 
	 assign jump = j || jal || jalr || jr;
	 
	 assign md = mult || multu || div || divu;
    
	 ///controll op
    assign EXTOp = (andi || ori || xori) ? 2'b01 : 
                   lui ? 2'b10 :
						 2'b00; 
	 
    assign NPCOp = branch ? 3'b001 : 
                   (j || jal) ? 3'b010 : 
                   (jalr || jr) ? 3'b011 : 
                   3'b000;
	 
    assign M1Sel = (cal_r || shif || shifv || jalr || mfhi || mflo) ? 2'b01 : 
                   jal ? 2'b10 : 
                   (cal_i || load)? 2'b00 : 
                   2'b11;
	 
	 ///The use time
	 assign Tuse_rs = (branch || jr || jalr)? 2'b00 : 
	                  (cal_r || shifv || cal_i || load || store || md || mthi || mtlo) ? 2'b01 : 
	                  2'b11;
							
	 assign Tuse_rt = (branch)? 2'b00 : 
	                  (cal_r || shif || shifv || md)? 2'b01 : 
	                  (store)? 2'b10 : 
							2'b11;
    ///isjump 是否跳转或链接
	 wire notequal,less,lessequal;
	 assign notequal = !zero;
	 assign less     = !isge;
	 assign lessequal = !isgreat;
	
	 assign isjump = (beq && zero) || (bne && notequal)|| (bgez && isge) ||
	                 (bgtz && isgreat) || (blez && lessequal) || (bltz && less) || 
						  j || jal || jr || jalr;
	 
	 //D级是否是乘除类指令
	 assign ismuldiv = mult || multu || div || divu || mfhi || mflo || mthi || mtlo;
	 
endmodule
