# x10 = base address of a (0x200)
addi x10, x0, 0x200

# i = 0
addi x22, x0, 0

# for (i = 0; i < 10; i++)
loop1:
    slti x5, x22, 10       # x5 = 1 if i < 10
    beq  x5, x0, loop2     # if i >= 10 go to second loop

    slli x6, x22, 2        # x6 = i * 4 (4-byte int
    add  x7, x10, x6       # address  a[i]
    sw   x22, 0(x7)        # a[i] = i

    addi x22, x22, 1       # i++
    jal  x0, loop1
 


