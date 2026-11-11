.text
.globl main
main:
    li x20 , 5 #// int a = 5 
    li x21 , 0 #//  0 
    li x22 , 0 #//  0


    add x5 , x21 , x22 #// int b = 0 + 0
    addi x20 , x5 , 32 #// int a = b + 32
    add x6 , x20 , x5 #// a + b
    addi x7 , x6 , -5 #// d = a + b - 5
    sub x8 , x20 , x7 #// a - d 
    sub x9 , x5 , x20 #// b - a
    add x10 , x8 , x9 #// (a-d) + (b-a)
    add x11 , x10 , x7 #// e = (a-d) + (b-a) + d 
    add x12 , x20 , x5  #// a + b 
    add x13 , x7 , x11 #// d + e 
    add x11 , x12 , x13 #// e = a + b + d + e

end:
    j end