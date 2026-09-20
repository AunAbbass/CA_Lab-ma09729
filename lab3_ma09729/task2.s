.globl main
.text

main:
    # 1. Provide test arguments: g=5, h=10, i=2, j=3
    li x10, 5          # a0 = g = 5
    li x11, 10         # a1 = h = 10
    li x12, 2          # a2 = i = 2
    li x13, 3          # a3 = j = 3

    # 2. Call leaf_example (expected result: (5 + 10) - (2 + 3) = 15 - 5 = 10)
    jal x1, leaf_example

    # At this point, x10 (a0) will be 10

    # 3. Clean exit
    li a7, 10          # Environment call to exit
    ecall

leaf_example:
    addi sp, sp, -16
    sw   x20, 8(sp)
    sw   x19, 4(sp)
    sw   x18, 0(sp)

    add  x18, x10, x11      # x18 = 5 + 10 = 15
    add  x19, x12, x13      # x19 = 2 + 3  = 5
    sub  x20, x18, x19      # x20 = 15 - 5 = 10

    addi x10, x20, 0        # x10 = 10 (return value)

    lw   x18, 0(sp)
    lw   x19, 4(sp)
    lw   x20, 8(sp)
    addi sp, sp, 16

    jalr x0, 0(x1)