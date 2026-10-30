`timescale 1ns / 1ps

module MainControl(
    input [6:0] opcode,
    output reg RegWrite,
    output reg [1:0] ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg Branch
);

    always @(*) begin
        RegWrite = 0;
        ALUOp    = 2'b00;
        MemRead  = 0;
        MemWrite = 0;
        ALUSrc   = 0;
        MemtoReg = 0;
        Branch   = 0;

        case (opcode)
            7'b0110011: begin
                RegWrite = 1;
                ALUSrc   = 0;
                MemRead  = 0;
                MemWrite = 0;
                MemtoReg = 0;
                Branch   = 0;
                ALUOp    = 2'b10;
            end

            7'b0010011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                MemRead  = 0;
                MemWrite = 0;
                MemtoReg = 0;
                Branch   = 0;
                ALUOp    = 2'b10;
            end

            7'b0000011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                MemRead  = 1;
                MemWrite = 0;
                MemtoReg = 1;
                Branch   = 0;
                ALUOp    = 2'b00;
            end

            7'b0100011: begin
                RegWrite = 0;
                ALUSrc   = 1;
                MemRead  = 0;
                MemWrite = 1;
                MemtoReg = 0;
                Branch   = 0;
                ALUOp    = 2'b00;
            end

            7'b1100011: begin
                RegWrite = 0;
                ALUSrc   = 0;
                MemRead  = 0;
                MemWrite = 0;
                MemtoReg = 0;
                Branch   = 1;
                ALUOp    = 2'b01;
            end

            default: begin
            end
        endcase
    end
endmodule
