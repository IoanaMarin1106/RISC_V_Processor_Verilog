`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 05:07:25 PM
// Design Name: 
// Module Name: mux41
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


module mux4_1(
    input [31:0] ina, inb, inc, ind,
    input sel0, sel1,
    output [31:0] out
    );
    
    assign out = sel1 ? (sel0 ? ind : inc) : (sel0 ? inb : ina);
    
endmodule
