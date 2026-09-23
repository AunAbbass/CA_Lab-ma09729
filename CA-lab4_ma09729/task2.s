.text
.globl main

main:
    li a0, 5              # x10 = 5, argument to ntri
    jal ra, ntri          # call ntri(5)

    # Result is returned in a0 (x10)
    # For ntri(5), x10 should now be 15

    j End                  # stop here



ntri:
    addi sp, sp, -8       # make 8-byte stack frame
    sw ra, 4(sp)          # save return address
    sw a0, 0(sp)          # save original num

    li t0, 1              # x5 = 1
    ble a0, t0, Base      # if num <= 1, go to Base

    addi a0, a0, -1       # x10 = num - 1
    jal ra, ntri          # recursive call

    lw t0, 0(sp)          # restore original num
    add a0, t0, a0        # x10 = num + ntri(num - 1)

    j Done                 # go to cleanup

Base:
    li a0, 1              # x10 = 1

Done:
    lw ra, 4(sp)          # restore return address
    addi sp, sp, 8        # remove stack frame
    ret                    # return to caller


End:
    j End                  # infinite loop so program stays here