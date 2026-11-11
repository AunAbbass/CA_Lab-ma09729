30000413    li   s0, 0x300          # Load Switch Base Address
20000493    li   s1, 0x200          # Load LED Base Address
0004A023    sw   zero, 0(s1)        # Initialization: Clear LEDs

WAIT_LOOP:
00042283    lw   t0, 0(s0)          # Read Switches
FE028EE3    beq  t0, zero, WAIT_LOOP # If Switch == 0, loop
00028513    mv   a0, t0             # Pass switch value to a0
008000EF    jal  ra, COUNTDOWN_SUB  # Call subroutine
FF1FF06F    j    WAIT_LOOP          # Return to IDLE state

COUNTDOWN_SUB:
FF810113    addi sp, sp, -8         # Save context on Stack
00112223    sw   ra, 4(sp)
01212023    sw   s2, 0(sp)
00050913    mv   s2, a0             # Initialize counter

COUNT_LOOP:
0124A023    sw   s2, 0(s1)          # Update LED output
0032E337    lui  t1, 0x32E          # li t1, 3333333 (Part 1)
cd530313    addi t1, t1, -811       # li t1, 3333333 (Part 2)

DELAY:
FFF30313    addi t1, t1, -1         # Decrement delay timer
FE031EE3    bne  t1, zero, DELAY    # Delay loop

            # Decrement Counter
FFF90913    addi s2, s2, -1
FE0916E3    bne  s2, zero, COUNT_LOOP

            # Restore context from Stack
00012903    lw   s2, 0(sp)
00412083    lw   ra, 4(sp)
00810113    addi sp, sp, 8
00008067    ret                     # Return to main
