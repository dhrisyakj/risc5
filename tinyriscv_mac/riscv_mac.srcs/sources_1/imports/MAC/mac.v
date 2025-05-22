`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 11:31:00 AM
// Design Name: 
// Module Name: mac_128
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


module mac_128 #(
    parameter IN_WIDTH   = 32,
    parameter ACC_WIDTH  = 32 
)(
    input clk,
    input  wire                      acc_rst,    //reset the accumulator
    input wire valid,
    input  wire [IN_WIDTH-1:0]       a,
    input  wire [IN_WIDTH-1:0]       b,
    output reg  [ACC_WIDTH-1:0]      acc
   // output reg done
    //output reg  [ACC_WIDTH-1:0]    count
);

    wire [IN_WIDTH:0] product = a * b;
    reg [ACC_WIDTH-1:0]     result;
    
    always @(posedge clk) begin
        //done<=1'b0;
        if (!acc_rst) begin
            acc <= {ACC_WIDTH{1'b0}};
        end else begin
        if(valid) begin
                acc <= acc + product; // Accumulation
               // done <= 1'b1;
             end                  
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

