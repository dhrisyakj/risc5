`timescale 1ns / 1ps

module register_file_tb;
    reg clk, reg_write;
    reg [3:0] rs, rt;
    reg [15:0] write_data;
    wire [15:0] read_data1, read_data2;

    // Instantiate the register file
    register_file uut (
        .clk(clk),
        .reg_write(reg_write),
        .rs(rs),
        .rt(rt),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period

    initial begin
        // Initialize signals
        clk = 0; reg_write = 0;
        rs = 0; rt = 0;
        write_data = 0;

        // Step 1: Write values to registers
        #10 reg_write = 1; rt = 4'b0001; write_data = 16'h1234; // Write 0x1234 to R1
        #10 reg_write = 1; rt = 4'b0010; write_data = 16'h5678; // Write 0x5678 to R2
        #10 reg_write = 1; rt = 4'b0011; write_data = 16'h9ABC; // Write 0x9ABC to R3

        // Step 2: Read values back
        #10 reg_write = 0; rs = 4'b0001; rt = 4'b0010; // Read R1 and R2
        #10 rs = 4'b0011; rt = 4'b0001; // Read R3 and R1 again

        // Step 3: Verify reading a register without writing
        #10 rs = 4'b0100; rt = 4'b0101; // Should be 0x0000 if unwritten

        // Finish simulation
        #20 $finish;
    end

endmodule
