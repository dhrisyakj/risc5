`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2025 07:09:55 AM
// Design Name: 
// Module Name: exec_power
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


module exec_power#(
  parameter fraction_bits=12,
  parameter DATA_WIDTH=32,
  parameter IDLE  = 3'd0,
          READ = 3'd1,
          MUL = 3'd2,
          ACC = 3'd3,
          AVG =3'd4,
          DONE =3'd5
         
)(
  input  wire   clk,
  input  wire   rst,
  input  wire   start,
  input  wire [`RegBus]  base_addr,
  input  wire [`RegBus]  fixed_inv_N,
  input  wire [`RegBus] count,
  input  wire [`RegAddrBus]  mac_dst_reg_addr_i,
  input  wire [`RegBus]  mem_data,
  output reg  [`RegAddrBus]  mac_dst_reg_addr_o,
  output reg  [`RegBus]  mem_addr,
  output reg  mem_req,
  output reg  busy,
  output reg  done,
  output reg  [`RegBus]  avg_out

);

  reg  [`DoubleRegBus]  product,power;
  reg  [`RegBus]  mdata;
  reg [`RegBus] final_count;
  reg [`RegBus]  addr;
  reg [`RegBus]  fixed_inv;

  reg [2:0] state;
  reg [`RegBus] acc;

  always @(posedge clk) begin
    if (!rst) begin
      state    <= IDLE;
      busy     <= 1'b0;
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
            //final_count = count;
            fixed_inv <= fixed_inv_N;
            
            final_count = 32'd8192; // Maximum number
         if ((count != {DATA_WIDTH{1'b0}}) && (count <= final_count)) begin
            final_count <= count; // Modifiying the number based on the  given count
         end 
            acc <= {DATA_WIDTH{1'b0}};
            mac_dst_reg_addr_o <= mac_dst_reg_addr_i;
            addr <= base_addr;
            state <= READ;
          end
        end

        READ: begin   // Read the elements from array
          mem_addr = addr;
          mem_req = `RIB_REQ;
          state <= MUL;
        end
        
         MUL: begin    // Calculates the square value - x[n] * x[n]
        mem_req = `RIB_NREQ;
         mdata= mem_data;
        power <= mdata * mem_data;
        state <= ACC;
        end

        ACC: begin   // Accumulates the values
          acc  <= acc + power;
          mem_req = `RIB_NREQ;
           if (final_count == 1) begin
            state <= AVG;
            end else begin
            // next iteration
            final_count <= final_count - 1;
            addr <= addr + (DATA_WIDTH/8); // Sets the address to next memory location
            state <= READ;
          
        end
        end  
       AVG: begin    // Calculates the average value
        mem_req = `RIB_NREQ;
        product <= acc * fixed_inv;
        state <= DONE;
        end
        
 
        DONE: begin
          busy  <= 1'b0;
          done  <= 1'b1;
          mem_req = `RIB_NREQ;
          avg_out <= product; // >> fraction_bits;
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
