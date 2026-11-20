`timescale 1ns / 1ps

module TopLevelProcessor(input clk, reset, input [15:0] switches_in, output [15:0] leds_out);
    wire [31:0] pc_current, pc_next, pc_plus4, pc_branch, instruction, imm_ext;
    wire [31:0] rd1, rd2, alu_operand_b, alu_result, read_data, write_back_data;
    wire [3:0] alu_ctrl;
    wire [1:0] alu_op;
    wire reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_zero, pcsrc_sel;
    wire word_access=(instruction[14:12]==3'b010);
    // Only aligned LW/SW are implemented; unsupported widths have no memory effect.
    wire memory_ok=word_access && (alu_result[1:0]==0);
    ProgramCounter PC_Inst(clk,reset,pc_next,pc_current);
    pcAdder PC_Add4(reset,pc_current,pc_plus4);
    instructionMemory IM_Inst(reset,pc_current,instruction);
    MainControl Control(instruction[6:0],reg_write,alu_op,mem_read,mem_write,alu_src,mem_to_reg,branch);
    ALUControlUnit ALU_Control(alu_op,instruction[14:12],instruction[31:25],alu_ctrl);
    RegisterFile RegFile(.clk(clk),.rst(reset),.RegWrite(reg_write && (!mem_read || memory_ok)),
        .RegRead(1'b1),.rs1(instruction[19:15]),.rs2(instruction[24:20]),.rd(instruction[11:7]),
        .wd(write_back_data),.rd1(rd1),.rd2(rd2));
    immGen Imm_Gen_Inst(reset,instruction,imm_ext);
    mux2 ALU_Mux(reset,rd2,imm_ext,alu_src,alu_operand_b);
    ALU ALU_Inst(rd1,alu_operand_b,alu_ctrl,alu_result,alu_zero);
    addressDecoder MMIO_System(.clk(clk),.rst(reset),.address(alu_result),
        .readEnable(mem_read && memory_ok),.writeEnable(mem_write && memory_ok),
        .writeData(rd2),.switches_in(switches_in),.readData(read_data),.leds_out(leds_out));
    mux2 WB_Mux(reset,alu_result,read_data,mem_to_reg,write_back_data);
    branchAdder Br_Add(reset,pc_current,imm_ext,pc_branch);
    BranchControl Branch_Control(branch,instruction[14:12],rd1,rd2,pcsrc_sel);
    mux2 PC_Mux(reset,pc_plus4,pc_branch,pcsrc_sel,pc_next);
endmodule
