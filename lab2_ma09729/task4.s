.globl main
.text


# array start -- x10
# current array address -- x11
# sum -- x12
# a -> x5
# b -> x6
# i -> x7
# j -> x29

li x5 , 3
li x6 , 3
li x7 , 0
li x10 , 0x100

Loop1:
    beq x7 , x5 , end
    li x29 , 0
    beq x0 , 0 , Loop2

mid:
    addi x7 , x7 , 1
    beq x0 , 0 , Loop1

Loop2:
    beq x29 , x6 , mid
    li x11 , 4
    mul x11 , x11 , x29
    add x11 , x11 , x10
    add x12 , x7 , x29
    sw x12 , 0(x11)
    addi x29 , x29 , 1
    beq x0 , 0 , Loop2

end:
    j end
