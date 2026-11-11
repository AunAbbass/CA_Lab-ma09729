.globl main
.text


# i -> 22
# sum -> 23
# array -> 24
# end value -> 25
# temp -> 26

li x22 , 0
li x23 , 0
li x24 , 0x200
li x25 , 10

Loop1:
    beq x25 , x22 , mid
    sw x22 , 0(x24)
    addi x24 , x24 , 4
    addi x22 , x22 , 1
    beq x0 , x0 , Loop1

mid:
    li x22 , 0
    li x24 , 0x200

Loop2:
    beq x25 , x22 , end
    lw x26 , 0(x24)
    add x23 , x23 , x26
    addi x24 , x24 , 4
    addi x22 , x22 , 1
    beq x0 , x0 , Loop2

end:
    j end
