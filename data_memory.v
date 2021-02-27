`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 02:55:14 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,       
                   input mem_read, //asincron
                   input mem_write, //sincron
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
                   
   reg[9:0] new_address;
   reg [31:0] codeMemory [0:1023];
   integer i;
    
   initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            codeMemory[i] = 32'b0;
        end
   end
   
   //  asincron
   always @* begin
        new_address = address[11:2];
        
        if (mem_read == 1) begin
              read_data = codeMemory[new_address];  
        end
   end  
   
   // sincron
   always @(posedge clk) begin
        new_address = address[11:2];
        
        if (mem_write == 1) begin
            codeMemory[new_address] = write_data;
        end
   end      
                   
           
endmodule
