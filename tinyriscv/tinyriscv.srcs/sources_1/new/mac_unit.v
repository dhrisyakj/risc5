`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2025 05:57:57 PM
// Design Name: 
// Module Name: mac_unit
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


module mac_unit
#(
    parameter N = 3,
    parameter WIDTH = 16
)(
    input clk,
    input start,
    input [N*WIDTH-1:0] inputs_flat,
    input [N*WIDTH-1:0] coeffs_flat,
    output reg [2*WIDTH-1:0] result,
    output reg done
);

    integer i;
    reg [WIDTH-1:0] inputs [0:N-1];
    reg [WIDTH-1:0] coeffs [0:N-1];
    reg [2*WIDTH-1:0] acc;

    always @(*) begin
        // Unpack flat vectors into arrays
        for (i = 0; i < N; i = i + 1) begin
            inputs[i] = inputs_flat[i*WIDTH +: WIDTH];
            coeffs[i] = coeffs_flat[i*WIDTH +: WIDTH];
        end
    end

    always @(posedge clk) begin
        if (start) begin
            acc = 0;
            for (i = 0; i < N; i = i + 1) begin
                acc = acc + inputs[i] * coeffs[i];
            end
            result <= acc;
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
