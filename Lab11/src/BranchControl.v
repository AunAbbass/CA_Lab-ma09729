`timescale 1ns / 1ps

module BranchControl(input Branch, input [2:0] funct3,
    input [31:0] A, B, output reg PCSrc);
    always @(*) begin
        PCSrc=0;
        if (Branch) begin
            case (funct3)
                3'b000: PCSrc=(A==B);
                3'b001: PCSrc=(A!=B);
                3'b100: PCSrc=($signed(A)<$signed(B));
                3'b101: PCSrc=($signed(A)>=$signed(B));
                3'b110: PCSrc=(A<B);
                3'b111: PCSrc=(A>=B);
                default: PCSrc=0;
            endcase
        end
    end
endmodule
