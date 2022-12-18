# Five-Stage-Pipelined-Processor-Harvard-Architecture 
## Introduction
The processor in this project has a RISC-like instruction set architecture.  
There are eight 4-byte general purpose registers; R0, till R7. Another two general purpose registers, one works as program
counter (PC). And the other, works as a stack pointer (SP); and; hence, points to the top of the
stack. The initial value of SP is (2^12-1).   
The memory address space is 4 KB of 16-bit width and is word addressable. (N.B. word = 2 bytes).   
The bus between memory and the processor is (16-bit or 32-bit) widths for instruction memory and 32-bit widths for data memory.  

When an interrupt occurs, the processor finishes the currently fetched instructions (instructions that
have already entered the pipeline), then the address of the next instruction (in PC) is saved on top of
the stack, and PC is loaded from address [2-3] of the memory (the address takes two words). To
return from an interrupt, an RTI instruction loads PC from the top of stack, and the flow of the
program resumes from the instruction after the interrupted instruction.  

