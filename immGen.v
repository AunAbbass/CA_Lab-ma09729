`timescale 1ns / 1ps

module immGen(input reset, input [31:0] instruction, output reg [31:0] imm_ext);
    always @(*) begin
        imm_ext = 32'b0;
        if (!reset) begin
            case (instruction[6:0])
                7'b0010011, 7'b0000011:
                    imm_ext = {{20{instruction[31]}}, instruction[31:20]};
                7'b0100011:
                    imm_ext = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
                // B[12:1], sign extended. branchAdder appends B[0]=0.
                7'b1100011:
                    imm_ext = {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
                default: imm_ext = 32'b0;
            endcase
        end
    end
endmodule
