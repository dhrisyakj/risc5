`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2025 10:46:47 AM
// Design Name: 
// Module Name: mac_regs
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


module mac_regs(

input wire clk,
input wire rst,
 // Write into first register from ex
  input wire we1_i,                      
  input wire[`RegAddrBus] w1addr_i,      
  input wire[`RegBus] w1data_i,
  // Write into second register
   input wire we2_i,                      
  input wire[`RegAddrBus] w2addr_i,      
  input wire[`RegBus] w2data_i,
   // from mac
    input wire[`RegAddrBus] raddr1_i,     

    // to mac
    output reg[`RegBus] rdata1_o,        

    // from mac
    input wire[`RegAddrBus] raddr2_i,     
    // to mac
    output reg[`RegBus] rdata2_o    
    
    );
    
    
    
     reg[`RegBus] regs_a[0:`RegNum - 1];
     reg[`RegBus] regs_b[0:`RegNum - 1];
     
     
      always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            // 优先ex模块写操作
            if ((we1_i == `WriteEnable)) begin
                regs_a[w1addr_i] <= w1data_i;
                end
    end
    end
     
     
always @ (*) begin
        if (raddr1_i == `ZeroReg) begin
            rdata1_o = `ZeroWord;
        // 如果读地址等于写地址，并且正在写操作，则直接返回写数据
        end else if (raddr1_i == w1addr_i && we1_i == `WriteEnable) begin
            rdata1_o = w1data_i;
        end else begin
            rdata1_o = regs_a[raddr1_i];
        end
    end     
     
endmodule
