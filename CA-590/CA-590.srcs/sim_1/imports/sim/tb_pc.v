`timescale 1ns / 1ps

module tb_pc;

    // Declare testbench signals
    reg clk;
    reg reset;
    reg [15:0] next_pc;
    wire [15:0] pc;

    // Instantiate the PC module
    pc uut (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus block to test the PC
    initial begin
        // Initialize signals
        reset = 1;
        next_pc = 16'h0002;
        #10;           // Wait 10ns

        reset = 0;     // Release reset
        #10;           // Wait for next clock

        // Test sequential update: pc should now be next_pc (2)
        next_pc = 16'h0004;
        #10;

        next_pc = 16'h0006;
        #10;

        // Assert reset again
        reset = 1;
        #10;
        reset = 0;
        next_pc = 16'h0008;
        #10;

        // End simulation
        $stop;
    end

endmodule
