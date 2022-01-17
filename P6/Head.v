`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:27 12/15/2020 
// Design Name: 
// Module Name:    Head 
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

`define RType 6'b000000
`define NOP   6'b000000

///cal_r 16
`define ADD   6'b100000
`define ADDU  6'b100001
`define SUB   6'b100010
`define SUBU  6'b100011

`define AND   6'b100100
`define OR    6'b100101
`define XOR   6'b100110
`define NOR   6'b100111
`define SLT   6'b101010
`define SLTU  6'b101011

`define SLL   6'b000000
`define SRL   6'b000010
`define SRA   6'b000011
`define SLLV  6'b000100
`define SRLV  6'b000110
`define SRAV  6'b000111



///cal_i 8
`define ADDI  6'b001000
`define ADDIU 6'b001001
`define ANDI  6'b001100
`define ORI   6'b001101
`define XORI  6'b001110
`define LUI   6'b001111

`define SLTI  6'b001010
`define SLTIU 6'b001011

//load 5
`define LW    6'b100011
`define LB    6'b100000
`define LBU   6'b100100
`define LH    6'b100001
`define LHU   6'b100101

//store 3
`define SW    6'b101011
`define SB    6'b101000
`define SH    6'b101001

///branch 6
`define BEQ   6'b000100
`define BNE   6'b000101
`define BLEZ  6'b000110
`define BGTZ  6'b000111
`define BLTZ  6'b000001
`define BGEZ  6'b000001

///jump 4
`define J     6'b000010
`define JAL   6'b000011
`define JR    6'b001000
`define JALR  6'b001001

///MFMT
`define MFHI 6'b010000
`define MFLO 6'b010010
`define MTHI 6'b010001
`define MTLO 6'b010011

///MUT DIV
`define MULT  6'b011000
`define MULTU 6'b011001
`define DIV   6'b011010
`define DIVU  6'b011011


///ALU define
`define ADDalu 4'b0000
`define SUBalu 4'b0001
`define ORalu  4'b0010
`define ANDalu 4'b0011
`define XORalu 4'b0100
`define NORalu 4'b0101
`define SLTalu 4'b0110
`define SLTUalu 4'b0111
`define SLLalu  4'b1000
`define SRLalu  4'b1001
`define SRAalu  4'b1010






