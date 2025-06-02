`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2025 03:58:37 PM
// Design Name: 
// Module Name: load_m_org
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


module load_m_org#(
  parameter ADDR_WIDTH  = 32,
  parameter DATA_WIDTH  = 32,
  parameter COUNT_WIDTH = 32,
  parameter IDLE  = 2'd0,
          READ1 = 2'd1,
          READ2 = 2'd2,
          DONE  = 2'd3
)(
  input  wire                   clk,
  input  wire                   rst,

  input  wire                   start,
  output reg                    busy,
  output reg                    done,

  input  wire [ADDR_WIDTH-1:0]  base_addr1,
  input  wire [ADDR_WIDTH-1:0]  base_addr2,
  input  wire [COUNT_WIDTH-1:0] count,

  // single async read port
  output reg  [ADDR_WIDTH-1:0]  mem_addr,
  output reg mem_req,
  input  wire [DATA_WIDTH-1:0]  mem_data,

  // RF1 write port
  output reg                    rf1_we,
  output reg  [COUNT_WIDTH-1:0] rf1_waddr,
  output reg  [DATA_WIDTH-1:0]  rf1_wdata,

  // RF2 write port
  output reg                    rf2_we,
  output reg  [COUNT_WIDTH-1:0] rf2_waddr,
  output reg  [DATA_WIDTH-1:0]  rf2_wdata
);

  // storage (optional)
  reg [DATA_WIDTH-1:0] RF1 [0:(1<<COUNT_WIDTH)-1];
  reg [DATA_WIDTH-1:0] RF2 [0:(1<<COUNT_WIDTH)-1];

  reg [COUNT_WIDTH-1:0] idx;
  reg [ADDR_WIDTH-1:0]  addr1, addr2;

  //typedef enum logic [1:0] { IDLE, READ1, READ2, DONE } state_t;
  //state_t state;
  reg [1:0] state;

  always @(posedge clk) begin
    if (!rst) begin
      state    <= IDLE;
      busy     <= 1'b0;
      done     <= 1'b0;
      rf1_we   <= 1'b0;
      rf2_we   <= 1'b0;
      mem_req = `RIB_NREQ;
      mem_addr <= {ADDR_WIDTH{1'b0}};
    end else begin
      // default de-asserts
      done   <= 1'b0;
      rf1_we <= 1'b0;
      rf2_we <= 1'b0;

      case (state)
        IDLE: begin
          if (start) begin
            busy  <= 1'b1;
            idx   <= count;
            addr1 <= base_addr1;
            addr2 <= base_addr2;
            state <= READ1;
          end
        end

        READ1: begin
          // Drive addr1 and immediately sample mem_data
          mem_addr      <= addr1;
          mem_req = `RIB_REQ;
          rf1_we        <= 1'b1;
          rf1_waddr     <= (count - idx);
          rf1_wdata     <= mem_data;
          RF1[count-idx]<= mem_data;

          // Prep next read of array2
          state         <= READ2;
        end

        READ2: begin
          // Drive addr2 and immediately sample mem_data
           //rf1_wdata     <= mem_data;
          mem_addr      <= addr2;
          mem_req = `RIB_REQ;
          rf2_we        <= 1'b1;
          rf2_waddr     <= (count - idx);
          rf2_wdata     <= mem_data;
          RF2[count-idx]<= mem_data;

          if (idx == 1) begin
            state <= DONE;
          end else begin
            // next iteration
            idx   <= idx - 1;
            addr1 <= addr1 + (DATA_WIDTH/8);
            addr2 <= addr2 + (DATA_WIDTH/8);
            state <= READ1;
          end
        end

        DONE: begin
          busy  <= 1'b0;
          done  <= 1'b1;
          mem_req = `RIB_NREQ;
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
