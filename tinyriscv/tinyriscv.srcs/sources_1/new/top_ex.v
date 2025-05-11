`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 02:03:03 PM
// Design Name: 
// Module Name: top_ex
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


module top_ex(
  input clk,
  input rst,
  // Custom Instruction - to log adder
    output wire log_start_o,
   output wire [2047:0] log_data_in,
    //output wire [31:0] log_data_in [0:63],
    
    //from log adder
    input wire log_ready_i,                 // 除法运算完成标志
    input wire[`RegBus] log_result_i,  
      input wire [31:0] inst_i,     // 除法运算结果
    input wire log_busy_i

    );
    
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
  //reg        log_ready_i;
  //reg [31:0] log_result_i;
  //reg        log_busy_i;

  // Outputs from EX
  wire [31:0] reg_wdata_o;
  wire [4:0]  reg_waddr_o;
  wire        reg_we_o;
  //wire        log_start_o;
  //wire [2047:0] log_data_in;
    
  // Instantiate the EX unit
  ex exunit (
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
    
endmodule
