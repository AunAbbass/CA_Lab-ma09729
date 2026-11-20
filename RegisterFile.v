`timescale 1ns / 1ps

module RegisterFile(input clk, rst, RegWrite, RegRead,
    input [4:0] rs1, rs2, rd, input [31:0] wd, output [31:0] rd1, rd2);
    reg [31:0] registers [0:31];
    integer i;
    assign rd1=(RegRead && rs1!=0) ? registers[rs1] : 32'b0;
    assign rd2=(RegRead && rs2!=0) ? registers[rs2] : 32'b0;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i=0; i<32; i=i+1) registers[i]<=0;
        end else if (RegWrite && rd!=0) registers[rd]<=wd;
    end
endmodule
