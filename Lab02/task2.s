.globl main
.text


# x -> x20
# a -> x21
# b -> x22
# c -> x23

li x20 , 3
li x21 , 0
li x22 , 1
li x23 , 2

Switch:
    li x10 , 1
    beq x20 , x10 , Case1
    li x10 , 2
    beq x20 , x10 , Case2
    li x10 , 3
    beq x20 , x10 , Case3
    li x10 , 4
    beq x20 , x10 , Case4
    j Default

Case1:
    add x21 , x22 , x23
    beq x0 , x0 , end

Case2:
    sub x21 , x22 , x23
    beq x0 , x0 , end

Case3:
    add x21 , x22 , x23
    beq x0 , x0 , end

Case4:
    li x24 , 2
    div x21 , x22 , x24
    beq x0 , x0 , end

Default:
    li x21 , 0

end:
    j end
