`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2025 06:34:38 AM
// Design Name: 
// Module Name: processor_tb
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


module processor_tb();
 wire clk;
 wire reset;
 wire [15:0] instruction;
 wire [15:0] PC;
 wire [15:0] PC_next;
 wire [15:0] aluResult;
 wire memWrite,regWrite,bne,beq,jump,mem2reg,memRead,aluSrc, branch;
 wire [2:0] aluControl;
 wire [15:0] rs_out,rd_out,data_mem_out;
 wire [15:0] sign_ext_imm,sign_ext_jmp;
 wire [15:0] mux_alusrc,mux_data_mem;
  /* Remove from output
  wire is_zero_out;
  wire [15:0]  shift_jump, shift_imm;
  wire [15:0] pc_plus_2,jump_pc,branch_pc,branch_add;
  */
  processor uut(
  .clk(clk),
  .reset(reset),
  .instruction(instruction),
  .PC(PC),
  .PC_next(PC_next),
  .aluResult(aluResult),
  .memWrite(memWrite),
  .regWrite(regWrite),
  .bne(bne),
  .beq(beq),
  .jump(jump),
  .mem2reg(mem2reg),
  .memRead(memRead),
  .aluSrc(aluSrc),
  .branch(branch),
  .aluControl(aluControl),
  .rs_out(rs_out),
  .rd_out(rd_out),
  .data_mem_out(data_mem_out),
  .sign_ext_imm(sign_ext_imm),
  .sign_ext_jmp(sign_ext_jmp),
  .mux_alusrc(mux_alusrc),
  .mux_data_mem(mux_data_mem)

  );
  
  /* Removed from output
    .is_zero_out(is_zero_out),
  .shift_jump(shift_jump),
  .shift_imm(shift_imm),
  .pc_plus_2(pc_plus_2),
  .jump_pc(jump_pc),
  .branch_pc(branch_pc),
  .branch_add(branch_add)
  */
  
  // Clock generation
    always #10 clk = ~clk; 

    initial begin
        // Initialize signals
        clk = 1; 
        reset=1;
        #20;
        reset =0;
              
        #440;
        $finish;
     end
  
  
  
endmodule
