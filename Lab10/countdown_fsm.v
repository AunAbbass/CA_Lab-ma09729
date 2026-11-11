`timescale 1ns / 1ps

module countdown_fsm #(
    parameter COUNT_WIDTH = 8
)(
    input wire clk,
    input wire rst,             // Active-high synchronous reset
    input wire start,           // Signal to begin countdown
    input wire ack,             // Acknowledge signal to return to wait state
    input wire [COUNT_WIDTH-1:0] load_val, // Value to count down from
    
    output reg done_out,        // High when countdown is complete
    output reg [COUNT_WIDTH-1:0] count_val // Current counter value
);

    // State Encoding (Local Parameters)
    localparam S_WAIT  = 2'b00; // Input Waiting State
    localparam S_COUNT = 2'b01; // Countdown State
    localparam S_DONE  = 2'b10; // Done/Acknowledge State

    // State Variables
    reg [1:0] current_state, next_state;
    reg [COUNT_WIDTH-1:0] next_count;

    // 1. Sequential Logic: State and Register Updates
    always @(posedge clk) begin
        if (rst) begin
            current_state <= S_WAIT;
            count_val     <= {COUNT_WIDTH{1'b0}};
        end else begin
            current_state <= next_state;
            count_val     <= next_count;
        end
    end

    // 2. Combinational Logic: Next State and Output Logic
    always @(*) begin
        // Default assignments to prevent latches
        next_state = current_state;
        next_count = count_val;
        done_out   = 1'b0;

        case (current_state)
            
            // --- Input Waiting State ---
            S_WAIT: begin
                if (start) begin
                    next_count = load_val;  // Load the counter
                    next_state = S_COUNT;   // Transition to countdown
                end
            end
            
            // --- Countdown State ---
            S_COUNT: begin
                if (count_val > 0) begin
                    next_count = count_val - 1; // Decrement counter
                end else begin
                    next_state = S_DONE;        // Counter reached zero
                end
            end
            
            // --- Done / Acknowledge State ---
            S_DONE: begin
                done_out = 1'b1;            // Trigger output flag
                if (ack) begin
                    next_state = S_WAIT;    // Wait for ack to reset FSM
                end
            end
            
            // Fallback safety
            default: begin
                next_state = S_WAIT;
            end
            
        endcase
    end

endmodule
