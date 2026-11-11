#The registers we used
#a-- x1
#b--x2
#d--x3
#e--x6

.text
.globl main
main:
    li x1, 5 #a=5
    li x9, 5
    add x2, x0,x0 #b=0+0
    addi x1, x2, 32 #a=b+32
    add x3, x1 , x2 #d=a+b
    sub x3, x3, x9 #d=d-5
    sub x4, x1, x3 #q=a-d
    sub x5, x2, x1 #p=b-a
    add x6, x4, x5 #e=q+p
    add x6, x6, x3 #e=e+d
    add x6, x6, x1
    add x6, x6, x2
    add x6, x6, x3

end:
    j end
