`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 08:24:11 PM
// Design Name: 
// Module Name: register_IF_ID
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


module register_IF_ID(
    input clk,
    input reset,
    input write,
    input [31:0] PC_OUT,
    input [31:0] IM_OUT,
    output reg [31:0] PC_REG_OUT,
    output reg [31:0] IM_REG_OUT);
    
    always @(posedge clk)
    begin
        if (reset) begin
            PC_REG_OUT <= 0;
            IM_REG_OUT <= 0;
        end 
        else if (write) begin
            PC_REG_OUT <= PC_OUT;
            IM_REG_OUT <= IM_OUT;
        end
    end
endmodule
