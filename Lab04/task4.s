.text
.globl main

main:
    addi sp, sp, -16       # Allocate 16 bytes on the stack
    sw ra, 12(sp)          # Save return address

    # Setup arguments for sum_of_squares(array_ptr, length)
    la a0, array           # a0 = base address of array
    lw a1, length          # a1 = length of array

    # --- Nested Procedure Call 1 ---
    jal ra, sum_of_squares

    # The result (54) is now in a0. 
    # Move it to x10 (standard exit code register) and halt.
    mv x10, a0

End:
    j End                  # Infinite loop to cleanly stop execution


# Procedure: sum_of_squares
# Arguments: a0 (array pointer), a1 (array length)
# Returns:   a0 (total sum of squares)

sum_of_squares:
    # -----------------------------------------------------------------
    # Stack Management (Prologue): 
    # Because we will call 'square', our 'ra' will be overwritten.
    # We must save 'ra'. We also use saved registers (s0-s3) which 
    # must be preserved for the caller according to the RISC-V ABI.
    # -----------------------------------------------------------------
    addi sp, sp, -32       # Allocate 32 bytes on the stack
    sw ra, 28(sp)          # Save return address
    sw s0, 24(sp)          # Save s0 (will hold array pointer)
    sw s1, 20(sp)          # Save s1 (will hold length)
    sw s2, 16(sp)          # Save s2 (will hold running sum)
    sw s3, 12(sp)          # Save s3 (will hold loop index)

    # Initialize variables into preserved registers
    mv s0, a0              # s0 = array pointer
    mv s1, a1              # s1 = length
    li s2, 0               # s2 = sum = 0
    li s3, 0               # s3 = index (i) = 0

Loop:
   
    bge s3, s1, Done       # if (i >= length), exit the loop

    # Calculate address of array[i]
    slli t0, s3, 2         # t0 = i * 4 (word size offset)
    add t0, s0, t0         # t0 = base_address + offset
    lw a0, 0(t0)           # a0 = array[i] (Setup argument for 'square')

  
    jal ra, square         # Call square(array[i])
    
    add s2, s2, a0         # sum = sum + returned squared value

    addi s3, s3, 1         # i++
    j Loop                 # Jump back to start of loop

Done:
    mv a0, s2              # Place the final sum in return register a0

   
    # Stack Management (Epilogue): Restore all registers to their 
    # original state before returning to 'main'.
  
    lw ra, 28(sp)
    lw s0, 24(sp)
    lw s1, 20(sp)
    lw s2, 16(sp)
    lw s3, 12(sp)
    addi sp, sp, 32        # Deallocate stack space

    ret                    # Return to main


# Procedure: square
# Arguments: a0 (value to square)
# Returns:   a0 (squared value)

square:
    # Note: This is a "Leaf Procedure". It does not call any other 
    # functions, so it does not overwrite 'ra'. Therefore, it does 
    # not require stack management prologue/epilogue.
    mul a0, a0, a0         # a0 = a0 * a0
    ret                    # Return to sum_of_squares


.data
array:  .word 2, 3, 4, 5   # The numbers to square (4 + 9 + 16 + 25 = 54)
length: .word 4            # The number of items in the array