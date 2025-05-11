module register_file(
    input clk, reg_write,
    input [3:0] rs, rt,
    input [15:0] write_data,
    output [15:0] read_data1, read_data2
);
    reg [15:0] registers [15:0];
    
    initial begin
  registers[0] = 16'd0;
  registers[1] = 16'd1;
  registers[2] = 16'd1;
  registers[3] = 16'd3;
  registers[4] = 16'd3;
  registers[5] = 16'd4;
  registers[6] = 16'd10;
  registers[7] = 16'd10;
  registers[8] = 16'd3;
  registers[9] = 16'd2;
  registers[10] = 16'd1;
  registers[11] = 16'd2;
  registers[12] = 16'd5;
  registers[13] = 16'd6;
  end

    always @(posedge clk) begin
        if (reg_write)
            registers[rt] <= write_data;
    end

    assign read_data1 = registers[rs];
    assign read_data2 = registers[rt];
endmodule
