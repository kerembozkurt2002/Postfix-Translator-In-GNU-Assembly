.section .data   #In this section we keep the machine code in the form of asciiz 
input_buffer:
    .space 256     # Space to store input characters
newline:
    .ascii "\n"   # Newline character
output: 
    .space 13     # Allocate 13 bytes for the binary string and null terminator
addi_five_zero: 
    .asciz " 00000"
addi_three_zero: 
    .asciz " 000"
addi_x2: 
    .asciz " 00010"
addi_x1: 
    .asciz " 00001"
addi_opcode: 
    .asciz " 0010011\n"
add_ris_machine_code: 
    .asciz "0000000 00010 00001 000 00001 0110011\n"        #RISCV output for the add operation
sub_ris_machine_code: 
    .asciz "0100000 00010 00001 000 00001 0110011\n"        #RISCV output for the substution operation
mul_ris_machine_code: 
    .asciz "0000001 00010 00001 000 00001 0110011\n"        #RISCV output for the multiplication operation
xor_ris_machine_code: 
    .asciz "0000100 00010 00001 000 00001 0110011\n"        #RISCV output for the xor operation
and_ris_machine_code: 
    .asciz "0000111 00010 00001 000 00001 0110011\n"        #RISCV output for the and operation
or_ris_machine_code: 
    .asciz "0000110 00010 00001 000 00001 0110011\n"        #RISCV output for the or operation

.section .text
.globl _start

_start:
    # Load address of input buffer into rsi
    leaq input_buffer(%rip), %rsi
    movq $0, %r8 #this contains the number
    movq $0, %r9 #this contains 0 if there was line before 1 if there is not a line before

read_loop:
    # Read a single character from stdin
    movq $0, %rdi       # File descriptor 0 (stdin)
    movq $0, %rax       # syscall number 0 (read)
    movq $1, %rdx       # Number of bytes to read
    syscall


    # Check if read was successful
    cmpq $0, %rax
    jl exit_program   # Jump if read failed (rax < 0)

    # Check if the character is a newline
    cmpb $'\n', (%rsi)
    je exit_program   # Jump to exit_program if newline character is encountered,

    cmpb $' ', (%rsi)
    je enter # Jump to pushing the number to stack operation

    cmpb $'+', (%rsi)
    je mode_one # Jump to addition program if + is encountered

    cmpb $'-', (%rsi)
    je mode_two # Jump to  subtraction program if - is encountered

    cmpb $'*', (%rsi)
    je mode_three # Jump to  multiplication program if * is encountered

    cmpb $'^', (%rsi)
    je mode_four # Jump to  bitwise xor program if ^ is encountered

    cmpb $'&', (%rsi)
    je mode_five # Jump to bitwise and program if & is encountered

    cmpb $'|', (%rsi)
    je mode_six # Jump to bitwise or program if | is encountered

    imulq $10, %r8   # Multiply the value in %r8 by 10

    addq (%rsi), %r8  #Add rsi value to r8

    subq $48, %r8  # Convert the character to a number

    movq $1, %r9 #this contains 0 if there was enter before 1 if there is not a enter before


read_rest:
    # Increment input buffer pointer
    incq %rsi
    # Repeat the loop
    jmp read_loop


mode_one:
    movq $2, %r9      # Sets the isThereALineBefore to no
    pop %r10
    pop %r12
    #this is where riscv instructions go
    mov %rsi, %r13
    call addi_func
    call addi_func_second

    #In this part we print the RISCV output for the add operation
    mov $1, %rax        
    mov $1, %rdi        
    lea add_ris_machine_code, %rsi   
    mov $38, %rdx       
    syscall             
    addq %r10, %r12
    push %r12
    mov %r13, %rsi
    jmp read_rest

mode_two:
    movq $2, %r9      # Sets the isThereALineBefore to no
    pop %r10
    pop %r12
    #this is where riscv instructions go
    movq %rsi, %r13
    call addi_func
    call addi_func_second

    #In this part we print the RISCV output for the substution operation
    mov $1, %rax        
    mov $1, %rdi       
    lea sub_ris_machine_code, %rsi   
    mov $38, %rdx        
    syscall             
    subq %r10, %r12
    push %r12
    movq %r13, %rsi
    jmp read_rest


mode_three:
    movq $2, %r9      # Sets the isThereALineBefore to no
    pop %r10
    pop %r12
    #this is where riscv instructions go
    movq %rsi, %r13
    call addi_func
    call addi_func_second

    #In this part we print the RISCV output for the multiplication operation
    mov $1, %rax        
    mov $1, %rdi        
    lea mul_ris_machine_code, %rsi   
    mov $38, %rdx        
    syscall             
    imul %r10, %r12
    push %r12
    movq %r13, %rsi
    jmp read_rest


mode_four:
    movq $2, %r9      # Sets the isThereALineBefore to no
    pop %r10
    pop %r12
    #this is where riscv instructions go
    movq %rsi, %r13
    call addi_func
    call addi_func_second

    #In this part we print the RISCV output for the xor operation
    mov $1, %rax        
    mov $1, %rdi        
    lea xor_ris_machine_code, %rsi   
    mov $38, %rdx       
    syscall             
    xorq %r10, %r12
    push %r12
    movq %r13, %rsi
    jmp read_rest


mode_five:
    movq $2, %r9      # Sets the isThereALineBefore to no
    pop %r10
    pop %r12
    #this is where riscv instructions go
    movq %rsi, %r13
    call addi_func
    call addi_func_second

    #In this part we print the RISCV output for the and operation
    mov $1, %rax        
    mov $1, %rdi        
    lea and_ris_machine_code, %rsi   
    mov $38, %rdx       
    syscall             
    andq %r10, %r12
    push %r12
    movq %r13, %rsi
    jmp read_rest


mode_six:
    movq $2, %r9      # Sets the isThereALineBefore to no
    pop %r10
    pop %r12
    #this is where riscv instructions go
    movq %rsi, %r13
    call addi_func
    call addi_func_second

    #In this part we print the RISCV output for the or operation
    mov $1, %rax        
    mov $1, %rdi        
    lea or_ris_machine_code, %rsi   
    mov $38, %rdx       
    syscall             
    orq %r10, %r12
    push %r12
    movq %r13, %rsi
    jmp read_rest


enter:
    cmpq $0, %r9
    je exit_program   # If there was a ' ' before this entry this finishes the program 
    cmpq $2, %r9      #if r9 is 2 jumps to other place
    je enter_less
    movq $0, %r9      # Sets the isThereALineBefore to yes
    push %r8           #pushes r8 to stack
    movq $0, %r8       #sets r8 to zero
    jmp read_rest      #continues

enter_less:
    movq $0, %r9      # Sets the isThereALineBefore to yes
    movq $0, %r8 
    jmp read_rest

exit_program:
    movq $60, %rax      # syscall number 60 (exit)
    xorq %rdi, %rdi     # Exit status 0
    syscall

#In this part we find the RISCV output for the first addi operation
addi_func:
    movl %r10d, %eax
    leal output, %ebx
    addl $12, %ebx
    movl $12, %ecx     
    convert_loop:    #In this part we find the binary form of the number by shifting digits and prints the RISCV output
        shrl $1, %eax
        setc %dl
        addb $'0', %dl
        dec %ebx
        movb %dl, (%ebx)
        loop convert_loop

        mov $1, %rax        # This part we write the binary form of int 
        mov $1, %rdi        
        lea output, %rsi    
        mov $12, %rdx        
        syscall 

        mov $1, %rax        # This part we write the five_zero 
        mov $1, %rdi        
        lea addi_five_zero, %rsi  
        mov $6, %rdx        
        syscall             

        mov $1, %rax        # This part we write the binary form of 0
        mov $1, %rdi        
        lea addi_three_zero, %rsi   
        mov $4, %rdx        
        syscall             

        mov $1, %rax        # This part we write the binary form of 2
        mov $1, %rdi        
        lea addi_x2, %rsi   
        mov $6, %rdx        
        syscall             

        mov $1, %rax        # This part we write opcode of addi
        mov $1, %rdi        
        lea addi_opcode, %rsi   
        mov $9, %rdx        
        syscall             
        ret

# In this part we make the same operation of addi_func but for the second number
addi_func_second:
    movl %r12d, %eax
    leal output, %ebx
    addl $12, %ebx
    movl $12, %ecx     
    convert_loop_second:
        shrl $1, %eax
        setc %dl
        addb $'0', %dl
        dec %ebx
        movb %dl, (%ebx)
        loop convert_loop_second

        mov $1, %rax       
        mov $1, %rdi       
        lea output, %rsi   
        mov $12, %rdx      
        syscall 

        mov $1, %rax        
        mov $1, %rdi        
        lea addi_five_zero, %rsi   
        mov $6, %rdx        
        syscall             

        mov $1, %rax        
        mov $1, %rdi        
        lea addi_three_zero, %rsi   
        mov $4, %rdx        
        syscall             

        mov $1, %rax        
        mov $1, %rdi        
        lea addi_x1, %rsi   
        mov $6, %rdx        
        syscall             

        mov $1, %rax        
        mov $1, %rdi        
        lea addi_opcode, %rsi   
        mov $9, %rdx        
        syscall             
        ret



.data
value:
    .quad 0              # Allocate space to store the value to print

    
