`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2025 05:59:17 PM
// Design Name: 
// Module Name: mac_unit_tb
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


module mac_unit_tb;
parameter N = 3;
    parameter WIDTH = 16;

    reg clk;
    reg start;
    reg [N*WIDTH-1:0] inputs_flat;
    reg [N*WIDTH-1:0] coeffs_flat;
    wire [2*WIDTH-1:0] result;
    wire done;

    mac_unit #(N, WIDTH) uut (
        .clk(clk),
        .start(start),
        .inputs_flat(inputs_flat),
        .coeffs_flat(coeffs_flat),
        .result(result),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        start = 0;

        // Pack inputs: inputs[0]=1, inputs[1]=2, inputs[2]=3
        inputs_flat = {16'd3, 16'd2, 16'd1};
        coeffs_flat = {16'd30, 16'd15, 16'd1};

        #10 start = 1;
        #10 start = 0;

        #20;
        $display("MAC Result: %d", result);

        $finish;
    end



endmodule
