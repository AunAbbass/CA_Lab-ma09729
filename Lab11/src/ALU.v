`timescale 1ns / 1ps

module ALU(input [31:0] A, B, input [3:0] ALUControl,
    output reg [31:0] ALUResult, output Zero);
    always @(*) begin
        case (ALUControl)
            0: ALUResult=A+B;
            1: ALUResult=A-B;
            2: ALUResult=A&B;
            3: ALUResult=A|B;
            4: ALUResult=A^B;
            5: ALUResult=A<<B[4:0];
            6: ALUResult=A>>B[4:0];
            7: ALUResult=$signed(A)>>>B[4:0];
            8: ALUResult={31'b0, ($signed(A)<$signed(B))};
            9: ALUResult={31'b0, (A<B)};
            default: ALUResult=0;
        endcase
    end
    assign Zero=(ALUResult==0);
endmodule
