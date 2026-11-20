`timescale 1ns / 1ps

module addressDecoder(input clk, rst, input [31:0] address,
    input readEnable, writeEnable, input [31:0] writeData,
    input [15:0] switches_in, output reg [31:0] readData, output reg [15:0] leds_out);
    wire [31:0] ram_data;
    wire ram_select=(address<32'h100 && address[1:0]==0);
    DataMemory dm_inst(.clk(clk), .MemWrite(writeEnable && ram_select && !rst),
        .address(address), .write_data(writeData), .read_data(ram_data));
    always @(posedge clk or posedge rst)
        if (rst) leds_out<=0;
        else if (writeEnable && address==32'h100) leds_out<=writeData[15:0];
    always @(*) begin
        readData=0;
        if (readEnable) begin
            if (ram_select) readData=ram_data;
            else if (address==32'h100) readData={16'b0,leds_out};
            else if (address==32'h200) readData={16'b0,switches_in};
        end
    end
endmodule
