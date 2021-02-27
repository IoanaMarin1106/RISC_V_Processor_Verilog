`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2020 05:04:54 PM
// Design Name: 
// Module Name: IF
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


module IF(
    input clk, reset,
    input PCSrc, PC_write,
    input [31:0] PC_Branch,
    output [31:0] PC_IF, INSTRUCTION_IF);
   
    wire[31:0] muxInput;
    adder add(PC_IF, 4, muxInput);
    
    wire[31:0] PCinput;
    mux2_1 mux21(PC_Branch, muxInput, PCSrc, PCinput);
    
    PC program_counter(clk, reset, PC_write, PCinput, PC_IF);
    instruction_memory instr_mem(PC_IF[11:2], INSTRUCTION_IF);
    
endmodule
