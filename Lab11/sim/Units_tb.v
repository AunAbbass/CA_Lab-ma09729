`timescale 1ns/1ps
module Units_tb;
    reg [31:0] A=0,B=0;
    reg [1:0] op=0;
    reg [2:0] f3=0;
    reg [6:0] f7=0;
    reg branch=0;
    wire [3:0] ctrl;
    wire [31:0] result;
    wire zero,taken;
    integer checks=0;
    ALUControlUnit C(op,f3,f7,ctrl);
    ALU U(A,B,ctrl,result,zero);
    BranchControl BC(branch,f3,A,B,taken);
    task alu_check;
        input [1:0] mode;
        input [2:0] func3;
        input [6:0] func7;
        input [31:0] a,b,expected;
        begin
            op=mode;f3=func3;f7=func7;A=a;B=b;#1; checks=checks+1;
            if (result !== expected || zero !== (expected==0)) $fatal(1,"ALU mismatch %h != %h",result,expected);
        end
    endtask
    task branch_check;
        input enabled;
        input [2:0] func3;
        input [31:0] a,b;
        input expected;
        begin
            branch=enabled;f3=func3;A=a;B=b;#1; checks=checks+1;
            if (taken !== expected) $fatal(1,"branch mismatch funct3=%b",f3);
        end
    endtask
    initial begin
        alu_check(0,0,0,5,7,12);
        alu_check(1,0,0,7,5,2);
        alu_check(2,0,32,5,7,32'hfffffffe);
        alu_check(3,0,127,12,32'hffffffff,11); // negative ADDI regression
        alu_check(2,7,0,10,12,8);
        alu_check(2,6,0,10,12,14);
        alu_check(2,4,0,10,12,6);
        alu_check(2,1,0,1,33,2); // five-bit shift amount
        alu_check(2,5,0,32'h80000000,1,32'h40000000);
        alu_check(2,5,32,32'h80000000,1,32'hc0000000);
        alu_check(3,5,32,32'hfffffff8,2,32'hfffffffe);
        alu_check(2,2,0,32'hffffffff,1,1);
        alu_check(2,3,0,32'hffffffff,1,0);
        alu_check(0,0,0,32'hffffffff,1,0);
        branch_check(1,0,4,4,1); branch_check(1,0,4,5,0);
        branch_check(1,1,4,5,1); branch_check(1,1,4,4,0);
        branch_check(1,4,32'hffffffff,1,1); branch_check(1,4,1,32'hffffffff,0);
        branch_check(1,5,1,32'hffffffff,1); branch_check(1,5,32'hffffffff,1,0);
        branch_check(1,6,1,32'hffffffff,1); branch_check(1,6,32'hffffffff,1,0);
        branch_check(1,7,32'hffffffff,1,1); branch_check(1,7,1,32'hffffffff,0);
        branch_check(0,0,4,4,0); branch_check(1,2,4,4,0);
        $display("PASS Units_tb: %0d checks",checks); $finish;
    end
endmodule
