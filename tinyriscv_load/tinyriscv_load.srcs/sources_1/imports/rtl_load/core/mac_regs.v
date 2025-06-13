`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2025 10:46:47 AM
// Design Name: 
// Module Name: mac_regs
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
`include "defines.v"

module dsp_config(

input wire clk,
input wire rst,
input wire we1_i,                           
input wire[`RegBus] w1data_i,
output reg[`RegBus] mac_count_o        
);
    
reg[`RegBus] mac_count;

//Write the count to mac_count register
always @ (posedge clk) begin
   if (rst == `RstDisable) begin
      if ((we1_i == `WriteEnable)) begin
          mac_count <= w1data_i;
       end
   end
   end
     
//Read the count value
always @ (*) begin
     mac_count_o = mac_count;
end
   
endmodule
