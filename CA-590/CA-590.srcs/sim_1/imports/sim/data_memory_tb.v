`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 04:06:47 PM
// Design Name: 
// Module Name: data_memory_tb
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


module data_memory_tb();
  reg clk,memWrite,memRead;
  //,memRead;
  reg [15:0] memAddr,data;
  wire [15:0] readData;
  
  data_memory uut(
  .clk(clk),
  .memWrite(memWrite),
  .memRead(memRead),
  //.memRead(memRead),
  .memAddr(memAddr),
  .data(data),
  .readData(readData)
  );
  
  initial begin
   clk=0;
   forever #10 clk =~clk;
  end
  
  initial begin
  memWrite=0;
  data=16'd20;
  memRead=1;
  memAddr=16'd0;
  
  #10;
  memWrite=1;
  memRead=0;
  
  
  #10;
  memRead=1;
  memWrite=0;
  memAddr=16'd0;
  
  #10;
  memWrite=1;
  memRead=1;
  memAddr=16'd0;
  data=16'd5;
 
 #30;
 $finish;
  end
  
  
endmodule
