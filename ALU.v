`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 04:58:25 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop,
           input [31:0] ina,inb,
           output zero,
           output reg [31:0] out);
           
   reg zero_flag = 1'b0;
 
    always @* begin
        case (ALUop)
           
           //LD, SD, add
           4'b0010: begin
                out = ina + inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                else begin
                    zero_flag = 1'b0;
                end
           end 
           
           //sub
           4'b0110: begin 
                out = ina - inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                else begin
                    zero_flag = 1'b0;
                end
           end
           
           //and
           4'b0000: begin
                out = ina & inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                else begin
                    zero_flag = 1'b0;
                end
           end
           
           //or
           4'b0001: begin
                out = ina | inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                else begin
                    zero_flag = 1'b0;
                end
           end
           
           //xor
           4'b0011: begin
                out = ina ^ inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                else begin
                    zero_flag = 1'b0;
                end
           end
           
           //srl, srli
           4'b0101: begin
                out = ina >> inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                else begin
                    zero_flag = 1'b0;
                end
           end
           
           //sll, slli
           4'b0100: begin
                out = ina << inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                 else begin
                    zero_flag = 1'b0;
                end
           end
           
           //sra, srai
           4'b1001: begin
                out = ina >>> inb;
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                 else begin
                    zero_flag = 1'b0;
                end
           end
           
           //sltu
           4'b0111: begin
                if (ina < inb) begin
                    out = 1;
                end 
                else begin
                    out = 32'b0;
                end
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                 else begin
                    zero_flag = 1'b0;
                end
           end
           
           //slt
           4'b1000: begin
                if (ina < inb) begin
                    out = 1;
                end 
                else begin
                    out = 32'b0;
                end
                
                if (out == 32'b0) begin
                    zero_flag = 1'b1;
                end
                 else begin
                    zero_flag = 1'b0;
                end
           end        
        endcase
    end  
    
    assign zero = zero_flag;   
endmodule
