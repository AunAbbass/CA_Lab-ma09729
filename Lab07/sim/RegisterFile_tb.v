`timescale 1ns / 1ps

module RegisterFile_tb;
    reg clk;
    reg rst;
    reg RegWrite;
    reg RegRead;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] wd;
    wire [31:0] rd1;
    wire [31:0] rd2;

    RegisterFile uut (
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .RegRead(RegRead),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        RegWrite = 0;
        RegRead = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        wd = 0;
    #15 rst = 0;
    $display("Test Case v: Resetting system and checking if x1 is 0");
    RegRead = 1; rs1 = 1;
    #1;
    if (rd1 === 32'b0) $display("SUCCESS: x1 is zero after reset.");
    else $display("ERROR: x1 is not zero!");

    $display("Test Case i: Writing 0xDEADBEEF to x5");
    @(negedge clk);
    RegWrite = 1; rd = 5; wd = 32'hDEADBEEF;
    @(negedge clk);
    RegWrite = 0; rs1 = 5; RegRead = 1;
    #1;
    if (rd1 === 32'hDEADBEEF) $display("SUCCESS: x5 read correctly.");
    else $display("ERROR: x5 read %h", rd1);

    // --- Test Case ii: Attempt to write to x0 ---
    $display("Test Case ii: Attempting to write 0xFFFFFFFF to x0");
    @(negedge clk);
    RegWrite = 1; rd = 0; wd = 32'hFFFFFFFF;
    @(negedge clk);
    RegWrite = 0; rs1 = 0;
    #1;
    if (rd1 === 32'h0) $display("SUCCESS: x0 remains zero.");
    else $display("ERROR: x0 was overwritten with %h!", rd1);

    // --- Test Case iii: Simultaneous two read ports ---
    $display("Test Case iii: Writing to x10 and checking dual read (x5 and x10)");
    @(negedge clk);
    RegWrite = 1; rd = 10; wd = 32'hCAFEBABE;
    @(negedge clk);
    RegWrite = 0; rs1 = 5; rs2 = 10; RegRead = 1;
    #1;
    if (rd1 === 32'hDEADBEEF && rd2 === 32'hCAFEBABE)
        $display("SUCCESS: Simultaneous read verified.");
    else $display("ERROR: Dual read failed. rd1:%h, rd2:%h", rd1, rd2);

    // --- Test Case iv: Overwrite a register ---
    $display("Test Case iv: Overwriting x5 with 0x12345678");
    @(negedge clk);
    RegWrite = 1; rd = 5; wd = 32'h12345678;
    @(negedge clk);
    RegWrite = 0; rs1 = 5;
    #1;
if (rd1 === 32'h12345678) $display("SUCCESS: x5 overwritten correctly.");
else $display("ERROR: Overwrite failed. x5 is %h", rd1);

// --- Added Reset at the end ---
$display("Final Test: Applying reset at end of simulation");
@(negedge clk);
rst = 1;       // Activate reset
@(negedge clk);
rst = 0;       // Release reset
rs1 = 5;       // Check x5 (which we previously wrote to)
rs2 = 10;      // Check x10 (which we previously wrote to)
#1;
if (rd1 === 32'b0 && rd2 === 32'b0)
    $display("SUCCESS: Registers cleared at simulation end.");
else
    $display("ERROR: Registers failed to clear! rd1:%h, rd2:%h", rd1, rd2);

$display("Simulation Finished.");
$finish;
end

endmodule
