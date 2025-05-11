`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 03:56:17 PM
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


module data_memory(
input clk,memWrite,memRead,
input [15:0] memAddr,data,
output reg [15:0] readData
 );
 
 // Byte Addressable Memory
reg [7:0] data_mem [127:0];

initial begin
  data_mem[0] = 8'b0000_0000; // 10
  data_mem[1] = 8'b0000_1010;
  data_mem[2] = 8'b0000_0000; // 2
  data_mem[3] = 8'b0000_0010;
  data_mem[4] = 8'b0000_0000; // 4 
  data_mem[5] = 8'b0000_0100;
  data_mem[6] = 8'b0000_0000; // 3 
  data_mem[7] = 8'b0000_0011;
  data_mem[8] = 8'b0000_0000; // 6
  data_mem[9] = 8'b0000_0110;
  data_mem[10] = 8'b0000_0000; // 7
  data_mem[11] = 8'b0000_0111;
  data_mem[12] = 8'b0000_0000; // 3 
  data_mem[13] = 8'b0000_0011;
 end


always @(*) begin
 if(memRead)
  readData = {data_mem[memAddr],data_mem[memAddr+1]};
  else
  readData =16'b0; // Default to zero 
end

always @(posedge clk) begin
    if(memWrite) begin
       data_mem[memAddr] <= data[15:8];
       data_mem[memAddr+1] <= data[7:0];
       end
   end
endmodule
