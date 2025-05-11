`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 02:42:42 PM
// Design Name: 
// Module Name: mac_v2
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


module mac_v2 #(
    parameter IN_WIDTH    = 16,
    parameter COUNT_BITS = 7,
    parameter ACC_WIDTH   = 39 // fixing the aacumulator to 39 for now
)(
    input  wire                     clk,
    input  wire                     acc_rst,         
    input  wire [COUNT_BITS-1:0]    mac_count,   // No of macs to perform
    input  wire [IN_WIDTH-1:0]      a,
    input  wire [IN_WIDTH-1:0]      b,
    output reg  [ACC_WIDTH-1:0]     acc          // accumulator output
);
    // Internal cycle counter
    reg [COUNT_BITS-1:0] count;

    // Multiply inputs
    wire [2*IN_WIDTH-1:0] product = a * b;

    always @(posedge clk) begin
        if (acc_rst) begin
            acc   <= {ACC_WIDTH{1'b0}};
            count <= {COUNT_BITS{1'b0}};
        end else begin
            if (count == mac_count - 1) begin // Resets the accumulator and the counter bits to zero 
                acc   <= {ACC_WIDTH{1'b0}};
                count <= {COUNT_BITS{1'b0}};
            end else begin
                acc   <= acc + product; //Accumulation
                count <= count + 1;
            end
        end
    end

  
endmodule
