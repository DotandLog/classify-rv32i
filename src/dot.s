.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0         

loop_start:
    bge t1, a2, loop_end  # If loop counter >= element count, exit loop
    
    mul t2, a3, t1       # Calculate offset for first array: t2 = t1 * stride0
    mul t3, a4, t1       # Calculate offset for second array: t3 = t1 * stride1
    slli t2, t2, 2       # Convert offset to byte offset (assuming 4-byte integers)
    slli t3, t3, 2       # Convert offset to byte offset

    add t4, a0, t2       # Calculate address of current element in first array
    add t5, a1, t3       # Calculate address of current element in second array

    lw t4, 0(t4)         # Load value from first array
    lw t5, 0(t5)         # Load value from second array
    
    mul t6, t4, t5       # Multiply the two values
    add t0, t0, t6       # Accumulate the product into the result

    addi t1, t1, 1       # Increment loop counter

    j loop_start         # Repeat the loop
loop_end:
    mv a0, t0            # Move the result into a0 for return
    jr ra                # Return from function

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
