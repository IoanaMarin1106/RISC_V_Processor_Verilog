`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 04:25:40 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
    always @* begin
        case (ALUop)
        
            //R-type
            2'b10: begin
                
                //add
                if (funct7 == 7'b0000000 && funct3 == 3'b000) begin
                    ALUinput = 4'b0010;
                end
                
                //sub
                if (funct7 == 7'b0100000 && funct3 == 3'b000) begin
                    ALUinput = 4'b0110;
                end
                
                //and
                if (funct7 == 7'b0000000 && funct3 == 3'b111) begin
                    ALUinput = 4'b0000;
                end
                
                //or
                if (funct7 == 7'b0000000 && funct3 == 3'b110) begin
                    ALUinput = 4'b0001;
                end
                
                //xor
                if (funct7 == 7'b0000000 && funct3 == 3'b100) begin
                    ALUinput = 4'b0011;
                end
                
                //srl, srli
                if (funct7 == 7'b0000000 && funct3 == 3'b101) begin
                    ALUinput = 4'b0101;
                end
                
                //sll, slli
                if (funct7 == 7'b0000000 && funct3 == 3'b001) begin
                    ALUinput = 4'b0100;
                end
                
                //sra, srai
                if (funct7 == 7'b0100000 && funct3 == 3'b101) begin
                    ALUinput = 4'b1001;
                end
                
                //sltu
                if (funct7 == 7'b0000000 && funct3 == 3'b011) begin
                    ALUinput = 4'b0111;
                end
                
                //slt
                if (funct7 == 7'b0000000 && funct3 == 3'b010) begin
                    ALUinput = 4'b1000;
                end
            end
            
            //LD, SD
            2'b00: begin
                ALUinput = 4'b0010;
            end
            
            //BEQ
            2'b01: begin
            
                //beq, bne
                if (funct3 == 3'b000 || funct3 == 3'b001) begin
                    ALUinput = 4'b0110;
                end
                
                //blt, bge
                if (funct3 == 3'b100 || funct3 == 3'b101) begin
                    ALUinput = 4'b1000;
                end
                
                //bltu, bgeu
                if (funct3 == 3'b110 || funct3 == 3'b111) begin
                    ALUinput = 4'b0111;
                end  
            end           
        endcase
    end
endmodule
