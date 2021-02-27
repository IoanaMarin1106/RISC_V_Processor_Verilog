`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2020 06:24:11 PM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
             );
    
    /////////////////////////////////////////// SIGNALS ////////////////////////////////////////
    // IF signals
    wire PC_write;
    wire[31:0] PC_IF, INSTRUCTION_IF;
    
    // IF_ID signals
    wire IF_ID_write; 
    wire[31:0] PC_ID, INSTRUCTION_ID;
    
    // ID signals
    wire RegWrite_WB;
    wire[4:0] RD_WB;
    
    wire[31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire[2:0] FUNCT3_ID;
    wire[6:0] FUNCT7_ID, OPCODE_ID;
    wire[4:0] RD_ID, RS1_ID, RS2_ID;
    wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID;
    wire[1:0] ALUop_ID;
    wire ALUSrc_ID, Branch_ID;
    
    // ID_EX signals
    wire write = 1'b1;
    wire[4:0] RD_EX, RS1_EX, RS2_EX;
    wire[31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX;
    wire[2:0] FUNCT3_EX;
    wire[6:0] FUNCT7_EX, OPCODE_EX;
    wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX;
    wire[1:0] ALUop_EX;
  
 
    // EX signals
    wire ZERO_EX;
    wire[31:0] ALU_OUT_MEM;
    wire[31:0] PC_Branch_EX, REG_DATA2_EX_FINAL;
    wire[4:0] RD_EX_OUT, RS1_EX_OUT;
    wire RegWrite_EX_OUT, MemtoReg_EX_OUT, MemRead_EX_OUT, MemWrite_EX_OUT, Branch_EX_OUT;
    wire[2:0] FUNCT3_EX_OUT;
    
    // EX_MEM signals
    wire RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM;
    wire[2:0] FUNCT3_MEM;
    wire ZERO_MEM;
    wire[31:0] REG_DATA2_MEM;
    wire[4:0] RD_MEM;

    // MEM signals
    wire Branch_MEM_OUT, RegWrite_MEM_OUT, MemtoReg_MEM_OUT;
    wire[31:0] ALU_OUT_MEM_OUT;
    wire[4:0] RD_MEM_OUT;
    
    // MEM_WB signals
    wire MemtoReg_WB;
    wire[31:0] DATA_MEMORY_WB, ALU_OUT_WB;

    ////////////////////////////////////////////////////////////////////////////////////////////
 
    //Stagiul IF
    IF IF_MODULE(clk, reset, PCSrc, PC_write, Branch_MEM, PC_IF, INSTRUCTION_IF);
       
    // Registrul IF_ID
    register_IF_ID IF_ID_REGISTER(clk, reset, IF_ID_write, PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);
            
            
    // Stagiul ID
    ID ID_MODULE(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, pipeline_stall,
     
                 IMM_ID, REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID, 
                 RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUop_ID, ALUSrc_ID, Branch_ID);
                 
            
    // Registrul ID_EX             
    ID_EX_reg ID_EX_REGISTER(clk, reset, write, RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUSrc_ID, Branch_ID, ALUop_ID,
                             PC_ID, REG_DATA1_ID, REG_DATA2_ID, IMM_ID,
                             FUNCT7_ID, FUNCT3_ID,
                             RS1_ID, RS2_ID, RD_ID,
         
                             RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX, ALUop_EX,
                             PC_EX, REG_DATA1_EX, REG_DATA2_EX, IMM_EX,
                             FUNCT7_EX, FUNCT3_EX,
                             RS1_EX, RS2_EX, RD_EX); 
     
    forwarding FORWARDING_UNIT(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_MEM, RegWrite_WB, forwardA, forwardB);                  
    hazard_detection HAZARD_DETECTION_UNIT(RD_EX, RS1_ID, RS2_ID, MemRead_EX, PC_write, IF_ID_write, pipeline_stall);
                                     
    // Stagiul EX
    EX EX_MODULE(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX, FUNCT3_EX, FUNCT7_EX, RD_EX, RS1_EX, RS2_EX,
                RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc_EX, Branch_EX,
                forwardA, forwardB, ALU_DATA_WB, ALU_OUT_MEM,
                
                ZERO_EX, ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL, RD_EX_OUT, RS1_EX_OUT, RegWrite_EX_OUT, MemtoReg_EX_OUT,
                MemRead_EX_OUT, MemWrite_EX_OUT, Branch_EX_OUT, FUNCT3_EX_OUT);
                
                        
    // Registrul EX_MEM
    ex_mem_pipe EX_MEM_REGISTER(clk, reset, write, RegWrite_EX_OUT, MemtoReg_EX_OUT, MemRead_EX_OUT, MemWrite_EX_OUT, 
                                Branch_EX_OUT, PC_Branch_EX, FUNCT3_EX_OUT, ALU_OUT_EX,
                                ZERO_EX, REG_DATA2_EX_FINAL, RD_EX_OUT,
                                
                                RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM, PC_MEM, FUNCT3_MEM,
                                ALU_OUT_MEM, ZERO_MEM, REG_DATA2_MEM, RD_MEM);
    
            
      
    // Stagiul MEM
    MEM MEM_MODULE(clk, ZERO_MEM, ALU_OUT_MEM, PC_MEM, REG_DATA2_MEM, RD_MEM, 
                   RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM, FUNCT3_MEM,
                   
                   PCSrc, RegWrite_MEM_OUT, MemtoReg_MEM_OUT, DATA_MEMORY_MEM, ALU_OUT_MEM_OUT, RD_MEM_OUT);
           
    
    // Registrul MEM_WB
    mem_wb_pipe MEM_WB_REGISTER(clk, reset, write, RegWrite_MEM_OUT, MemtoReg_MEM_OUT, DATA_MEMORY_MEM, ALU_OUT_MEM_OUT, RD_MEM_OUT,
    
                                RegWrite_WB, MemtoReg_WB, DATA_MEMORY_WB, ALU_OUT_WB, RD_WB);
                                        
   // Stagiul WB  

    WB WB_MODULE(DATA_MEMORY_WB, //Data_memory_out 
                        ALU_OUT_WB,   //ALU_out result
                        MemtoReg_WB,    //MemtoReg
                        ALU_DATA_WB);   


endmodule
