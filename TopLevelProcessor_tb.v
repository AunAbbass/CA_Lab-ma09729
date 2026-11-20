`timescale 1ns/1ps
module TopLevelProcessor_tb;
    reg clk=0, reset=1;
    reg [15:0] switches_in=16'ha5a5;
    wire [15:0] leds_out;
    integer checks=0;
    always #5 clk=~clk;
    TopLevelProcessor dut(clk,reset,switches_in,leds_out);
    task check;
        input [31:0] actual, expected;
        input [255:0] label;
        begin
            checks=checks+1;
            if (actual !== expected) begin
                $display("FAIL %s actual=%h expected=%h",label,actual,expected); $fatal(1);
            end
        end
    endtask
    task step;
        input [31:0] expected_pc;
        begin @(posedge clk); #1; check(dut.pc_current,expected_pc,"PC after instruction"); end
    endtask
    initial begin
        #1; check(dut.pc_current,0,"reset PC"); check({16'b0,leds_out},0,"reset LEDs");
        @(negedge clk); reset=0;
        step(4); check(dut.RegFile.registers[1],5,"x1");
        step(8); check(dut.RegFile.registers[2],7,"x2");
        step(12); check(dut.RegFile.registers[3],12,"ADD");
        step(16); check(dut.MMIO_System.dm_inst.mem[0],12,"SW byte address 0");
        step(20); check(dut.RegFile.registers[4],12,"LW");
        step(28); // taken BEQ skips address 24
        step(32); check(dut.RegFile.registers[5],11,"negative ADDI");
        step(36); step(40); step(36); step(40); step(36); step(40); step(44);
        check(dut.RegFile.registers[6],0,"backward loop terminates");
        step(48); check(dut.MMIO_System.dm_inst.mem[1],11,"SW byte address 4");
        step(52); check(dut.RegFile.registers[7],11,"second LW");
        step(56); check(dut.RegFile.registers[0],0,"x0 write ignored");
        step(60); check({16'b0,leds_out},11,"computed LED result");
        step(64); check(dut.RegFile.registers[8],32'ha5a5,"switch load");
        step(68); check({16'b0,leds_out},32'ha5a5,"switch LED store");
        step(60);
        @(negedge clk); switches_in=16'h1234;
        step(64); step(68); check({16'b0,leds_out},32'h1234,"switch update");
        @(negedge clk); reset=1; #1;
        check(dut.pc_current,0,"reset PC mid-program"); check({16'b0,leds_out},0,"reset LEDs mid-program");
        check(dut.RegFile.registers[8],0,"reset registers");
        // RAM intentionally persists across reset.
        check(dut.MMIO_System.dm_inst.mem[0],12,"RAM persists");
        $display("PASS TopLevelProcessor_tb: %0d checks",checks); $finish;
    end
    initial begin #5000; $fatal(1,"timeout"); end
endmodule
