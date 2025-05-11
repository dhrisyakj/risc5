`timescale 1ns / 1ps

module adder_branch (
    input [15:0] pc_in,         // Input: Current PC value
    input [15:0] imm_shifted,   // Input: Immediate value shifted left by 1
    output [15:0] branch_target // Output: Branch target address
);
    assign branch_target = pc_in + imm_shifted;
endmodule
