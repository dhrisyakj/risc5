`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 06:06:15 PM
// Design Name: 
// Module Name: top_module
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


module top_module #(
parameter IN_WIDTH =16,
parameter ACC_WIDTH =29
)(
 input wire clk,
 input wire rst,
 input wire [IN_WIDTH-1:0] a,
 input wire [IN_WIDTH-1:0] b,
 output reg [ACC_WIDTH-1:0] result
    );
    
    
// Instantiate the single cycle MAC

wire [ACC_WIDTH-1:0] mac_acc;
/*
mac_128 #(
.IN_WIDTH(IN_WIDTH),
.ACC_WIDTH(ACC_WIDTH)
) single_mac (
 .clk(clk),
 .acc_rst(rst),
 .a(a),
 .b(b),
 .acc(mac_acc)
 );
 */
 // Write the MAC Accumulator into result
 
 always @(posedge clk) begin   
  if(rst)
   result <= {ACC_WIDTH{1'b0}};
  else
   result <= mac_acc;
  end 
    
endmodule
