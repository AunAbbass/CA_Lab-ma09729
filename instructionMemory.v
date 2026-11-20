`timescale 1ns / 1ps

// Combinational ROM makes instruction fetch part of the same cycle.
// Edit these constants to change the program. demo.hex is a reference listing.
module instructionMemory(input reset, input [31:0] instAddress, output reg [31:0] instruction);
    always @(*) begin
        instruction=32'h00000013; // NOP for reset or out-of-range PC
        if (!reset) begin
            case (instAddress)
                32'd0: instruction=32'h00500093; // addi x1, x0, 5
                32'd4: instruction=32'h00700113; // addi x2, x0, 7
                32'd8: instruction=32'h002081b3; // add x3, x1, x2
                32'd12: instruction=32'h00302023; // sw x3, 0(x0)
                32'd16: instruction=32'h00002203; // lw x4, 0(x0)
                32'd20: instruction=32'h00320463; // beq x4, x3, equal
                32'd24: instruction=32'h06300293; // addi x5, x0, 99 # skipped
                32'd28: instruction=32'hfff20293; // equal: addi x5, x4, -1
                32'd32: instruction=32'h00300313; // addi x6, x0, 3
                32'd36: instruction=32'hfff30313; // loop: addi x6, x6, -1
                32'd40: instruction=32'hfe031ee3; // bne x6, x0, loop
                32'd44: instruction=32'h00502223; // sw x5, 4(x0)
                32'd48: instruction=32'h00402383; // lw x7, 4(x0)
                32'd52: instruction=32'h07b00013; // addi x0, x0, 123 # x0 must stay zero
                32'd56: instruction=32'h10702023; // sw x7, 256(x0) # LEDs = 11
                32'd60: instruction=32'h20002403; // poll: lw x8, 512(x0) # switches
                32'd64: instruction=32'h10802023; // sw x8, 256(x0) # LEDs = switches
                32'd68: instruction=32'hfe000ce3; // beq x0, x0, poll
                default: instruction=32'h00000013;
            endcase
        end
    end
endmodule
