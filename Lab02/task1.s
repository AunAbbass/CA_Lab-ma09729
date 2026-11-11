.globl main
.text


// assuming that variables f to j are in registers x19–x23
bne x22, x23, Else
add x19, x20, x21
beq x0, x0, Exit   // unconditional jump
Else: sub x19, x20, x21

Exit: # the code after if/else goes here
