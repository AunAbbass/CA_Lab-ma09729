`timescale 1ns / 1ps

module state_controller(
    input clk,
    input rst,
    input [15:0] sw_in,
    output reg [15:0] led_state,
    output [3:0] count_val
    );

    reg state;

    countdown_unit timer (
        .clk(clk),
        .rst(rst),
        .state(state),
        .sw_in(sw_in),
        .count_out(count_val)
    );

    always @(posedge clk) begin
        if (rst) begin
            state <= 1'b0;
            led_state <= 16'b0;
        end
        else if (state == 1'b0) begin
            led_state <= sw_in;
            if (sw_in != 16'b0) begin
                state <= 1'b1;
            end
        end
        else begin
            if (count_val == 4'd0) begin
                state <= 1'b0;
            end
        end
    end
endmodule
