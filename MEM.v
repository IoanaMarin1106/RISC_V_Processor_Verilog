`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 03:56:30 PM
// Design Name: 
// Module Name: MEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM(
    input clk,
    
    input ZERO_MEM,
    input [31:0] ALU_OUT_MEM, //address
    input [31:0] PC_MEM,
    input [31:0] REG_DATA2_MEM,
  
    input [4:0] RD_MEM,
    input RegWrite_MEM,  MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
    input [2:0] FUNCT3_MEM,
    
    output Branch_OUT,
    output RegWrite_WB, MemtoReg_WB,
    output [31:0] DATA_MEMORY_WB,
    output [31:0] ALU_OUT_WB,
    output [4:0] RD_WB
    );
    
    
    data_memory DATA_MEMORY_MODULE(clk, MemRead_MEM, MemWrite_MEM, ALU_OUT_MEM, REG_DATA2_MEM, DATA_MEMORY_WB);
    verify_branch_module BRANCH_MODULE(Branch_MEM, ZERO_MEM, FUNCT3_MEM, ALU_OUT_MEM, Branch_OUT);
   
    assign MemtoReg_WB = MemtoReg_MEM;
    assign RegWrite_WB = RegWrite_MEM;
    assign ALU_OUT_WB = ALU_OUT_MEM;
    assign RD_WB = RD_MEM;
   
endmodule
