`timescale 1ns / 1ps

module control_unit_tb;
    reg [3:0] opcode;
    reg [3:0] funct_code;
    wire reg_write, mem_read, mem_write, alu_src, branch_beq, branch_bne, jump, mem_to_reg;
    wire [2:0] alu_control;

    // Instantiate the control unit
    control_unit uut (
        .opcode(opcode),
        .funct_code(funct_code),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .branch_beq(branch_beq),
        .branch_bne(branch_bne),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .alu_control(alu_control)
    );

    initial begin
        // Initialize inputs
        opcode = 4'b0000;
        funct_code = 4'b0000;

        // Test R-type instructions (Opcode = 0000)
        opcode = 4'b0000;
        funct_code = 4'b0000; // ADD
        #10;
        $display("ADD: opcode=%b, funct_code=%b | reg_write=%b, alu_control=%b", opcode, funct_code, reg_write, alu_control);

        funct_code = 4'b0001; // SUB
        #10;
        $display("SUB: opcode=%b, funct_code=%b | reg_write=%b, alu_control=%b", opcode, funct_code, reg_write, alu_control);

        funct_code = 4'b0010; // SLL
        #10;
        $display("SLL: opcode=%b, funct_code=%b | reg_write=%b, alu_control=%b", opcode, funct_code, reg_write, alu_control);

        funct_code = 4'b0011; // AND
        #10;
        $display("AND: opcode=%b, funct_code=%b | reg_write=%b, alu_control=%b", opcode, funct_code, reg_write, alu_control);

        // Test BEQ (Opcode = 0100)
        opcode = 4'b0100;
        #10;
        $display("BEQ: opcode=%b | branch_beq=%b, alu_control=%b", opcode, branch_beq, alu_control);

        // Test BNE (Opcode = 0101)
        opcode = 4'b0101;
        #10;
        $display("BNE: opcode=%b | branch_bne=%b, alu_control=%b", opcode, branch_bne, alu_control);

        // Finish simulation
        #10 $finish;
    end
endmodule