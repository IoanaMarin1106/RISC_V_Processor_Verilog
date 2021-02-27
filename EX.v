`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 04:17:18 PM
// Design Name: 
// Module Name: EX
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

module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX, 
          input [31:0] REG_DATA2_EX, 
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA, forwardB, 
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL,
          
          
          // propagate in stagiile urmatoare de pipe
          output [4:0] RD_EX_OUT,
          output [4:0] RS1_EX_OUT,
          output RegWrite_EX_OUT,
          output MemtoReg_EX_OUT,
          output MemRead_EX_OUT,
          output MemWrite_EX_OUT,
          output Branch_EX_OUT,
          output[2:0] FUNCT3_EX_OUT
          );
  
      wire[31:0] MUX_A_EX_OUT, MUX_B_EX_OUT;
      wire[3:0] ALU_control;
      wire[31:0] RS2_IMM_EX;
      
      // MUX_A  
      mux4_1 MUX_FORWARD_A(REG_DATA1_EX,   
                          ALU_DATA_WB, 
                          ALU_OUT_MEM,   
                          32'b0, // nu e folosit
                          forwardA[0], forwardA[1], 
                          MUX_A_EX_OUT);
      // MUX_B
      mux4_1 MUX_FORWARD_B(REG_DATA2_EX,    
                          ALU_DATA_WB, 
                          ALU_OUT_MEM,   
                          32'b0, // nu e folosit 
                          forwardB[0], forwardB[1], 
                          MUX_B_EX_OUT); 
                          
      // Mux21                 
      mux2_1 MUX_RS2_IMM(IMM_EX, 
                        MUX_B_EX_OUT,     
                        ALUSrc_EX,     
                        RS2_IMM_EX); 
                          
      //ALUcontrol                   
      ALUcontrol ALU_CONTROL_MODULE(ALUop_EX,    
                                   FUNCT7_EX,    
                                   FUNCT3_EX,   
                                   ALU_control); 
      // ALU
      ALU ALU_MODULE(ALU_control,
                     MUX_A_EX_OUT, 
                     RS2_IMM_EX,
                     ZERO_EX, 
                     ALU_OUT_EX);
                                   
      // Adder
      adder ADDER_IMM_EX(PC_EX,    
                         IMM_EX, 
                         PC_Branch_EX);
       
      // Valorile propagate               
      assign REG_DATA2_EX_FINAL = MUX_B_EX_OUT;
      assign RD_EX_OUT = RD_EX;
      assign RS1_EX_OUT = RS1_EX;
      assign RegWrite_EX_OUT = RegWrite_EX;
      assign MemtoReg_EX_OUT = MemtoReg_EX;
      assign MemRead_EX_OUT = MemRead_EX;
      assign MemWrite_EX_OUT = MemWrite_EX;
      assign Branch_EX_OUT = Branch_EX;
      assign FUNCT3_EX_OUT = FUNCT3_EX;
           
endmodule
