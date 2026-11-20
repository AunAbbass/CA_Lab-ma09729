`timescale 1ns/1ps
module Task1_tb;
    reg clk=0, reset=1, PCSrc=0;
    reg [31:0] instruction=0;
    wire [31:0] pc, next_pc, plus4, target, imm;
    integer checks=0;
    always #5 clk=~clk;
    ProgramCounter PC(clk,reset,next_pc,pc);
    pcAdder A(reset,pc,plus4);
    branchAdder B(reset,pc,imm,target);
    mux2 M(reset,plus4,target,PCSrc,next_pc);
    immGen G(reset,instruction,imm);
    task check;
        input [31:0] actual, expected;
        input [255:0] label;
        begin
            checks=checks+1;
            if (actual !== expected) begin
                $display("FAIL %s actual=%h expected=%h",label,actual,expected);
                $fatal(1);
            end
        end
    endtask
    task check_imm;
        input [31:0] ins, expected;
        begin instruction=ins; #1; check(imm,expected,"immediate"); end
    endtask
    initial begin
        #1; check(pc,0,"reset PC"); check(plus4,0,"reset adder");
        check(target,0,"reset branch"); check(next_pc,0,"reset mux"); check(imm,0,"reset imm");
        @(negedge clk); reset=0;
        @(posedge clk); #1; check(pc,4,"sequential PC 4");
        @(posedge clk); #1; check(pc,8,"sequential PC 8");
        @(negedge clk); instruction=32'h00000463; PCSrc=1; // beq x0,x0,+8
        #1; check(imm,4,"B +8 halfword units"); check(target,16,"forward target");
        @(posedge clk); #1; check(pc,16,"taken forward PC");
        @(negedge clk); instruction=32'hfe000ce3; // beq x0,x0,-8
        #1; check(imm,32'hfffffffc,"B -8 halfword units"); check(target,8,"backward target");
        @(posedge clk); #1; check(pc,8,"taken backward PC");
        @(negedge clk); PCSrc=0;
        @(posedge clk); #1; check(pc,12,"not taken PC+4");
        check_imm(32'h00a10093,10); // addi x1,x2,10
        check_imm(32'hfff10093,32'hffffffff);
        check_imm(32'h80010093,32'hfffff800);
        check_imm(32'h7ff10093,32'h000007ff);
        check_imm(32'hfe312e23,32'hfffffffc); // sw x3,-4(x2)
        check_imm(32'h00312623,12); // sw x3,12(x2)
        check_imm(32'h80000063,32'hfffff800); // branch -4096 -> -2048 units
        check_imm(32'h7e000fe3,32'h000007ff); // branch +4094 -> +2047 units
        check_imm(32'hffffffff,0);
        reset=1; #1; check(pc,0,"mid-run reset"); check(imm,0,"reset immediate");
        $display("PASS Task1_tb: %0d checks",checks); $finish;
    end
    initial begin #2000; $fatal(1,"timeout"); end
endmodule
