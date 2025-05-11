`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2025 08:18:14 AM
// Design Name: 
// Module Name: sign_extension_tb
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


module sign_extension_tb();

   reg [3:0] in;
   wire [15:0] out;
   
   reg [11:0] in_a;
   wire [15:0] out_a;
   
   sign_extension #(.WIDTH(4),.BIT_W(12)) sign_4_16(
    .in(in),
    .out(out)
   );
   
    sign_extension #(.WIDTH(12),.BIT_W(4)) sign_12_16(
    .in(in_a),
    .out(out_a)
   );
   
   initial begin
   // Testing only sign_4_16
   in_a=12'b0;
   in =4'b1000;
   
   #10;
   //Testing only sign_12_16
   in_a = 12'd2;
   in =4'b0;
   
   #10;
   // Testing both sign_4_16 and sign_12_16
   in =4'b1100;
   in_a=12'd20;
   
   
   #10;
   $stop;
   
   end
   
   
   
endmodule
