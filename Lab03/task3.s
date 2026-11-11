.globl
.text 


swap:
    # 1. Calculate address of v[k]: base_address + (k * 4)
    slli x5, x11, 2       # x5 (t0) = k * 4
    add  x5, x10, x5       # x5 = &v[k]

    # 2. Load v[k] and v[k+1] into temporary registers
    lw   x6, 0(x5)         # x6 (t1) = temp = v[k]
    lw   x7, 4(x5)         # x7 (t2) = v[k+1]

    # 3. Store the values into swapped positions
    sw   x7, 0(x5)         # v[k] = v[k+1]
    sw   x6, 4(x5)         # v[k+1] = temp

    # 4. Return to caller
    jalr x0, 0(x1)         # ret