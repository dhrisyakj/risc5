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

//`include "defines.v"

module mac_load_reg#(
  parameter ADDR_WIDTH  = 32,
  parameter DATA_WIDTH  = 32,
  parameter COUNT_WIDTH = 32,
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
  output reg    busy,
  output reg    done,

  input  wire [ADDR_WIDTH-1:0]  base_addr1,
  input  wire [ADDR_WIDTH-1:0]  base_addr2,
  input  wire [COUNT_WIDTH-1:0] count,
  
   //input  wire [`RegAddrBus]  mac_dst_reg_addr_i,
  //output  reg [`RegAddrBus]  mac_dst_reg_addr_o,
  input  wire [4:0]  mac_dst_reg_addr_i,
  output  reg [4:0]  mac_dst_reg_addr_o,

  // single async read port
  output reg  [ADDR_WIDTH-1:0]  mem_addr,
  output reg mem_req,
  input  wire [DATA_WIDTH-1:0]  mem_data,

  output reg  [DATA_WIDTH-1:0]  acc_out

);


  reg  [DATA_WIDTH-1:0]  rf1_wdata;
  reg  [DATA_WIDTH-1:0]  rf2_wdata;
  reg [COUNT_WIDTH-1:0] final;
  reg [ADDR_WIDTH-1:0]  addr1, addr2;

  reg [2:0] state;
  reg [DATA_WIDTH-1:0] acc;


  //assign mac_dst_reg_addr_o = mac_dst_reg_addr_i;
  always @(posedge clk) begin
    if (!rst) begin
      state    <= IDLE;
      busy     <= 1'b0;
      done     <= 1'b0;
      acc      <= {DATA_WIDTH{1'b0}};
      mem_req = `RIB_NREQ;
      mem_addr <= {ADDR_WIDTH{1'b0}};
    end else begin
      // default de-asserts
      done   <= 1'b0;
   

      case (state)
        IDLE: begin
          if (start) begin
            busy  <= 1'b1;
           final = 32'd8192;
         if ((count != {COUNT_WIDTH{1'b0}}) && (count <= final)) begin
            final <= count;
        //curr_count <= new_count;
         end
          //else begin
             //final<=32'd2;
          //end
            acc <= {DATA_WIDTH{1'b0}};
            mac_dst_reg_addr_o <= mac_dst_reg_addr_i;
            addr1 <= base_addr1;
            addr2 <= base_addr2;
            state <= READ1;
          end
        end

        READ1: begin
          mem_addr <= addr1;
          mem_req = `RIB_REQ;
          // Prep next read of array2
          state <= READ2;
          //rf1_wdata <= mem_data;
        end

        READ2: begin
        
          rf1_wdata <= mem_data;
          mem_addr <= addr2;
          mem_req = `RIB_REQ;
          state<= WRITE;
        end

      WRITE: begin
        rf2_wdata <= mem_data;
        mem_req = `RIB_NREQ;
        state <= MAC;
        end
        
        MAC: begin
          acc <= acc + (rf1_wdata * rf2_wdata); // Mac operaion
   
          if (final == 1) begin
            state <= DONE;
          end else begin
            // next iteration
            final <= final - 1;
            addr1 <= addr1 + (DATA_WIDTH/8); // Next Memory location
            addr2 <= addr2 + (DATA_WIDTH/8);
            state <= READ1;
          end
        end

        DONE: begin
          busy  <= 1'b0;
          done  <= 1'b1;
          mem_req = `RIB_NREQ;
          acc_out <= acc;
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
