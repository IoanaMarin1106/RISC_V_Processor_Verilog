`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 03:28:26 PM
// Design Name: 
// Module Name: verify_branch_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module verify_branch_module(
    input branch_mem,
    input zero_flag_mem,
    input [2:0] funct3_mem,
    input [31:0] alu_out_mem,
    output reg Branch_mem);
    
    
    always @* begin
        // Pentru a verifica ca avem instructiunile bne, beq
        // ne uitam la funct3 si zero_flag
        // bne
        
        if (branch_mem == 1'b1) begin
            if (funct3_mem == 3'b001) begin
                if (zero_flag_mem == 1'b0) begin
                    Branch_mem = 1'b1;
                end
                else begin
                    Branch_mem = 1'b0;
                end
            end
            
            else 
            // beq
            if (funct3_mem == 3'b000) begin
               if (zero_flag_mem == 1'b0) begin
                    Branch_mem = 1'b0;
                end
                else begin
                    Branch_mem = 1'b1;
                end
            end
            else
            // blt
            if (funct3_mem == 3'b100) begin
                if (alu_out_mem[31] == 1'b0) begin
                    Branch_mem = 1'b0;
                end
                else begin
                     Branch_mem = 1'b1;
                end
            end
            else
            //bge
            if (funct3_mem == 3'b101) begin
                if (alu_out_mem[31] == 1'b0) begin
                     Branch_mem = 1'b1;
                end
                else begin
                     Branch_mem = 1'b0;
                end
            end
         end
         else begin 
            Branch_mem = 1'b0;
         end
    end
        
endmodule
