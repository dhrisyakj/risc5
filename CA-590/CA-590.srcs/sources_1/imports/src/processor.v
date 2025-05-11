`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2025 09:03:10 AM
// Design Name: 
// Module Name: processor
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


module processor(
 input wire clk,
 input wire reset,
 output wire [15:0] rd_out
);

/* Removed from output for Simulation

  output wire [15:0] instruction;
 output wire [15:0] PC;
  output wire [15:0] PC_next;
  output wire [15:0] aluResult;
  output wire memWrite,regWrite,bne,beq,jump,mem2reg,memRead,aluSrc, branch;
  output wire [2:0] aluControl;
  output wire [15:0] rs_out,rd_out,data_mem_out;
  output wire [15:0] sign_ext_imm,sign_ext_jmp;
  output wire [15:0] mux_alusrc,mux_data_mem;
 ////Removed
  output wire is_zero_out;
  output wire [15:0]  shift_jump, shift_imm;
  output wire [15:0] pc_plus_2,jump_pc,branch_pc,branch_add;
  */

wire [15:0] rs_out;
 wire [15:0] instruction;
 wire memWrite,regWrite,jump,mem2reg,memRead,aluSrc,branch;
  wire [2:0] aluControl;
  wire [15:0] PC;
 wire [15:0] aluResult;
 wire bne,beq;
 wire [15:0] PC_next;
 wire [15:0] data_mem_out;
  wire [15:0] sign_ext_imm,sign_ext_jmp;
 wire [15:0] mux_alusrc, mux_data_mem;
 wire is_zero_out;
 wire [15:0]  shift_jump, shift_imm;
 wire [15:0] pc_plus_2,jump_pc,branch_pc,branch_add;

pc program_counter (clk,reset,PC_next,PC); //PC
adder_pc pc_plus(PC,pc_plus_2); // PC+2

instruction_mem imem(PC,instruction);
control_unit control(instruction[15:12],instruction[3:0],regWrite,aluSrc,memRead,memWrite,beq,bne,jump,mem2reg,aluControl);
register_file register(clk,regWrite,instruction[7:4],instruction[11:8],mux_data_mem,rs_out,rd_out);

// Sign Extention for Branch Immediate
sign_extension #(.WIDTH(4),.BIT_W(12)) extend_imm(instruction[3:0],sign_ext_imm);
//Sign Extension for  Jump Immediate
sign_extension #(.WIDTH(12),.BIT_W(4)) extend_branch(instruction[11:0],sign_ext_jmp);
//Shift immediate for branch and  jump
assign shift_imm = (sign_ext_imm << 16'b1);
assign shift_jump = (sign_ext_jmp << 16'b1);

// Mux to select the ALU Src
mux alu_src_in(rd_out,sign_ext_imm,aluSrc,mux_alusrc);
ALU alu_unit(rs_out,mux_alusrc,aluControl,aluResult);
//Iz_zero
is_zero is_z(aluResult,is_zero_out);
// Branch control 
assign branch = (is_zero_out&beq) ||((!is_zero_out)&bne);
// Branch address
adder_branch pc_branch(pc_plus_2,shift_imm,branch_add);
// Mux for branch address
mux branch_select(pc_plus_2,branch_add,branch,branch_pc);
// Jump Address
adder_branch jump_add(pc_plus_2,shift_jump,jump_pc);
//PC_next
mux pc_next(branch_pc,jump_pc,jump,PC_next);

data_memory dmem(clk,memWrite,memRead,aluResult,rd_out,data_mem_out);
mux reg_data_write(aluResult,data_mem_out,memWrite,mux_data_mem);

endmodule
