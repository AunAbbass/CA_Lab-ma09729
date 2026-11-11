.globl 
.text

fact:
    addi sp, sp, -8       # create 8-byte stack frame
    sw ra, 4(sp)          # save return address
    sw a0, 0(sp)          # save n

    li t0, 1              # acc = 1

Loop:
    lw a0, 0(sp)          # load n from stack
    blez a0, Done         # if n <= 0, exit

    mul t0, t0, a0        # acc = acc * n
    addi a0, a0, -1       # n = n - 1
    sw a0, 0(sp)          # save updated n

    j Loop

Done:
    mv a0, t0             # return acc

    lw ra, 4(sp)          # restore return address
    addi sp, sp, 8        # remove stack frame
    ret