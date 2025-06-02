`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2025 03:42:30 PM
// Design Name: 
// Module Name: mac_load_reg_tb
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


module mac_load_reg_tb();
// parameters must match DUT
  localparam ADDR_WIDTH  = 32;
  localparam DATA_WIDTH  = 32;
  localparam COUNT_WIDTH = 8;
  localparam MEM_SIZE    = 16;

  // clock & reset
  reg clk;
  reg rst;

  // DUT I/O
  reg                         start;
  wire                        busy;
  wire                        done;
  reg  [ADDR_WIDTH-1:0]       base_addr1;
  reg  [ADDR_WIDTH-1:0]       base_addr2;
  reg  [COUNT_WIDTH-1:0]      count;
  wire [ADDR_WIDTH-1:0]       mem_addr;
  reg  [DATA_WIDTH-1:0]       mem_data;
  wire                        rf1_we;
  wire [COUNT_WIDTH-1:0]      rf1_waddr;
  wire [DATA_WIDTH-1:0]       rf1_wdata;
  wire                        rf2_we;
  wire [COUNT_WIDTH-1:0]      rf2_waddr;
  wire [DATA_WIDTH-1:0]       rf2_wdata;

  // instantiate DUT
 mac_load_reg#(
    .ADDR_WIDTH (ADDR_WIDTH),
    .DATA_WIDTH (DATA_WIDTH),
    .COUNT_WIDTH(COUNT_WIDTH)
  ) uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .busy      (busy),
    .done      (done),
    .base_addr1(base_addr1),
    .base_addr2(base_addr2),
    .count     (count),
    .mem_addr  (mem_addr),
    .mem_data  (mem_data),
    .rf1_we    (rf1_we),
    .rf1_waddr (rf1_waddr),
    .rf1_wdata (rf1_wdata),
    .rf2_we    (rf2_we),
    .rf2_waddr (rf2_waddr),
    .rf2_wdata (rf2_wdata)
  );

  // simple asynchronous memory model (word-addressed)
  reg [DATA_WIDTH-1:0] mem [0:MEM_SIZE-1];
  always @(*) begin
    // assume word-aligned addresses
    mem_data = mem[mem_addr[ADDR_WIDTH-1:2]];
  end

  // clock generation: 50 MHz (20 ns period)
  
    initial clk = 0;
  always #10 clk = ~clk;
 
 integer i;
  // stimulus
  initial begin
   
    // initialize memory with known patterns
    for (i = 0; i < MEM_SIZE; i = i+1) begin
      mem[i] = 32'hDEAD_0000 + i;
    end

    // reset
    rst   = 1;
    start = 0;
    base_addr1 = 0;
    base_addr2 = 16;       // start second array at word-index 4 (4*4=16 bytes)
    count      = 4;        // fetch 4 elements
    #40;                   // hold reset for two clock cycles
    rst = 0;
    #20;

    // launch prefetch
    @(posedge clk);
    start = 1;
    @(posedge clk);
    start = 0;

    // wait for done
    wait (done);
    #20;

    $display("=== FETCH COMPLETE ===");
    $finish;
  end

  // monitor every write into RF1/RF2
  always @(posedge clk) begin
    if (rf1_we) begin
      $display("[%0t] RF1[%0d] <= 0x%08h",
               $time, rf1_waddr, rf1_wdata);
    end
    if (rf2_we) begin
      $display("[%0t] RF2[%0d] <= 0x%08h",
               $time, rf2_waddr, rf2_wdata);
    end
  end
endmodule
