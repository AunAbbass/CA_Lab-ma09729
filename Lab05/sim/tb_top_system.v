`timescale 1ns / 1ps

module tb_top_system();

    reg clk;
    reg rst;
    reg [15:0] tb_sw_pins;
    wire [15:0] tb_led_pins;
    wire [3:0]  tb_countdown_out;
    wire [6:0]  tb_seg;
    wire [3:0]  tb_an;

    top_system uut (
        .clk(clk),
        .rst(rst),
        .sw_pins(tb_sw_pins),
        .led_pins(tb_led_pins),
        .countdown_out(tb_countdown_out),
        .seg(tb_seg),
        .an(tb_an)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tb_sw_pins = 16'b0;

        #20;
        rst = 0;
        #20;

        tb_sw_pins = 16'h0010;

        rst = 1;
        #20;
        rst = 0;

        #40;

        tb_sw_pins = 16'h0004;

        wait(tb_countdown_out == 4'd0);
        #100;

        $finish;
    end
endmodule
