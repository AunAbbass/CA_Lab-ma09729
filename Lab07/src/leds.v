`timescale 1ns / 1ps
// Output port (not shown in report; ports match top_system's my_led_unit).
// A write latches writeData[15:0] onto the LED pins.
module leds(
    input clk,
    input rst,
    input [31:0] writeData,
    input writeEnable,
    input readEnable,
    input [29:0] memAddress,
    output reg [31:0] readData = 0,   // not to be read
    output reg [15:0] leds
);
    always @(posedge clk) begin
        if (rst)
            leds <= 16'd0;
        else if (writeEnable)
            leds <= writeData[15:0];
    end
endmodule
