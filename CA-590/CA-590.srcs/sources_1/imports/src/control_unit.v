module control_unit(
    input [3:0] opcode,          // Opcode for the instruction
    input [3:0] funct_code,      // Function code for ALU operations (now 4-bit)
    output reg reg_write,        // Write to register file
    output reg alu_src,          // ALU source (0: register, 1: immediate)
    output reg mem_read,         // Memory read
    output reg mem_write,        // Memory write
    output reg branch_beq,       // Branch if Equal (BEQ)
    output reg branch_bne,       // Branch if Not Equal (BNE)
    output reg jump,             // Jump instruction
    output reg mem_to_reg,       // Memory to register (0: ALU result, 1: memory data)
    output reg [2:0] alu_control // ALU control signal (now 4-bit)
);

    always @(*) begin
        // Default values
        reg_write = 0;
        alu_src = 0;
        mem_read = 0;
        mem_write = 0;
        branch_beq = 0;
        branch_bne = 0;
        jump = 0;
        mem_to_reg = 0;
        alu_control = 3'b000; // Default: ADD

        case (opcode)
            4'b0000: begin // R-type instructions (opcode = 0000)
                reg_write = 1; // R-type instructions write to a register
                case (funct_code)
                    4'b0000: alu_control = 3'b000; // ADD
                    4'b0001: alu_control = 3'b001; // SUB
                    4'b0010: alu_control = 3'b010; // SLL (Shift Left Logical)
                    4'b0011: alu_control = 3'b011; // AND
                    default: alu_control = 3'b000; // Default to ADD
                endcase
            end
            4'b0011: begin // ADDI (Add Immediate)
                reg_write = 1;
                alu_src = 1;          // Use immediate value
                alu_control = 3'b000; // ALU ADD operation
            end
            4'b0001: begin // LW (Load Word)
                reg_write = 1;
                alu_src = 1;          // Use immediate value
                mem_read = 1;
                mem_to_reg = 1;       // Data from memory to register
                alu_control = 3'b000; // ALU ADD for address calculation
            end
            4'b0010: begin // SW (Store Word)
                alu_src = 1;          // Use immediate value
                mem_write = 1;
                alu_control = 3'b000; // ALU ADD for address calculation
            end
            4'b0100: begin // BEQ (Branch if Equal)
                branch_beq = 1;        // Only BEQ is active
                alu_control = 3'b001; // ALU SUB for comparison
            end
            4'b0101: begin // BNE (Branch if Not Equal)
                branch_bne = 1;        // Only BNE is active
                alu_control = 3'b001; // ALU SUB for comparison
            end
            4'b0110: begin // JMP (Jump)
                jump = 1;
            end
            default: begin // Default case (NOP or unknown opcode)
                reg_write = 0;
                alu_src = 0;
                mem_read = 0;
                mem_write = 0;
                branch_beq = 0;
                branch_bne = 0;
                jump = 0;
                mem_to_reg = 0;
                alu_control = 3'b000; // No operation
            end
        endcase
    end
endmodule