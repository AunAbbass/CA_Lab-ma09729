`timescale 1ns / 1ps

module MainControl_tb();
    reg [6:0] opcode;
    wire RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    wire [1:0] ALUOp;

    // Instantiate the Main Control Unit
    MainControl uut (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .Branch(Branch)
    );

    initial begin
        $display("Testing Main Control Unit...");

        opcode = 7'b0110011; #10;

        opcode = 7'b0010011; #10;

        opcode = 7'b0000011; #10;

        opcode = 7'b0100011; #10;

        opcode = 7'b1100011; #10;

        $finish;
    end
endmodule
