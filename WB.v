`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2021 10:09:19 AM
// Design Name: 
// Module Name: WB
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


module WB(
    input [31:0] DATA_MEMORY_WB, ALU_OUT_WB,  
    input MemtoReg_WB,
    output [31:0] ALU_DATA_WB);
    
    reg [31:0] RESULT_WB;
    
    always @* begin
        if (MemtoReg_WB) begin
           RESULT_WB = DATA_MEMORY_WB;
        end
        else begin
            RESULT_WB = ALU_OUT_WB;
        end
   end 
   
   assign ALU_DATA_WB = RESULT_WB;
endmodule
