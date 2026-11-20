`timescale 1ns / 1ps

// imm_ext contains the signed B immediate in halfword units.
// This module supplies the omitted low zero bit, exactly once.
module branchAdder(input reset, input [31:0] pc_out, input [31:0] imm_ext, output [31:0] br_pc);
    assign br_pc = reset ? 32'b0 : pc_out + (imm_ext << 1);
endmodule
