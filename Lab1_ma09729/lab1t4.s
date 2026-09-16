.text
.globl main

 main:

#1.	Store x10 as unsigned integer at address 0x100.
li x10, 0x78786464
li x11, 0xA8A81919
sw x10, 0x100(x0)

#2.	Store x11 as unsigned integer at address 0x1F0.
li x10, 0x78786464
li x11, 0xA8A81919
sw x11, 0x1F0(x0)

#3.	Load an unsigned short integer (two bytes) from address 0x100 in x12.
lhu x12, 0x100(x0)

#4.	Load a short integer from address 0x1F0 in register x13.
lh x13, 0x1F0(x0)

#5.	Load a singed character from address 0x1F0 in register x14.
lb x14, 0x1F0(x0)

end :
    j end
