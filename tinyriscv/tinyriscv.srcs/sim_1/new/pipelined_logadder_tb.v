`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 01:32:44 PM
// Design Name: 
// Module Name: pipelined_logadder_tb
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


module pipelined_logadder_tb;

  // Test bench signals
  reg          clk;
  reg          rst;
  reg          valid_in;
  reg  [2047:0] data_in;   // Packed 64 numbers (64 x 32 bits)
  wire         valid_out;
  wire [31:0]  sum;
  wire  log_busy;
  integer i;

  // Instantiate the Device Under Test (DUT)
  pipelined_logadder dut (
      .clk(clk),
      .rst(rst),
      .valid_in(valid_in),
      .data_in(data_in),
      .valid_out(valid_out),
      .sum(sum),
      .log_busy(log_busy)
  );

reg [31:0] cycle_count;
reg [31:0] start_cycle;
reg [31:0] end_cycle;

always @(posedge clk) begin
    if (rst)
        cycle_count <= 0;
    else
        cycle_count <= cycle_count + 1;
end

// Capture the cycle when valid_in is high
always @(posedge clk) begin
    if (valid_in)
        start_cycle <= cycle_count;
end

// Capture the cycle when valid_out goes high
always @(posedge clk) begin
    if (valid_out)
        end_cycle <= cycle_count;
end



  // Generate a 10 ns period clock (toggle every 5 ns)
  always begin
      #5 clk = ~clk;
  end

  initial begin
      // Initialize signals
      clk = 0;
      rst = 1;
      valid_in = 0;
      data_in = 0;

      // Hold reset for 20 ns (e.g., 2 clock cycles)
      #20;
      rst = 0;

      // Wait one clock cycle before applying input
      #10;

      // Pack 64 numbers into data_in using consecutive 32-bit words.
      // Each 32-bit segment in data_in is assigned a value from 1 to 64.
      // data_in[31:0] corresponds to the first number (i.e., 1),
      // data_in[63:32] to the second (i.e., 2), etc.
      data_in = 0;
      for (i = 0; i < 64; i = i + 1) begin
          // The slice operator [i*32 +: 32] selects 32 bits starting at bit i*32.
          data_in[i*32 +: 32] = i + 1;
      end

      // Assert valid_in for one clock cycle to indicate the input data is available.
      valid_in = 1;
      #10;
      //valid_in = 0;

      // Wait enough cycles for the 6-stage pipelined adder to process the data.
      // (6 cycles are needed for the adder operation, plus some extra cycles for safety.)
      #100;
       if (valid_out) begin
        $display("Latency in cycles: %0d", end_cycle - start_cycle);
        if ((end_cycle - start_cycle) == 6)
            $display("TEST PASSED: The adder took 6 cycles.");
        else
            $display("TEST FAILED: Expected 6 cycles, got %0d cycles", end_cycle - start_cycle);
    end
      // Display the results
      if (valid_out)
          $display("Time %0t: Computed sum = %0d", $time, sum);
      else
          $display("Time %0t: Output not valid", $time);

      // For our input (1 to 64), the expected sum is (64*65)/2 = 2080.
      if (sum == 2080)
          $display("TEST PASSED: Sum is correct (2080).");
      else
          $display("TEST FAILED: Expected 2080, got %0d", sum);

      // Finish simulation
      #20;
      $finish;
  end

endmodule

