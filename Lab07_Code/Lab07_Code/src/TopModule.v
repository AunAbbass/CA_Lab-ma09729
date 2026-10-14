`timescale 1ns / 1ps

module TopModule (
    input clk,
    input rst,
    input [15:0] switches,
    output [15:0] leds_out,
    output [31:0] out_rd1,
    output [31:0] out_rd2
);

    wire [31:0] rd1, rd2, alu_res;
    wire [31:0] wd_to_rf;
    wire reg_write_ctrl, zero_flag;
    wire [1:0] wd_sel;

    reg [4:0] current_rd;

    StateController logic_unit (
        .state(switches[6:5]),
        .sw_regWrite(switches[0]),
        .RegWrite(reg_write_ctrl),
        .wd_sel(wd_sel)
    );

    always @(*) begin
        case (switches[6:5])
            2'b01: current_rd = 5'd3; // Load x3
            2'b10: current_rd = 5'd4; // Load x4
            2'b11: current_rd = 5'd6; // Execute and store in x6
            default: current_rd = 5'd0;
        endcase
    end

    assign wd_to_rf = (wd_sel == 2'b01) ? alu_res : {23'b0, switches[15:7]};

    RegisterFile rf_inst (
        .clk(clk), .rst(rst),
        .RegWrite(reg_write_ctrl), .RegRead(1'b1),
        .rs1(5'd3), .rs2(5'd4), .rd(current_rd),
        .wd(wd_to_rf), .rd1(rd1), .rd2(rd2)
    );

ALU alu_inst (
        .clk(clk),
        .A(rd1), // Always x3
        .B(rd2), // Always x4
        .ALUControl(switches[4:1]),
        .ALUResult(alu_res),
        .Zero(zero_flag)
    );

    reg [31:0] x6_monitor;
    always @(posedge clk) begin
        if (rst) x6_monitor <= 32'b0;
        else if (reg_write_ctrl && current_rd == 5'd6)
            x6_monitor <= wd_to_rf;
    end

    assign out_rd1 = rd1;
    assign out_rd2 = rd2;

    leds led_inst (
        .clk(clk), .rst(rst),
        .writeData({zero_flag, 15'b0, x6_monitor[14:0]}),
        .writeEnable(1'b1),
        .readEnable(1'b0),
        .memAddress(30'b0),
        .leds(leds_out)
    );

endmodule
