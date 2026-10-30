`timescale 1ns / 1ps

module ALUControl_tb();
    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [3:0] ALUControl;

    ALUControlUnit uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    initial begin
        $display("Testing ALU Control Unit...");

        ALUOp = 2'b00; funct3 = 3'bxxx; funct7 = 7'bxxxxxxx; #10; // Expected: 4'b0000

        ALUOp = 2'b01; funct3 = 3'b000; funct7 = 7'bxxxxxxx; #10; // Expected: 4'b0001

        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0000000; #10; // Expected: 4'b0000

        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0100000; #10; // Expected: 4'b0001

        ALUOp = 2'b10; funct3 = 3'b111; funct7 = 7'b0000000; #10; // Expected: 4'b0010

        ALUOp = 2'b10; funct3 = 3'b001; funct7 = 7'b0000000; #10; // Expected: 4'b0101

        $finish;
    end
endmodule
