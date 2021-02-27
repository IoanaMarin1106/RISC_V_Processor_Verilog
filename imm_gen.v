`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 12:51:12 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(
    input [31:0] in,
    output reg [31:0] out);
    
    integer k;
  
    always @* begin
        // Daca opcode ul e pentru o instructiune de tip I (001011)
        // ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLI, SRLI, SRAI
        if (7'b0010011 == in[6:0]) 
        begin
           
            out[31:11] = {21{in[31]}};
            
            out[10:5] = in[30:25];
            out[4:1] = in[24:21];
            out[0] = in[20];
        end
        
        //Daca opcode ul e pentru o instructiune de tip I dar are
        // opcode 0000011 (LW)
        else if (7'b0000011 == in[6:0]) 
        begin
           
            out[31:11] = {21{in[31]}};
  
            out[10:5] = in[30:25];
            out[4:1] = in[24:21];
            out[0] = in[20];
        end
        
        // Daca opcode e 0100011 (SW) -> de tip S 
        else if (7'b0100011 == in[6:0])
        begin 
            
            out[31:11] = {21{in[31]}};
            
            out[10:5] = in[30:25];
            out[4:1] = in[11:8];
            out[0] = in[7];
        end
        
        // Daca opcode e 0100011 (BEQ, BNE..) -> B-type
        else if (7'b1100011 == in[6:0])
        begin 
           
            out[31:12] = {20{in[31]}};
            out[11] = in[7];
            out[10:5] = in[30:25];
            out[4:1] = in[11:8];
            out[0] = 1'b0;
        end 
        // Daca opcode ul este al unei instructiuni de tip R
        else if (7'b0110011 == in[6:0]) // instr de tip R nu au imm_gen
            out = 0;
        // altfel, default, scoatem la iesire ce am primit la intrare
        else out = in;
    end
endmodule
