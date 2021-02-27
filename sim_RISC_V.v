`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 07:29:29 PM
// Design Name: 
// Module Name: sim_RISC_V
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


module sim_RISC_V();
  reg clk,reset;
  wire[31:0] PC_EX;
  wire[31:0] ALU_OUT_EX;
  wire[31:0] PC_MEM;
  wire PCSrc;
  wire[31:0] DATA_MEMORY_MEM;
  wire[31:0] ALU_DATA_WB;
  wire[1:0] forwardA, forwardB;
  wire pipeline_stall;
  
  RISC_V RV(clk, reset, PC_EX, ALU_OUT_EX, PC_MEM, PCSrc, DATA_MEMORY_MEM, ALU_DATA_WB, forwardA, forwardB, pipeline_stall);
  
  always #5 clk=~clk;
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
    #10 reset=1'b0;
    #1000 $finish;
  end
endmodule
