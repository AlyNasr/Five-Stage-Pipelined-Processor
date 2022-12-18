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

## ISA Specifications
### A) Registers
R[0:7]<31:0> : Eight 32-bit general purpose registers  
PC<31:0>     : 32-bit program counter  
SP<31:0>     : 32-bit stack pointer  
CCR<3:0>     : condition code register  
Z<0>:=CCR<0> : zero flag, change after arithmetic, logical, or shift operations  
N<0>:=CCR<1> : negative flag, change after arithmetic, logical, or shift operations  
C<0>:=CCR<2> : carry flag, change after arithmetic or shift operations  

### B) Input-Output
IN.PORT<31:0>  : 32-bit data input port  
OUT.PORT<31:0> : 32-bit data output port  
INTR.IN<0>     : a single, non-maskable interrupt  
RESET.IN<0>    : reset signal  

### C) Abbreviations
Rsrc1 : 1st operand register  
Rsrc2 : 2nd operand register   
Rdst  : result register  
EA    : Effective address (20 bit)  
Imm   : Immediate Value (16 bit)  

### D) Instructions

#### One Operand instructions

| Mnemonic      | Function      | 
| ------------- |:-------------:| 
| NOP           |  PC ← PC + 1  |  
| SETC          | C ←1      | 
| CLRC          | C ←0      | 
| NOT Rdst      | NOT value stored in register Rdst<br> R[ Rdst ] ← 1’s Complement(R[ Rdst ]);<br>If (1’s Complement(R[ Rdst ]) = 0): Z ←1; else: Z ←0;<br>  If (1’s Complement(R[ Rdst ]) < 0): N ←1; else: N ←0|   
| INC Rdst      | Increment value stored in Rdst<br> R[ Rdst ] ←R[ Rdst ] + 1;<br> If ((R[ Rdst ] + 1) = 0): Z ←1; else: Z ←0;<br> If ((R[ Rdst ] + 1) < 0): N ←1; else: N ←0|  
| DEC Rdst      | Decrement value stored in Rdst<br>R[ Rdst ] ←R[ Rdst ] – 1; <br>If ((R[ Rdst ] – 1) = 0): Z ←1; else: Z ←0;<br>If ((R[ Rdst ] – 1) < 0): N ←1; else: N ←0|  
| OUT Rdst      | OUT.PORT ← R[ Rdst ]| 
| IN Rdst       | R[ Rdst ] ←IN.PORT| 

#### Two Operands instructions

| Mnemonic      | Function      | 
| ------------- |:-------------:| 
| SWAP Rsrc, Rdst|  Store the value of Rsrc 1 in Rdst and the value of Rdst in Rsc1<br>flag shouldn’t change|  
| ADD Rsrc1,Rsrc2, Rdst| Add the values stored in registers Rsrc1, Rsrc2<br>and store the result in Rdst<br>If the result =0 then Z ←1; else: Z ←0;<br>If the result <0 then N ←1; else: N ←0| 
| IADD Rsrc1,Rdst,Imm| Add the values stored in registers Rsrc1 to Immediate Value<br>and store the result in Rdst<br>If the result =0 then Z ←1; else: Z ←0;<br>If the result <0 then N ←1; else: N ←0|  
| SUB Rsrc1,Rsrc2, Rdst| Subtract the values stored in registers Rsrc1, Rsrc2<br>and store the result in Rdst<br>If the result =0 then Z ←1; else: Z ←0;<br>If the result <0 then N ←1; else: N ←0|    
| AND Rsrc1,Rsrc2, Rdst| AND the values stored in registers Rsrc1, Rsrc2<br>and store the result in Rdst<br>If the result =0 then Z ←1; else: Z ←0;<br>If the result <0 then N ←1; else: N ←0|  
| OR Rsrc1, Rsrc2,Rdst| OR the values stored in registers Rsrc1, Rsrc2<br>and store the result in Rdst<br>If the result =0 then Z ←1; else: Z ←0;<br>If the result <0 then N ←1; else: N ←0|  
| SHL Rsrc      | Imm Shift left Rsrc by #Imm bits and store result in same register<br>Don’t forget to update carry| 
| SHR Rsrc      | Imm Shift right Rsrc by #Imm bits and store result in same register<br>Don’t forget to update carry| 

#### Memory Operations

| Mnemonic      | Function      | 
| ------------- |:-------------:| 
| PUSH Rdst|  M[SP--] ← R[ Rdst ];|  
| POP Rdst| R[ Rdst ] ← M[++SP];| 
| LDM Rdst| Imm Load immediate value (16 bit) to register Rdst<br> R[ Rdst ] ← {0,Imm<15:0>}|  
| LDD Rdst| EA Load value from memory address EA to register Rdst<br> R[ Rdst ] ← M[EA];|    
| STD Rsrc| EA Store value in register Rsrc to memory location EA<br> M[EA] ←R[Rsrc];|  

#### Branch and change of control operations

| Mnemonic      | Function      | 
| ------------- |:-------------:| 
| JZ Rdst|  Jump if zero<br>If (Z=1): PC ←R[ Rdst ]; (Z=0)|  
| JN Rdst| Jump if negative<br>If (N=1): PC ←R[ Rdst ]; (N=0)| 
| JC Rdst| Jump if negative<br> If (C=1): PC ←R[ Rdst ]; (C=0)|  
| JMP Rdst| Jump<br> PC ←R[ Rdst ]|    
| CALL Rdst| (M[SP] ← PC + 1; sp-2; PC ← R[ Rdst ])|  
| RET| sp+2, PC ←M[SP]|    
| RTI| sp+2; PC ← M[SP]; Flags restored|  

#### Input signals

| Mnemonic      | Function      | 
| ------------- |:-------------:| 
| Reset    |  PC ←{M[1], M[0]} //memory location of zero|  
| Interrupt| M[Sp]←PC; sp-2;PC ← {M[3],M[2]}; Flags preserved| 


## Design
The processor is implemented in five pipelined stages which are Instruction Fetch **(IF)**, Instruction Decode **(ID)**, Execute **(EX)**, Memory Access **(MEM)** and Register Write Back **(WB)**. There are four buffer registers, one between each two successive stages. The buffer registers are **IF/ID**, **ID/EX**,
**EX/MEM** and **MEM/WB**.

![Design_Schema](/Schema/Design Schema.png)

