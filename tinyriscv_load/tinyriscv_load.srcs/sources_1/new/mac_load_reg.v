`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2025 01:38:57 PM
// Design Name: 
// Module Name: mac_load_reg
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

module exec_mac#(
  parameter DATA_WIDTH=32,
  parameter IDLE  = 3'd0,
          READ1 = 3'd1,
          READ2 = 3'd2,
          WRITE = 3'd3,
          MAC =3'd4,
          DONE = 3'd5
)(
  input  wire   clk,
  input  wire   rst,
  input  wire   start,
  input  wire [`RegBus]  base_addr1,
  input  wire [`RegBus]  base_addr2,
  input  wire [`RegBus] count,
  input  wire [`RegAddrBus]  mac_dst_reg_addr_i,
  input  wire [`RegBus]  mem_data,
  output  reg [`RegAddrBus]  mac_dst_reg_addr_o,
  output reg  [`RegBus]  mem_addr,
  output reg mem_req,
  output reg    busy,
  output reg    done,
  output reg  [`RegBus]  acc_out

);

  reg  [`RegBus]  rf1_wdata;
  reg  [`RegBus]  rf2_wdata;
  reg [`RegBus] final_count;
  reg [`RegBus]  addr1, addr2;

  reg [2:0] state;
  reg [`RegBus] acc;

  always @(posedge clk) begin
    if (!rst) begin
      state    <= IDLE;
      busy     <= 1'b0;
      done     <= 1'b0;
      acc      <= {DATA_WIDTH{1'b0}};
      acc_out      <= {DATA_WIDTH{1'b0}};
      mem_req = `RIB_NREQ;
      mem_addr <= {DATA_WIDTH{1'b0}};
    end else begin
      done   <= 1'b0;
   

      case (state)
        IDLE: begin
          if (start) begin
            busy  <= 1'b1;
           final_count = 32'd8192; // Maximum no of MACS
         if ((count != {DATA_WIDTH{1'b0}}) && (count <= final_count)) begin
            final_count <= count; // Modifiying the no of MACS based on the  given count
         end
            acc <= {DATA_WIDTH{1'b0}};
            mac_dst_reg_addr_o <= mac_dst_reg_addr_i;
            addr1 <= base_addr1;
            addr2 <= base_addr2;
            state <= READ1;
          end
        end

        READ1: begin       // Read the first array
          mem_addr <= addr1;
          mem_req = `RIB_REQ;
          state <= READ2;
        end

        READ2: begin          // Reads the second array and writes the first array element
          rf1_wdata <= mem_data;  
          mem_addr <= addr2;
          mem_req = `RIB_REQ;
          state<= WRITE;
        end

      WRITE: begin    // Writes the second array element to register
        rf2_wdata <= mem_data;
        mem_req = `RIB_NREQ;
        state <= MAC;
        end
        
        MAC: begin
          acc <= acc + (rf1_wdata * rf2_wdata); // Performs MAC Operation
   
          if (final_count == 1) begin
            state <= DONE;
          end else begin
            // next iteration
            final_count <= final_count - 1;
            addr1 <= addr1 + (DATA_WIDTH/8); // Sets the address to next memory location
            addr2 <= addr2 + (DATA_WIDTH/8);
            state <= READ1;
          end
        end
        DONE: begin
          busy  <= 1'b0;
          done  <= 1'b1;
          mem_req = `RIB_NREQ;
          acc_out <= acc;  //Writes out the final accumulator value
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
