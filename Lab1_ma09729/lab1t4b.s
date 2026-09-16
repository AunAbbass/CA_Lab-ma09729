#a=x10
#b=x11
#c=x12

.text
.globl main
main:
    li  x10, 0x100
    li  x11, 0x200
    li  x12, 0x300

#initializing array a
    li  t0, 1
    sb  t0, 0(x10)    #a[0]=1
    li  t0, 2
    sb  t0, 1(x10)    #a[1]=2
    li  t0, 3
    sb  t0, 2(x10)    #a[2]=3
    li  t0, 4
    sb  t0, 3(x10)    #a[3]=4

#initializing array b
    li  t1, 10
    sh  t1, 0(x11)    #b[0]=10
    li  t1, 20
    sh  t1, 2(x11)    #b[1]=20
    li  t1, 30
    sh  t1, 4(x11)    #b[2]=30
    li  t1, 40
    sh  x6, 6(x11)    #b[3]=40

#computing c[i]=a[i]+b[i]
    lb  x5, 0(x10)    #t0=a[0]
    lh  x6, 0(x11)    #t1=b[0]
    add x7, x5, x6
    sw  x7, 0(x12)    #c[0]

    lb  x5, 1(x10)    #t0=a[1]
    lh  x6, 2(x11)    #t1=b[1]
    add x7, x5, x6
    sw  x7, 4(x12)    #c[1]

    lb  x5, 2(x10)    #t0=a[2]
    lh  x6, 4(x11)    #t1=b[2]
    add x7, x5, x6
    sw  x7, 8(x12)    #c[2]

    lb  x5, 3(x10)    #t0=a[3]
    lh  x6, 6(x11)    #t1=b[3]
    add x7, x5, x6
    sw  x7, 12(x12)   #c[3]

end:
    j end
