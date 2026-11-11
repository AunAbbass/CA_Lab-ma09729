`timescale 1ns / 1ps

module tb_countdown_fsm;

    // Testbench signals
    reg clk;
    reg rst;
    reg start;
    reg ack;
    reg [7:0] load_val;
    
    wire done_out;
    wire [7:0] count_val;

    // Instantiate the Unit Under Test (UUT)
    countdown_fsm #(.COUNT_WIDTH(8)) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .ack(ack),
        .load_val(load_val),
        .done_out(done_out),
        .count_val(count_val)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        start = 0;
        ack = 0;
        load_val = 8'd5; // Count down from 5

        // Wait for global reset
        #20;
        rst = 0;
        
        // Trigger start
        #10;
        start = 1;
        #10;
        start = 0; // De-assert start
        
        // Wait for done_out to go high (allow time for 5 clock cycles)
        wait(done_out == 1);
        
        // Assert Acknowledge
        #10;
        ack = 1;
        #10;
        ack = 0;
        
        // Test a second countdown
        #20;
        load_val = 8'd3;
        start = 1;
        #10;
        start = 0;
        
        wait(done_out == 1);
        #10;
        ack = 1;
        #10;
        ack = 0;
        
        #50 $finish;
    end

endmodule
