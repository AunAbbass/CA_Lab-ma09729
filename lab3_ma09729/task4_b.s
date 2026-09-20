.globl
.text


strcpy:
    addi sp, sp, -4        # adjust stack pointer for 4 bytes
    sw   x19, 0(sp)        # save x19

    # Initialize i = 0
    add  x19, x0, x0       # i = 0

L1:
    # Load y[i]
    add  x5, x11, x19      # x5 = address of y[i]
    lbu  x6, 0(x5)         # x6 = y[i]

    # Store into x[i]
    add  x7, x10, x19      # x7 = address of x[i]
    sb   x6, 0(x7)         # x[i] = y[i]

    # Test for '\0' and loop
    beq  x6, x0, L2        # if y[i] == 0, go to L2
    addi x19, x19, 1       # i = i + 1
    jal  x0, L1            # jump back to L1

L2:
    lw   x19, 0(sp)        # restore old x19
    addi sp, sp, 4         # restore stack pointer
    jalr x0, 0(x1)         # ret