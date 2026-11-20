`timescale 1ns / 1ps

module Basys3Top(input clk, reset, input [15:0] switches_in, output [15:0] leds_out);
    reg [1:0] divider=0;
    always @(posedge clk) divider<=divider+1'b1;
    wire cpu_clk;
    BUFG cpu_clock_buffer(.I(divider[1]),.O(cpu_clk));
    (* ASYNC_REG="TRUE" *) reg [1:0] reset_sync=2'b11;
    always @(posedge cpu_clk or posedge reset)
        if (reset) reset_sync<=2'b11;
        else reset_sync<={reset_sync[0],1'b0};
    (* ASYNC_REG="TRUE" *) reg [15:0] switches_meta=0, switches_sync=0;
    always @(posedge cpu_clk) begin
        switches_meta<=switches_in;
        switches_sync<=switches_meta;
    end
    TopLevelProcessor cpu(cpu_clk,reset_sync[1],switches_sync,leds_out);
endmodule
