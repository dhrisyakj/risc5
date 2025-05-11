`timescale 1ns / 1ps

module adder_tb;
    // Inputs for PC Increment Adder
    reg [15:0] pc_in;
    wire [15:0] pc_out;

    // Inputs for Branch Target Adder
    reg [15:0] imm_shifted;
    wire [15:0] branch_target;

    // Instantiate PC Increment Adder
    adder_pc pc_adder (
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Instantiate Branch Target Adder
    adder_branch branch_adder (
        .pc_in(pc_in),
        .imm_shifted(imm_shifted),
        .branch_target(branch_target)
    );

    // Test logic
    initial begin
        // Test 1: Increment PC by 2
        pc_in = 16'h0000;
        imm_shifted = 16'h0000; // No branch
        #10;
        $display("Test 1: PC = %h, PC_out = %h (Expected: 0002)", pc_in, pc_out);
        
        // Test 2: Increment PC by 2 again
        pc_in = 16'h0002;
        #10;
        $display("Test 2: PC = %h, PC_out = %h (Expected: 0004)", pc_in, pc_out);

        // Test 3: Branch Target Address with offset 4 (shifted left by 1)
        pc_in = 16'h0010;
        imm_shifted = 16'h0008; // Offset shifted left by 1
        #10;
        $display("Test 3: PC = %h, Branch_Target = %h (Expected: 0018)", pc_in, branch_target);

        // Test 4: Branch Target Address with offset 6 (shifted left by 1)
        pc_in = 16'h0020;
        imm_shifted = 16'h000C;
        #10;
        $display("Test 4: PC = %h, Branch_Target = %h (Expected: 002C)", pc_in, branch_target);

        // Test 5: PC Increment with a higher value
        pc_in = 16'h00F0;
        #10;
        $display("Test 5: PC = %h, PC_out = %h (Expected: 00F2)", pc_in, pc_out);

        // End simulation
        #10 $finish;
    end
endmodule
