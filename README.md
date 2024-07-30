# Postfix-Translator-In-GNU-Assembly

In this project, we make the implementation of a GNU assembly language program 
which interprets a single line of postfix expression involving decimal quantities and outputs the 
equivalent RISC-V 32-bit machine language instructions. 

**The operations we carried out in this project are as follows:**
* '+' addition -subtraction 
* '*' multiplication 
* 'ˆ' bitwise xor 
* '&' bitwise and 
* '|' bitwise or 

First, we pull the input entered and load it into the input_buffer with the help of RSI. 
Then, after checking whether we can read the input correctly, we examine the input, parse the 
input in a way that suits the input content and send it to the stack. 
Then, we pull the input from the stack one by one and direct it to that section after 
understanding which action needs to be performed. 
After completing the process, we print the necessary RISCV code sequentially and create 
the output. If the operation we need to do is "addi", then we find the 12-bit binary version by 
shifting the decimal number given to us one step to the right and place it in the first part of the 
RISCV code required for "addi".

**For a detailed explanation of the program please read the description.txt.**
