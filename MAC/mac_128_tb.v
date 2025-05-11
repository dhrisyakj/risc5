`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 11:31:24 AM
// Design Name: 
// Module Name: mac_128_tb
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


module mac_128_tb();

  // Parameters match DUT
  localparam IN_WIDTH   = 16;
  localparam COUNT_BITS = 7;
  localparam ACC_WIDTH  = IN_WIDTH*2 + COUNT_BITS;

  // Signals
  reg                   clk;
  reg                   rst;
  reg                   valid;
  reg  [IN_WIDTH-1:0]   a, b;
  wire [ACC_WIDTH-1:0]  acc;
  wire [ACC_WIDTH-1:0]  result;
  wire                  done;

  // Instantiate DUT
  mac_128 #(
    .IN_WIDTH  (IN_WIDTH)
    //.COUNT_BITS(COUNT_BITS)
  ) dut (
    .clk   (clk),
    .acc_rst   (rst),
   // .valid (valid),
    .a     (a),
    .b     (b),
    .acc   (acc),
    .result(result)
    //.done  (done)
  );

  // Clock: 20 ns period
  initial clk = 0;
  always #10 clk = ~clk;

  integer i;
  reg [ACC_WIDTH-1:0] expected;

  initial begin
    // 1) Reset
    rst      = 1;
    valid    = 0;
    a        = 0;
    b        = 0;
    expected = 0;
    #40;            // two clock cycles

    rst = 0;
    #30;
    
    // 6 MAC Operations
    for (i = 0; i < 6; i = i + 1) begin
      //valid = 1;
      a     = i[IN_WIDTH-1:0];
      b     = 2*i[IN_WIDTH-1:0];
      expected = expected + a*b;
      #20;           // one clock
    end

    
    if (acc === expected)
      $display("**PASS**: acc = %0d, expected = %0d", acc, expected);
    else
      $display("**FAIL**: acc = %0d, expected = %0d", acc, expected);
      
      // Reset the accumulator after the count
      rst=1;
      #20;
      rst=0;
      expected = 0;
      // 16 MAC Operations
       for (i = 0; i < 16; i = i + 1) begin
      a     = i[IN_WIDTH-1:0];
      b     = 2*i[IN_WIDTH-1:0];
      expected = expected + a*b;
      #20;           // one clock
    end

      if (acc === expected)
      $display("**PASS**: acc = %0d, expected = %0d", acc, expected);
    else
      $display("**FAIL**: acc = %0d, expected = %0d", acc, expected);

    $finish;
  end
endmodule

