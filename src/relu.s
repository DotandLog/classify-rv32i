.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error     
    li t1, 0             

loop_start:
    # t1: the idex for the loop iteration
    
    # Check if reaching the end of the array
    beq t1, a1, end_loop
    
    slli t2, t1, 2 # Get the offset from the array
    add t3, a0, t2 # Get the current address of element  
    lw t4, 0(t3) # load the value from the address

    # Check if the value is greater than zero
    bgt t3, zero, next_iteration
    
    # Update the element to 0 if the origin value < 0
    sw zero, 0(t3)

next_iteration:
    addi t1, t1, 1
    j loop_start

end_loop:
    j exit
error:
    li a0, 36          
    j exit          
