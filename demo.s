# ROM demonstration; byte PC starts at zero.
addi x1, x0, 5
addi x2, x0, 7
add x3, x1, x2
sw x3, 0(x0)
lw x4, 0(x0)
beq x4, x3, equal
addi x5, x0, 99 # skipped
equal: addi x5, x4, -1
addi x6, x0, 3
loop: addi x6, x6, -1
bne x6, x0, loop
sw x5, 4(x0)
lw x7, 4(x0)
addi x0, x0, 123 # x0 must stay zero
sw x7, 256(x0) # LEDs = 11
poll: lw x8, 512(x0) # switches
sw x8, 256(x0) # LEDs = switches
beq x0, x0, poll
