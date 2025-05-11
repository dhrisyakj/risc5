`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2025 08:44:45 AM
// Design Name: 
// Module Name: is_zero_tb
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


module is_zero_tb();
 
 reg [15:0] aluResult;
 wire is_z;
 
 is_zero uut (
 .aluResult(aluResult),
 .is_z(is_z)
 );
 
 initial begin
 #10;
 aluResult=16'h0002;
 
 #10;
 aluResult=16'd0;
 
  #10;
 aluResult=16'hffff;
 
 
 end
endmodule
