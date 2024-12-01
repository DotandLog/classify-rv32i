.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0
    li t2, 1
loop_start:
    
    # t0: saved the current maximum
    # t1: saved the index of maximum element
    # t2: used for the index of loop iteration 
    # t3: used for the current element

    beq t2, a1, loop_end # Check if reaching the end of the array
    
    lw t3, 0(a0) # Load the current array element
    addi a0, a0, 4 # Move to the next array element's position

    bgt t3, t0, update_maximum # If t3 (current element) > t0 (current maximum), update
    j next_iteration
update_maximum:
    mv t0, t3 # Update the maximum
    addi t1, t2, -1 # Update the position of maximum, since the answer should based on 0-index, decrement the value.
next_iteration:
    addi t2, t2, 1 # Increment loop index
    j loop_start 
loop_end:
    mv a0, t1 # Save the position of the maximum element and return
    ret
handle_error:
    li a0, 36
    j exit
