`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 03:34:21 PM
// Design Name: 
// Module Name: control_path
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


module control_path(input [6:0] opcode,
                    input control_sel,
                    output reg Branch, MemRead, MemtoReg, MemWrite, RegWrite, ALUSrc,
                    output reg [1:0] ALUop);
                    
     always @* begin
        if (control_sel == 1)
        begin
            MemRead <= 0;
            MemtoReg <= 0;
            MemWrite <= 0;
            RegWrite <= 0;
            Branch <= 0;
            ALUSrc <= 0;
            ALUop <= 2'b00;
        end
        else if (control_sel == 0)
        begin
           // switch in functie de opcode
           case (opcode)
           
           // adaugam un nop de la Instruction Set Arhitecture
           7'b0000000: begin
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                
                RegWrite <= 0;
                Branch <= 0;
                ALUSrc <= 0;
                ALUop <= 2'b00;
           end
           
           //format de tip R
           7'b0110011: begin
                ALUSrc <= 0;
                MemtoReg <= 0;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                Branch <= 0;
                ALUop <= 2'b10;
           end
           
           //LW
           7'b0000011: begin
                ALUSrc <= 1;
                MemtoReg <= 1;
                RegWrite <= 1;
                MemRead <= 1;
                MemWrite <= 0;
                Branch <= 0;
                ALUop <= 2'b00;     
           end
           
           //SW
           7'b0100011: begin
                ALUSrc <= 1;
                MemtoReg <= 1'bx;
                RegWrite <= 0;
                MemRead <= 0;
                MemWrite <= 1;
                Branch <= 0;
                ALUop <= 2'b00; 
           end
           
           //beq
           7'b1100011: begin
                ALUSrc <= 0;
                MemtoReg <= 1'bx;
                RegWrite <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                Branch <= 1;
                ALUop <= 2'b01;
           end
           
           //I-format = nu folosesc 2 operanzi registrii ca tipul R, folosesc un registru si
           //o valoare imediata deci semnalul ALUSrc va trimite o valoare imediata
           // si va fi setat pe 1
           7'b0010011: begin
                ALUSrc <= 1;
                MemtoReg <= 0;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                Branch <= 0;
                ALUop <= 2'b10;
           end
           endcase
        end
    end
endmodule
