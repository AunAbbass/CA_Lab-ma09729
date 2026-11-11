`timescale 1ns / 1ps

module TopModule_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [15:0] switches;

    // Outputs
    wire [15:0] leds_out;
    wire [31:0] tb_rd1, tb_rd2; // New wires to capture the outputs

    // Instantiate the Unit Under Test (UUT)
    TopModule uut (
        .clk(clk),
        .rst(rst),
        .switches(switches),
        .leds_out(leds_out),
        .out_rd1(tb_rd1), // Connect to TB wire
        .out_rd2(tb_rd2)  // Connect to TB wire
    );

    // Clock generation: 100MHz (10ns period)
    always #5 clk = ~clk;

    // Task to simulate flipping sw[0] (RegWrite)
    task pulse_write;
        begin
            #10 switches[0] = 1;
            #10 switches[0] = 0;
            #10;
        end
    endtask

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        switches = 16'b0;

        // Reset the system
        #20 rst = 0;
        #20;

        // --- STEP 1: Store value 10 into x3 ---
        $display("Step 1: Storing 10 into x3 (State 01)");
        switches[6:5] = 2'b01;          // Set State to 01
        switches[15:7] = 9'd10;         // Data = 10 (mapped to switches[15:7])
        pulse_write();

        // --- STEP 2: Store value 25 into x4 ---
        $display("Step 2: Storing 25 into x4 (State 10)");
        switches[6:5] = 2'b10;          // Set State to 10
        switches[15:7] = 9'd25;         // Data = 25
        pulse_write();

        // --- STEP 3: Perform ADD and store in x6 ---
        $display("Step 3: Adding x3 + x4 -> x6 (State 11)");
        switches[6:5] = 2'b11;          // Set State to 11
        switches[4:1] = 4'b0000;        // ALUControl = ADD
        
        // Wait for ALU to settle (Crucial for clocked ALUs)
        #20;

        pulse_write();

        // --- STEP 4: Observe Results ---
        #20;
        $display("Final Result on LEDs: %d (Binary: %b)", leds_out[14:0], leds_out[14:0]);

        if (leds_out[14:0] == 15'd35) begin
            $display("SUCCESS: 10 + 25 = 35 captured in x6.");
        end else begin
            $display("FAILURE: Expected 35, got %d", leds_out[14:0]);
        end

        // --- STEP 5: Test Zero Flag (10 - 10) ---
        $display("Step 5: Subtracting x3 - x3 (Expect Zero Flag)");
        switches[4:1] = 4'b0001;        // ALUControl = SUB

        switches[6:5] = 2'b10;
        switches[15:7] = 9'd10;
        pulse_write();
        #10;

        if (leds_out[15] == 1'b1)
            $display("SUCCESS: Zero Flag detected!");

        #100 $finish;
    end

endmodule
