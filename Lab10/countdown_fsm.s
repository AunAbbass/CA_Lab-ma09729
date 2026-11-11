    li   s0, 0x300          # Load Switch Base Address
    li   s1, 0x200          # Load LED Base Address
    # Initialization
    sw   zero, 0(s1)

WAIT_LOOP:
    # IDLE state
    lw   t0, 0(s0)          # Read Switches
    beq  t0, zero, WAIT_LOOP # If Switch == 0, do nothing

    # If switch is not zero
    mv   a0, t0             # Pass switch value to function argument
    jal  ra, COUNTDOWN_SUB  # Call function

    # Go back to IDLE state
    j    WAIT_LOOP

COUNTDOWN_SUB:
    # Saving values on stack
    addi sp, sp, -8
    sw   ra, 4(sp)
    sw   s2, 0(sp)
    mv   s2, a0             # Initialize counter with switch value

COUNT_LOOP:
    sw   s2, 0(s1)          # Display current counter on LEDs
    # Delay: To get ~1 second delay: (10,000,000 cycles / ~3 cycles per loop
    li   t1, 3333333

DELAY:
    addi t1, t1, -1
    bne  t1, zero, DELAY    # Loop until delay finishes

    # Decrement Counter
    addi s2, s2, -1         # Counter = Counter - 1
    bne  s2, zero, COUNT_LOOP # If not zero, repeat loop

    # Restore values from stack
    lw   s2, 0(sp)
    lw   ra, 4(sp)
    addi sp, sp, 8
    ret
