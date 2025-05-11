`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 08:31:11 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [15:0] a,      //  operand a
    input [15:0] b,      // operand b
    input [2:0] opcode,  // 3-bit opcode for selecting the operation
    output reg [15:0] outALU 
);

    // Intermediate result wire
    reg [15:0] result;  

    always @(*) begin

        // Select the operation based on the opcode
        case (opcode)
            3'b000: result = a + b;        // add
            3'b001: result = a - b;        // sub
            3'b010: result = b << a[3:0];  // sll (shift left)
            3'b011: result = a & b;        // and
            default: result = 16'b0;       // default case 
        endcase

        // result given to outALU
        outALU = result;

    end
endmodule
