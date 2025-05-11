`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2025 08:09:01 AM
// Design Name: 
// Module Name: sign_extension
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


module sign_extension #(
   parameter WIDTH =4,
   parameter BIT_W =12
    )(
    input [WIDTH-1:0] in,
    output [15:0] out
    );
    
    //always @(*) begin
    assign out = {{BIT_W{in[WIDTH-1]}},in};
   // end
    
endmodule
