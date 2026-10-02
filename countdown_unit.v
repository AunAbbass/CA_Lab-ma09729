`timescale 1ns / 1ps

module countdown_unit(
    input clk,
    input rst,
    input state,
    input [15:0] sw_in,
    output reg [3:0] count_out
);
    reg [2:0] clk_div;
    always @(posedge clk) begin
        if (rst) clk_div <= 0;
        else clk_div <= clk_div + 1;
    end

    wire count_tick = (clk_div == 3'b111);

    always @(posedge clk) begin
        if (rst) begin
            count_out <= 4'd0;
        end
        else if (state == 1'b0) begin
            if      (sw_in[15]) count_out <= 4'd15;
            else if (sw_in[14]) count_out <= 4'd14;
            else if (sw_in[13]) count_out <= 4'd13;
            else if (sw_in[12]) count_out <= 4'd12;
            else if (sw_in[11]) count_out <= 4'd11;
            else if (sw_in[10]) count_out <= 4'd10;
            else if (sw_in[9])  count_out <= 4'd9;
            else if (sw_in[8])  count_out <= 4'd8;
            else if (sw_in[7])  count_out <= 4'd7;
            else if (sw_in[6])  count_out <= 4'd6;
            else if (sw_in[5])  count_out <= 4'd5;
            else if (sw_in[4])  count_out <= 4'd4;
            else if (sw_in[3])  count_out <= 4'd3;
            else if (sw_in[2])  count_out <= 4'd2;
            else if (sw_in[1])  count_out <= 4'd1;
            else if (sw_in[0])  count_out <= 4'd0;
            else                count_out <= 4'd0;
        end
        else if (count_tick) begin
            if (count_out > 0) count_out <= count_out - 1;
        end
    end
endmodule
