`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 07:03:17 PM
// Design Name: 
// Module Name: log_adder
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
`include "defines.v"

module pipelined_logadder(
    input         clk,         // System clock
    input         rst,         // Synchronous reset (active high)
    input  valid_in,    // Indicates that a new set of numbers is available
    input  [2047:0] data_in,   // Packed 64 numbers (64 x 32-bit = 2048 bits)
    output reg    valid_out,   // Indicates that the output sum is valid
    output reg [31:0] sum,  // Final 32-bit sum
    output wire  log_busy       
);

    // Extract each 32-bit number from the wide bus.
    // The following generate block creates 64 wires, each 32 bits wide.
    
    wire [31:0] in_arr [0:63];
    reg valid;
    
   // assign valid=1'b1;
    //initial begin
    //valid <=valid_in;
    //end
    //assign valid = valid_in;
    genvar j;
    generate
        for (j = 0; j < 64; j = j + 1) begin : extract
            // [32*j+31 -: 32] extracts 32 bits starting at bit (32*j+31)
            assign in_arr[j] = data_in[32*j+31 -: 32];
        end
    endgenerate
   

    // Pipeline registers for each level of the adder tree.
    // Stage 1: 64 numbers → 32 sums
    reg [31:0] stage1 [0:31];
    // Stage 2: 32 numbers → 16 sums
    reg [31:0] stage2 [0:15];
    // Stage 3: 16 numbers → 8 sums
    reg [31:0] stage3 [0:7];
    // Stage 4: 8 numbers → 4 sums
    reg [31:0] stage4 [0:3];
    // Stage 5: 4 numbers → 2 sums
    reg [31:0] stage5 [0:1];
    // Stage 6: 2 numbers → 1 sum
    reg [31:0] stage6;

    // Pipeline valid signals to track when the data in each stage is valid.
    reg valid_stage1, valid_stage2, valid_stage3, valid_stage4, valid_stage5, valid_stage6;
    reg start;
    
    assign log_busy = ( valid_stage1|| valid_stage2 ||valid_stage3|| valid_stage4 ||valid_stage5);
   //assign start <= valid_in;
   /*
   always @(*) begin
   if(valid_in == 1'b1)
     assign start = 1'b1;
    end
    */
    integer i;

    // -------------------------------
    // Stage 1: Process 64 → 32 numbers
    // -------------------------------
    always @(posedge clk) begin
        if (rst) begin
            valid_stage1 <= 1'b0;
            for (i = 0; i < 32; i = i + 1)
                stage1[i] <= 32'b0;
        end else if (valid_in) begin
            valid_stage1 <= valid_in;
            valid<=valid_in;
           
            end
            if(valid) begin
            //log_busy =1'b1;
            for (i = 0; i < 32; i = i + 1) begin
                stage1[i] <= in_arr[2*i] + in_arr[2*i+1];
                end
             valid =1'b0;
        end else begin
            valid_stage1 <= 1'b0;
        end
       //valid_in =1'b0;
    end

    // -------------------------------
    // Stage 2: Process 32 → 16 numbers
    // -------------------------------
    always @(posedge clk) begin
        if (rst) begin
            valid_stage2 <= 1'b0;
            for (i = 0; i < 16; i = i + 1)
                stage2[i] <= 32'b0;
        end else begin
            valid_stage2 <= valid_stage1;
            //log_busy =1'b1;
            for (i = 0; i < 16; i = i + 1)
                stage2[i] <= stage1[2*i] + stage1[2*i+1];
        end
    end

    // -------------------------------
    // Stage 3: Process 16 → 8 numbers
    // -------------------------------
    always @(posedge clk) begin
        if (rst) begin
            valid_stage3 <= 1'b0;
            for (i = 0; i < 8; i = i + 1)
                stage3[i] <= 32'b0;
        end else begin
            valid_stage3 <= valid_stage2;
            for (i = 0; i < 8; i = i + 1)
                stage3[i] <= stage2[2*i] + stage2[2*i+1];
        end
    end

    // -------------------------------
    // Stage 4: Process 8 → 4 numbers
    // -------------------------------
    always @(posedge clk) begin
        if (rst) begin
            valid_stage4 <= 1'b0;
            for (i = 0; i < 4; i = i + 1)
                stage4[i] <= 32'b0;
        end else begin
            valid_stage4 <= valid_stage3;
            for (i = 0; i < 4; i = i + 1)
                stage4[i] <= stage3[2*i] + stage3[2*i+1];
        end
    end

    // -------------------------------
    // Stage 5: Process 4 → 2 numbers
    // -------------------------------
    always @(posedge clk) begin
        if (rst) begin
            valid_stage5 <= 1'b0;
            for (i = 0; i < 2; i = i + 1)
                stage5[i] <= 32'b0;
        end else begin
            valid_stage5 <= valid_stage4;
            for (i = 0; i < 2; i = i + 1)
                stage5[i] <= stage4[2*i] + stage4[2*i+1];
        end
    end

    // -------------------------------
    // Stage 6: Final Addition (2 numbers → 1 sum)
    // -------------------------------
    always @(posedge clk) begin
        if (rst) begin
            valid_stage6 <= 1'b0;
            stage6 <= 32'b0;
            sum <= 32'b0;
            valid_out <= 1'b0;
        end else begin
            valid_stage6 <= valid_stage5;
            stage6 <= stage5[0] + stage5[1];
            sum <= stage6;         // Output the sum delayed by one extra cycle
            valid_out <= valid_stage6;
        end
    end

endmodule

