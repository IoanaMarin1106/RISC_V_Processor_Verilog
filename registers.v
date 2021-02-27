`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 12:21:20 PM
// Design Name: 
// Module Name: registers
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


module registers(
    input clk, reg_write,
    input [4:0] read_reg1, read_reg2, write_reg,
    input [31:0] write_data,
    output [31:0] read_data1, read_data2);
    
    
    reg [31:0] codeMemory [0:31];
    
    integer k;
    initial begin
        for (k = 0; k < 32; k = k + 1) 
            codeMemory[k] = k;
    end
   
    reg [31:0] temp_data1;
    reg [31:0] temp_data2;
    
    always @*
    begin
        temp_data1 = codeMemory[read_reg1];
        temp_data2 = codeMemory[read_reg2];
    end
    
    assign read_data1 = temp_data1;
    assign read_data2 = temp_data2;
    
    always @(posedge clk)
    begin
        if (reg_write == 1)
            codeMemory[write_reg] = write_data;
    end
    
endmodule
