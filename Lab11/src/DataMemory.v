`timescale 1ns / 1ps

// 256 bytes, 64 words; byte addresses are converted to word indices.
// RAM is not reset: programs must write a location before reading it.
module DataMemory(input clk, input MemWrite, input [31:0] address,
    input [31:0] write_data, output [31:0] read_data);
    reg [31:0] mem [0:63];
    wire valid=(address<32'h100 && address[1:0]==0);
    always @(posedge clk)
        if (MemWrite && valid) mem[address[7:2]]<=write_data;
    assign read_data=valid ? mem[address[7:2]] : 32'b0;
endmodule
