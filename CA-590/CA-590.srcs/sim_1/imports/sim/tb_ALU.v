`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 08:52:08 PM
// Design Name: 
// Module Name: tb_ALU
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

module tb_ALU();
    // Declare inputs to the ALU module
    reg [15:0] a;
    reg [15:0] b;
    reg [2:0] opcode;

    // Declare output from the ALU module
    wire [15:0] outALU;
    // Instantiate the ALU module
    ALU alu_inst (
        .a(a),
        .b(b),
        .opcode(opcode),
        .outALU(outALU)
    );

    // Apply stimulus to the ALU and check the outputs
    initial begin
        // Test 1: Add operation (opcode = 3'b000)
        a = 16'h0005; b = 16'h0003; opcode = 3'b000;  // Expected: outALU = 8
        #10; // Wait for 10 time units

        // Test 2: Subtract operation (opcode = 3'b001)
        a = 16'h0005; b = 16'h0003; opcode = 3'b001;  // Expected: outALU = 2
        #10;

        // Test 3: Shift Left operation (opcode = 3'b010)
        a = 16'h0002; b = 16'h0001; opcode = 3'b010;  // Expected: outALU = 16'h0010 (shift left by 3)
        #10;

        // Test 4: Bitwise AND operation (opcode = 3'b011)
        a = 16'h0002; b = 16'h0001; opcode = 3'b011;  // Expected: outALU = 16'h000F (bitwise AND)
        #10;

        // Test 5: Default case (invalid opcode)
        a = 16'h0001; b = 16'h0002; opcode = 3'b100;  // Expected: outALU = 0 (default case)
        #10;

        // Test 6: Add operation with zero (opcode = 3'b000)
        a = 16'h0000; b = 16'h0005; opcode = 3'b000;  // Expected: outALU = 5
        #10;

        // Test 7: Subtract operation with zero (opcode = 3'b001)
        a = 16'h0000; b = 16'h0005; opcode = 3'b001;  // Expected: outALU = -5 (in 2's complement: 16'hFFFB)
        #10;

        // Test 8: Shift Left by zero (opcode = 3'b010)
        a = 16'h0001; b = 16'h0000; opcode = 3'b010;  // Expected: outALU = 1 (no shift)
        #10;

        // Test 9: AND operation with zero (opcode = 3'b011)
        a = 16'h0002; b = 16'h0000; opcode = 3'b011;  // Expected: outALU = 0
        #10;

        // Test 10: Subtract operation where a < b (opcode = 3'b001)
        a = 16'h0003; b = 16'h0005; opcode = 3'b001;  // Expected: outALU = -2 (16'hFFFE)
        #10;

        // End the simulation
        $finish;
    end
    // Display the results to check the ALU output
    initial begin
        $monitor("Time: %0t | a: %h | b: %h | opcode: %b | outALU: %h", $time, a, b, opcode, outALU);
    end

endmodule