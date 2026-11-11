`timescale 1ns / 1ps

module ALUControlUnit(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0000;

            2'b01: ALUControl = 4'b0001;

            2'b10: begin
                case (funct3)
                    3'b000: begin
                        if (funct7[5] == 1'b1)
                            ALUControl = 4'b0001;
                        else
                            ALUControl = 4'b0000;
                    end
                    3'b111: ALUControl = 4'b0010;
                    3'b110: ALUControl = 4'b0011;
                    3'b100: ALUControl = 4'b0100;
                    3'b001: ALUControl = 4'b0101;
                    3'b101: ALUControl = 4'b0110;
                    default: ALUControl = 4'b1111;
                endcase
            end

            default: ALUControl = 4'b0000;
        endcase
    end
endmodule
