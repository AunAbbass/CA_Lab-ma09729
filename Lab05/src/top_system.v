`timescale 1ns / 1ps

module top_system(
    input clk,
    input rst,
    input [15:0] sw_pins,
    output [15:0] led_pins,
    output [3:0] countdown_out,
    output [6:0] seg,
    output [3:0] an
    );

    wire [31:0] internal_bus;
    wire [15:0] fsm_to_led;
    wire [3:0]  current_count;

    assign countdown_out = current_count;

    switches my_switch_unit (
        .clk        (clk),
        .rst        (rst),
        .btns       (16'b0),
        .switches   (sw_pins),
        .readEnable (1'b1),
        .readData   (internal_bus),
        .writeData  (32'b0),
        .writeEnable(1'b0),
        .memAddress (30'b0)
    );

    state_controller my_fsm (
        .clk        (clk),
        .rst        (rst),
        .sw_in      (internal_bus[15:0]),
        .led_state  (fsm_to_led),
        .count_val  (current_count)
    );

    seg7_decoder my_display (
        .digit(current_count),
        .seg(seg)
    );

    assign an = 4'b1110;

    leds my_led_unit (
        .clk        (clk),
        .rst        (rst),
        .writeData  ({16'b0, fsm_to_led}),
        .writeEnable(1'b1),
        .leds       (led_pins),
        .readEnable (1'b0),
        .memAddress (30'b0),
        .readData   ()
    );

endmodule
