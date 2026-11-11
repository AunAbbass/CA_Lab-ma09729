`timescale 1ns / 1ps

module RegisterFile (
    input wire clk,
    input wire rst,
    input wire RegWrite,
    input wire RegRead,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] wd,
    output wire [31:0] rd1,
    output wire [31:0] rd2
);

    reg [31:0] registers [31:0];

    assign rd1 = (RegRead && rs1 != 5'b0) ? registers[rs1] : 32'b0;
    assign rd2 = (RegRead && rs2 != 5'b0) ? registers[rs2] : 32'b0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            registers[0]  <= 32'b0; registers[1]  <= 32'b0; registers[2]  <= 32'b0; registers[3]  <= 32'b0;
            registers[4]  <= 32'b0; registers[5]  <= 32'b0; registers[6]  <= 32'b0; registers[7]  <= 32'b0;
            registers[8]  <= 32'b0; registers[9]  <= 32'b0; registers[10] <= 32'b0; registers[11] <= 32'b0;
            registers[12] <= 32'b0; registers[13] <= 32'b0; registers[14] <= 32'b0; registers[15] <= 32'b0;
            registers[16] <= 32'b0; registers[17] <= 32'b0; registers[18] <= 32'b0; registers[19] <= 32'b0;
            registers[20] <= 32'b0; registers[21] <= 32'b0; registers[22] <= 32'b0; registers[23] <= 32'b0;
            registers[24] <= 32'b0; registers[25] <= 32'b0; registers[26] <= 32'b0; registers[27] <= 32'b0;
            registers[28] <= 32'b0; registers[29] <= 32'b0; registers[30] <= 32'b0; registers[31] <= 32'b0;
        end
        else if (RegWrite && rd != 5'b0) begin
            registers[rd] <= wd;
        end
    end

endmodule
