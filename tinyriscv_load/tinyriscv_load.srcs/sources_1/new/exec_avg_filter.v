`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 07:24:45 AM
// Design Name: 
// Module Name: exec_avg_filter
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

module exec_avg_filter#(
  parameter fraction_bits=12,
  parameter DATA_WIDTH=32,
  parameter IDLE  = 3'd0,
          READ = 3'd1,
          ACC = 3'd2,
          MUL = 3'd3,
          DONE =3'd4
         
)(
  input  wire   clk,
  input  wire   rst,
  input  wire   start,
  input  wire [`RegBus]  base_addr,
  input  wire [`RegBus]  fixed_inv_N,
  input  wire [`RegBus] count,
  input  wire [`RegAddrBus]  mac_dst_reg_addr_i,
  input  wire [`RegBus]  mem_data,
  output  reg [`RegAddrBus]  mac_dst_reg_addr_o,
  output reg  [`RegBus]  mem_addr,
  output reg  mem_req,
  output reg  busy,
  output reg  done,
  output reg  [`RegBus]  avg_out

);

  reg  [`DoubleRegBus]  product;
  reg  [`RegBus]  memr_wdata;
  reg [`RegBus] final_count;
  reg [`RegBus]  addr;
  reg [`RegBus]  fixed_inv;

  reg [2:0] state;
  reg [`RegBus] acc,S;
  
 
integer i;
/*
    always @ (*) begin
        S = 0;
        // for each possible bit position...
        for (i = 0; i < DATA_WIDTH; i = i + 1) begin
            // when N == (1<<i), record i
            if (fixed_inv_N == (1 << i))
                S = i;
        end
    end
*/
  always @(posedge clk) begin
    if (!rst) begin
      state    <= IDLE;
      busy     <= 1'b0;
      S <= 0;
      done     <= 1'b0;
      acc      <= {DATA_WIDTH{1'b0}};
      avg_out  <= {DATA_WIDTH{1'b0}};
      mem_req = `RIB_NREQ;
      mem_addr <= {DATA_WIDTH{1'b0}};
    end else begin
      done   <= 1'b0;
  
      case (state)
        IDLE: begin
          if (start) begin
            busy  <= 1'b1;
            fixed_inv <= fixed_inv_N;
            // for each possible bit position...
        
        for (i = 0; i < DATA_WIDTH; i = i + 1) begin
            // when N == (1<<i), record i
            if (fixed_inv_N == (1 << i))
                S = i;
        end
            final_count = 32'd8192; // Maximum count
         if ((count != {DATA_WIDTH{1'b0}}) && (count <= final_count)) begin
            final_count <= count; // Modifiying the number based on the  given count
         end
            acc <= {DATA_WIDTH{1'b0}};
            mac_dst_reg_addr_o <= mac_dst_reg_addr_i;
            addr <= base_addr;
            state <= READ;
          end
        end

        READ: begin       // Read the elements from array
          mem_addr = addr;
          mem_req = `RIB_REQ;
          state <= ACC;
        end

        ACC: begin          // Accumulates the sum 
          acc  <= acc + mem_data;  
          mem_req = `RIB_NREQ;
           if (final_count == 1) begin
            state <= MUL;
            end else begin
            // next iteration
            final_count <= final_count - 1;
            addr <= addr + (DATA_WIDTH/8); // Sets the address to next memory location
            state <= READ;
          
        end
        end
          
       MUL: begin    // Calculates the average by multiplying 1/N
        mem_req = `RIB_NREQ;
        //product <= acc * fixed_inv;
        product <= acc >> S;
        state <= DONE;
        end
        
 
        DONE: begin
          busy  <= 1'b0;
          done  <= 1'b1;
          mem_req = `RIB_NREQ;
          avg_out <= product; 
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
