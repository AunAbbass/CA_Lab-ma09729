`timescale 1ns / 1ps

module ALUControlUnit(input [1:0] ALUOp, input [2:0] funct3,
    input [6:0] funct7, output reg [3:0] ALUControl);
    always @(*) begin
        ALUControl=4'd0;
        case (ALUOp)
            2'b00: ALUControl=4'd0;
            2'b01: ALUControl=4'd1;
            2'b10, 2'b11: begin
                case (funct3)
                    3'b000: ALUControl=(ALUOp==2'b10 && funct7[5]) ? 4'd1 : 4'd0;
                    3'b111: ALUControl=4'd2;
                    3'b110: ALUControl=4'd3;
                    3'b100: ALUControl=4'd4;
                    3'b001: ALUControl=4'd5;
                    3'b101: ALUControl=funct7[5] ? 4'd7 : 4'd6;
                    3'b010: ALUControl=4'd8;
                    3'b011: ALUControl=4'd9;
                endcase
            end
        endcase
    end
endmodule
