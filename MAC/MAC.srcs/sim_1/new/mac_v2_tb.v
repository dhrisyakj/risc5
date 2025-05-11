`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 02:52:47 PM
// Design Name: 
// Module Name: mac_v2_tb
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


module mac_v2_tb();
// Parameters
    localparam IN_WIDTH    = 16;
    localparam MAX_COUNT   = 255;
    localparam COUNT_BITS  = $clog2(MAX_COUNT+1);
    localparam ACC_WIDTH   = 2*IN_WIDTH + COUNT_BITS;

    // Signals
    reg                      clk = 0;
    reg                      rst;
    reg  [COUNT_BITS-1:0]    threshold;
    reg  [IN_WIDTH-1:0]      a, b;
    wire [ACC_WIDTH-1:0]     acc;

    // Instantiate DUT
    mac_v2 #(
        .IN_WIDTH  (IN_WIDTH),
        .MAX_COUNT (MAX_COUNT)
    ) dut (
        .clk       (clk),
        .acc_rst       (rst),
        .mac_count(threshold),
        .a         (a),
        .b         (b),
        .acc       (acc)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    integer i;
    reg [ACC_WIDTH-1:0] expected;

    task run_test;
        input [COUNT_BITS-1:0] th;
        input [IN_WIDTH-1:0]   aval;
        input [IN_WIDTH-1:0]   bval;
        begin
            // Apply reset
            rst = 1; #10;
            rst = 0;

            threshold = th;
            a = aval; b = bval;
            expected = 0;

            // Run for th cycles and calculate expected
            for (i = 0; i < th; i = i + 1) begin
                #10;
                expected = expected + a * b;
            end

            // Next cycle should reset acc, so acc==0
            #10;
            if (acc !== 0)
                $display("FAIL: threshold=%0d a=%0d b=%0d, acc not reset, acc=%0d", th, a, b, acc);
            else
                $display("PASS: threshold=%0d a=%0d b=%0d, acc reset as expected", th, a, b);
        end
    endtask

    initial begin
        // Test various thresholds
        run_test(8'd5, 16'd2, 16'd3);
        run_test(8'd10, 16'd1, 16'd1);
        run_test(8'd12, 16'd4, 16'd5);

        $display("All dynamic threshold tests completed.");
        $finish;
    end


endmodule
