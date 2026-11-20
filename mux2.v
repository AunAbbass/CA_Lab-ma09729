`timescale 1ns / 1ps

module mux2(input reset, input [31:0] d0, input [31:0] d1, input sel, output [31:0] out);
    assign out = reset ? 32'b0 : (sel ? d1 : d0);
endmodule
