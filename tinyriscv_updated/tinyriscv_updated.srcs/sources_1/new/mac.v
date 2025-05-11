`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2025 02:20:55 PM
// Design Name: 
// Module Name: mac
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


module mac#(
    parameter IN_WIDTH   = 32,
    parameter ACC_WIDTH  = 32 // No of bits for the accumulator = 39 
)(
    input clk,
    input  wire                      acc_rst,    //reset the accumulator
    input  wire [IN_WIDTH-1:0]       a,
    input  wire [IN_WIDTH-1:0]       b,
    output reg  [ACC_WIDTH-1:0]      acc
    //output reg  [ACC_WIDTH-1:0]      result
);

    wire [IN_WIDTH*2-1:0] product = a * b;
   
    always @(posedge clk) begin
        if (acc_rst) begin
            acc <= {ACC_WIDTH{1'b0}};
        end else begin
                acc <= acc + product; // Accumulation                
            end
        end
      
      /*  
    always @(posedge clk) begin   
      if(acc_rst)
       result <= {ACC_WIDTH{1'b0}};
     else
       result <= acc; // Writing the result of accumulation into a result
  end 
  */
endmodule

