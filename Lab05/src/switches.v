`timescale 1ns / 1ps
// Input port (not shown in report; ports match top_system's my_switch_unit).
// A read returns {buttons, switches}.
module switches(
    input clk,
    input rst,
    input [15:0] btns,
    input [31:0] writeData,   // not to be written
    input writeEnable,        // not to be used
    input readEnable,
    input [29:0] memAddress,
    input [15:0] switches,
    output reg [31:0] readData
);
    always @(posedge clk) begin
        if (rst)
            readData <= 32'd0;
        else if (readEnable)
            readData <= {btns, switches};
    end
endmodule
