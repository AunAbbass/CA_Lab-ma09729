`timescale 1ns / 1ps
// Reproduces the three test cases described in the report:
//  1) switch 4 on -> counts 4..0, later switch changes ignored while counting
//  2) switch 13 on -> counts 13(d)..0
//  3) reset pressed during a countdown -> counter and LEDs go to 0, state idle
module tb_report_cases();
    reg clk = 0, rst = 1;
    reg [15:0] tb_sw_pins = 0;
    wire [15:0] tb_led_pins;
    wire [3:0]  tb_countdown_out;
    wire [6:0]  tb_seg;
    wire [3:0]  tb_an;

    top_system uut (.clk(clk), .rst(rst), .sw_pins(tb_sw_pins), .led_pins(tb_led_pins),
                    .countdown_out(tb_countdown_out), .seg(tb_seg), .an(tb_an));
    always #5 clk = ~clk;

    initial begin
        #20 rst = 0; #20;
        // Case 1
        tb_sw_pins = 16'h0010;
        #30 tb_sw_pins = 16'h2000;        // ignored while counting
        wait(tb_countdown_out == 4'd0 && uut.my_fsm.state == 1'b1);
        wait(uut.my_fsm.state == 1'b0);
        // Case 2: switch 13 latched on return to idle
        #5 tb_sw_pins = 16'h2000;
        wait(tb_countdown_out == 4'd13);
        wait(tb_countdown_out == 4'd0);
        #50 tb_sw_pins = 16'h0000;
        #50;
        // Case 3: reset during countdown
        tb_sw_pins = 16'h0010;
        wait(tb_countdown_out == 4'd3);
        rst = 1; #20 rst = 0;
        #100;
        $finish;
    end

    always @(tb_countdown_out) $display("%0t ns: count=%0d state=%b leds=%h", $time, tb_countdown_out, uut.my_fsm.state, tb_led_pins);
endmodule
