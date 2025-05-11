`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2025 02:55:09 AM
// Design Name: 
// Module Name: pc
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


module pc (
    input wire         clk,      // Clock signal
    input wire         reset,    // Asynchronous reset signal
    input wire [15:0]  next_pc,  // Next PC value computed from PC+2, branch, or jump logic
    output reg [15:0]  pc        // Current PC value
);
/*
initial begin
   pc=16'b0;
end
*/
// Update the program counter on every rising clock edge or asynchronous reset.
always @(posedge clk or posedge reset) begin
    if (reset)
        pc <= 16'b0;       // Reset the PC to 0 when reset is high.
    else
        pc <= next_pc;     // Otherwise, update the PC with the next address.
end

endmodule
