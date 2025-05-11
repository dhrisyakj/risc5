`timescale 1ns / 1ps

module adder_pc (
    input [15:0] pc_in,         // Input: Current PC value
    output [15:0] pc_out        // Output: Next PC value (PC + 2)
);
    assign pc_out = pc_in + 16'd2;
endmodule
