.text
.globl main

main:
    la x10, array          # x10 = address of array
    li x11, 5              # x11 = length

    jal ra, bubble         # call bubble(array, 5)

End:
    j End                  # stop so we can inspect memory


bubble:
    li x5, 1
    ble x11, x5, Done      # if len <= 1, array is already sorted; return

    li x5, 0               # i = 0
    addi x7, x11, -1       # x7 = len - 1 (limit for the outer loop)

OuterLoop:
    bge x5, x7, Done       # if i >= len - 1, finish

    li x6, 0               # j = 0
    sub x12, x7, x5        # x12 = (len - 1) - i (limit for the inner loop)

InnerLoop:
    bge x6, x12, NextI     # if j >= (len - 1 - i), next i

    # Calculate address for a[j]
    slli x13, x6, 2        # x13 = j * 4
    add x13, x10, x13      # x13 = address of a[j]

    # Load adjacent elements
    lw x14, 0(x13)         # x14 = a[j]
    lw x15, 4(x13)         # x15 = a[j+1] (Notice the 4-byte offset)

    # Compare and swap (Ascending Order)
    ble x14, x15, NoSwap   # if a[j] <= a[j+1], don't swap 

    sw x15, 0(x13)         # a[j] = a[j+1]
    sw x14, 4(x13)         # a[j+1] = a[j] (Temp register not needed, just cross-store)

NoSwap:
    addi x6, x6, 1         # j++
    j InnerLoop

NextI:
    addi x5, x5, 1         # i++
    j OuterLoop

Done:
    ret


.data
array:
    .word 2, 5, 1, 4, 3