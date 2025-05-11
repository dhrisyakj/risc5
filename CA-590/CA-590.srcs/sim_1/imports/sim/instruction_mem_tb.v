`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 01:52:13 PM
// Design Name: 
// Module Name: instruction_mem_tb
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


module instruction_mem_tb();
  reg [15:0] PC;
  wire [15:0] instr;
  
   instruction_mem uut (
   .PC(PC),
   .instr(instr)
   );
   
   initial begin
  
   PC = 16'd0;
   #10;
   PC = 16'd2;
   #10;
   PC = 16'd10;
   #10;
   PC = 16'd4;
   
   #20;
   
   $finish;
   end
   
      
endmodule
