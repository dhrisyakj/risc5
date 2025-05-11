//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2025 08:41:24 AM
// Design Name: 
// Module Name: is_zero
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


module is_zero(
  input [15:0] aluResult,
  output reg is_z
    );
  
  reg result;
  
  always @(*) begin
    
    is_z = (aluResult ==16'b0);
   end  
    
    
    
 
endmodule
