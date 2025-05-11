//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 01:17:49 PM
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem(
   input [15:0] PC,
   output reg [15:0] instr
    );                                
 
 // Byte Addressable memory
 reg [7:0] instr_mem [127:0];  
 
 
 initial begin
 instr_mem[0]=8'b0001_0001; //LW S1 S2 2
 instr_mem[1]=8'b0000_0010;
 instr_mem[2]=8'b0010_0100; // SW S4 S1 4
 instr_mem[3]=8'b0001_0100;
 instr_mem[4]=8'b0000_0001; //ADD S1 S2
 instr_mem[5]=8'b0010_0000;
 instr_mem[6]=8'b0000_0011; // SUB S3 S1
 instr_mem[7]=8'b0001_0001;
 instr_mem[8]=8'b0000_0101; // SLL S5 S2
 instr_mem[9]=8'b0010_0010;
 instr_mem[10]=8'b0000_0100; // AND S4 S5
 instr_mem[11]=8'b0101_0011;
 instr_mem[12]=8'b0011_1001; // ADDI S9 S6 2
 instr_mem[13]=8'b0110_0010;
 instr_mem[14]=8'b0100_0110;  // BEQ S6 S7 2
 instr_mem[15]=8'b0111_0010; 
 instr_mem[16]=8'b0000_0001; // ADD S1 S0  skipped
 instr_mem[17]=8'b0000_0000;
 instr_mem[18]=8'b0000_0010; // SUB S2 S0  skipped
 instr_mem[19]=8'b0000_0001;
 instr_mem[20]=8'b0000_1001; // ADD S9 S10
 instr_mem[21]=8'b1010_0000;
 instr_mem[22]=8'b0101_0110; // BNE S6 S8 1
 instr_mem[23]=8'b1000_0001;
 instr_mem[24]=8'b0000_0001; // ADD S1 S0   skipped
 instr_mem[25]=8'b0000_0000;
 instr_mem[26]=8'b0000_1010; // ADD S10 S11
 instr_mem[27]=8'b1011_0000;
 instr_mem[28]=8'b0110_1111; // jump -13 // Jump to 3rd instruction
 instr_mem[29]=8'b1111_0011;
 end
 
 
  always @(*) begin
    instr = {instr_mem[PC],instr_mem[PC+1]};
   
  end
      
endmodule
