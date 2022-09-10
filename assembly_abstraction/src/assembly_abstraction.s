

 // Section .crt0 is always placed from address 0
	.section .crt0, "ax"

_start:
	.global _start

 /*
 	Assembly Abstraction assignment

 	Start here
 */

/* Write the C program in assembly:

Using the assembly_abstraction project imported, write the assembly program for the
assignment function. It is the same function as for Checkpoint 1 without the printf and a
modified return statement.
    Function to program
        unsigned int letter = ‘your first initial in lowercase’ // Keith would be ‘k’
        int result = 0 // declare and initialize result
        loop until variable i incrementing by 1 from 0 to letter
            within the loop, result = result + i + letter;
        return result // for c-program, it would be the return of main, for assembly, you will be storing the result value in memory location 0x2004
        Halt
    Function Assembly Hints:
        As a minimum, you should plan to allocate registers for the following to implement the routine
            maximum count of loop which will be assigned your first initial lowercase
            count variable, i, that will go from 0 to maximum count
                or, the count variable could be assigned max value and count to 0
            result variable which is initialized to 0
            memory address to store result initialized to 0x2000
        You can use the RISCV add immediate instruction, addi, to initialize a register
    Memory locations:
        letter = 0x2000
        result = 0x2004
        i = 0x2008


 /*
 	Add your assembly code above this line
 */
	nop
	nop
	nop
	halt
	nop
	nop
	nop
