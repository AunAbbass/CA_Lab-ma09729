.globl 
.text

strcpy:
    # 1. Prologue: Allocate stack space and save s0 (x8)
    addi sp, sp, -16        # Allocate stack frame (16-byte aligned)
    sw   s0, 0(sp)          # Save s0 (used for index variable 'i')

    # 2. Initialize loop variable: i = 0
    addi s0, x0, 0          # s0 = i = 0

L1:
    # 3. Calculate address of y[i] and load the byte
    add  t0, a1, s0         # t0 = address of y[i] (base y + i)
    lbu  t1, 0(t0)          # t1 = y[i] (unsigned byte)

    # 4. Calculate address of x[i] and store the byte
    add  t2, a0, s0         # t2 = address of x[i] (base x + i)
    sb   t1, 0(t2)          # x[i] = y[i]

    # 5. Check loop condition: while (x[i] != '\0')
    beq  t1, x0, L2         # If y[i] == '\0' (0), exit loop
    addi s0, s0, 1          # i = i + 1
    jal  x0, L1             # Repeat loop

L2:
    # 6. Epilogue: Restore saved register and deallocate stack
    lw   s0, 0(sp)          # Restore original s0
    addi sp, sp, 16         # Restore stack pointer
    jalr x0, 0(ra)          # Return to caller (ret)