`timescale 1ns / 1ps

module StateController(
    input [1:0] state,
    input sw_regWrite,
    output reg RegWrite,
    output reg [1:0] wd_sel
);

    always @(*) begin
        RegWrite = 0;
        wd_sel = 0;

        case (state)
            2'b00: RegWrite = 0;

            2'b01: begin
                RegWrite = sw_regWrite;
                wd_sel = 0;
            end

            2'b10: begin
                RegWrite = sw_regWrite;
                wd_sel = 0;
            end

            2'b11: begin
                RegWrite = sw_regWrite;
                wd_sel = 1;
            end
        endcase
    end

endmodule
