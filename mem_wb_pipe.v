`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2020 06:06:45 PM
// Design Name: 
// Module Name: mem_wb_pipe
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


module mem_wb_pipe(input clk, reset, write,
                 input RegWrite_MEM, MemtoReg_MEM,
                 input[31:0] DATA_MEMORY_MEM,
                 input[31:0] ALU_OUT_MEM,
                 input[4:0] RD_MEM,
                      
                 output reg RegWrite_WB, MemtoReg_WB,
                 output reg [31:0] DATA_MEMORY_WB,
                 output reg [31:0] ALU_OUT_WB,
                 output reg [4:0] RD_WB);
                 
    always @(posedge clk) begin
        if (reset) begin
            RegWrite_WB <= 1'b0;
            MemtoReg_WB <= 1'b0;
            DATA_MEMORY_WB <= 32'b0;
            ALU_OUT_WB <= 32'b0;
            RD_WB <= 5'b0;
        end
        else begin
            if (write) begin
                RegWrite_WB <= RegWrite_MEM;
                MemtoReg_WB <= MemtoReg_MEM;
                DATA_MEMORY_WB <= DATA_MEMORY_MEM;
                ALU_OUT_WB <= ALU_OUT_MEM;
                RD_WB <= RD_MEM;
            end
        end
    end
endmodule
