`timescale 1ns / 1ps

module pcAdder(input reset, input [31:0] pc_out, output [31:0] next_pc);
    assign next_pc = reset ? 32'b0 : pc_out + 32'd4;
endmodule
