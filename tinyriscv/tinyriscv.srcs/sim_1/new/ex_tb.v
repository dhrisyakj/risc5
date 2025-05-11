`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 02:43:30 PM
// Design Name: 
// Module Name: ex_tb
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

module ex_tb();
 // Test bench signals
 reg clk = 0;
  reg rst = 0;

  always #5 clk = ~clk;

  // Inputs to EX
  reg [31:0] inst_i;
  reg [31:0] inst_addr_i;
  reg        reg_we_i;
  reg [4:0]  reg_waddr_i;
  reg [31:0] reg1_rdata_i;
  reg [31:0] reg2_rdata_i;
  reg        csr_we_i;
  reg [11:0] csr_waddr_i;
  reg [31:0] csr_rdata_i;
  reg        int_assert_i;
  reg [31:0] int_addr_i;
  reg [31:0] op1_i;
  reg [31:0] op2_i;
  reg [31:0] op1_jump_i;
  reg [31:0] op2_jump_i;
  reg [31:0] mem_rdata_i;
  reg        div_ready_i;
  reg [31:0] div_result_i;
  reg        div_busy_i;
  reg [4:0]  div_reg_waddr_i;
  wire       log_ready_i;
  wire [31:0] log_result_i;
  wire        log_busy_i;

  // Outputs from EX
  wire [31:0] reg_wdata_o;
  wire [4:0]  reg_waddr_o;
  wire        reg_we_o;
  wire        log_start_o;
  wire [2047:0] log_data_in;

  // Instantiate the EX unit
  ex uut (
    .clk(clk),
    .rst(rst),
    .inst_i(inst_i),
    .inst_addr_i(inst_addr_i),
    .reg_we_i(reg_we_i),
    .reg_waddr_i(reg_waddr_i),
    .reg1_rdata_i(reg1_rdata_i),
    .reg2_rdata_i(reg2_rdata_i),
    .csr_we_i(csr_we_i),
    .csr_waddr_i(csr_waddr_i),
    .csr_rdata_i(csr_rdata_i),
    .int_assert_i(int_assert_i),
    .int_addr_i(int_addr_i),
    .op1_i(op1_i),
    .op2_i(op2_i),
    .op1_jump_i(op1_jump_i),
    .op2_jump_i(op2_jump_i),
    .mem_rdata_i(mem_rdata_i),
    .div_ready_i(div_ready_i),
    .div_result_i(div_result_i),
    .div_busy_i(div_busy_i),
    .div_reg_waddr_i(div_reg_waddr_i),
    .log_ready_i(log_ready_i),
    .log_result_i(log_result_i),
    .log_busy_i(log_busy_i),
    .reg_wdata_o(reg_wdata_o),
    .reg_we_o(reg_we_o),
    .reg_waddr_o(reg_waddr_o),
    .log_start_o(log_start_o),
    .log_data_in(log_data_in)
  );


  pipelined_logadder loga(
    .clk(clk),
    .rst(rst),
    .valid_in(log_start_o),
    .data_in(log_data_in),
    .valid_out(log_ready_i),
    .sum(log_result_i),
    .log_busy(log_busy_i)
    
    );  



  // Test sequence
  initial begin
    $display("Starting EX unit test for logadd64");

    // Initialize all signals
    rst = 1;
    inst_i = 0;
    inst_addr_i = 0;
    reg_we_i = 0;
    reg_waddr_i = 0;
    //reg1_rdata_i = 32'h00000100;  // base address for logadd64
    //reg2_rdata_i = 32'd64;        // number of words to add
    csr_we_i = 0;
    csr_waddr_i = 0;
    csr_rdata_i = 0;
    int_assert_i = 0;
    int_addr_i = 0;
    op1_i = 0;
    op2_i = 0;
    op1_jump_i = 0;
    op2_jump_i = 0;
    mem_rdata_i = 0;
    div_ready_i = 0;
    div_result_i = 0;
    div_busy_i = 0;
    div_reg_waddr_i = 0;
    //log_ready_i = 1;
    //log_result_i = 32'd2080; // expected sum
    //log_busy_i = 0;

    #10 rst = 0;

    // Set logadd64 custom instruction (replace with your encoding)
    inst_i = 32'b0000001_00000_00001_100_00011_0101011; // funct7/rs2/rs1/funct3/rd/opcode
    reg_we_i = 0;
    reg_waddr_i = 5'd3;

    // Simulate wait for EX to trigger log_start and accept result
    #200;
    $display("log_start_o = %b", log_start_o);
    #20;
    /*
    $display("reg_wdata_o = %0d", reg_wdata_o);
    $display("reg_we_o    = %b", reg_we_o);
    $display("reg_waddr_o = %0d", reg_waddr_o);
    */
    $finish;
  end

endmodule
