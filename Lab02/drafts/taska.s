.text
.globl main

main:
    li x20, 3 #x
    li x21, 0 #a
    li x22, 1 #b
    li x23, 2 #c

switch:
    li x10, 1
    beq x20, x10, CASE1
    li x10, 2
    beq x20, x10, CASE2
    li x10, 3
    beq x20, x10, CASE3
    li x10, 4
    beq x20, x10, CASE4
    j DEFAULT

CASE1:
    add x21, x22, x23
    j END

CASE2:
    sub x21, x22, x23
    j END

CASE3:
    slli x21, x22, 1
    j END

CASE4:
    srli x21, x22, 1
    j END

DEFAULT:
    li x21, 0

END:

