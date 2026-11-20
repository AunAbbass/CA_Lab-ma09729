`timescale 1ns / 1ps

module MainControl(input [6:0] opcode,
    output reg RegWrite, output reg [1:0] ALUOp,
    output reg MemRead, MemWrite, ALUSrc, MemtoReg, Branch);
    always @(*) begin
        RegWrite=0; ALUOp=0; MemRead=0; MemWrite=0;
        ALUSrc=0; MemtoReg=0; Branch=0;
        case (opcode)
            7'b0110011: begin RegWrite=1; ALUOp=2'b10; end
            // Separate immediate mode prevents ADDI's sign bit becoming SUB.
            7'b0010011: begin RegWrite=1; ALUSrc=1; ALUOp=2'b11; end
            7'b0000011: begin RegWrite=1; ALUSrc=1; MemRead=1; MemtoReg=1; end
            7'b0100011: begin ALUSrc=1; MemWrite=1; end
            7'b1100011: begin Branch=1; ALUOp=2'b01; end
            default: begin end
        endcase
    end
endmodule
