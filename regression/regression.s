/*
 * regression_.s
 * 
 * Author: Amanda Sterling
 * Date: 9/22/2022
 *
 */

 // Section .crt0 is always placed from address 0
	.section .crt0, "ax"

_start:
	.global _start

    //IMPORTANT NOTE: Debugging is done via looking at registers only. No other tools provided.
    
 	//Immediate (i-type) ALU operations

    //ADDI Instruction
 	addi x2, x0, 2				// load 2 into register x2
 	nop
 	nop
 	nop
 	addi x2, x2, (-1 & 0xfff)	// add -1 to x2
 	nop					// x2 = 2
 	nop
 	nop
     //SLTI Instruction
 	slti x3, x2, 2				// compare 1 to 2, less than so x3 (cause apparently by the time this instruction executes, the data is valid)
 	nop					// x2 = 1 
 	nop
 	nop
 	slti x3, x2, 1				// compare 1 to 1, not less than, so x3 should be set to 0
 	nop					// x3 = 1
 	nop
 	nop
    //SLTIU Instruction
    //Test two positive numbers
    li x1, -1
    //x3 is set to 1 if x2, 1, is less than 5.
    sltiu x3, x2, 5     //x3 = 0			
    nop
    nop
    nop
    //Test a positive and a negative number:
    //1 should be smaller than -1 unsigned, so x3 should be 0.
    sltiu x3, x1, 1    //x1 = -1,
    nop                //x3 = 1                                  
    nop
    nop
    //Test two negative numbers
    //-1 should be greater than -5 unsigned, so x3 should be 0.
    sltiu x3, x1, -5
    nop                 //x3 = 0
    nop
    li x1, 9
    //XORI Instructions - 0101^0000 is 0101
    xori x3, x0, 5
    nop                 //x3 = 0.
    nop           
    nop                 
    //ORI Instructions
    ori x3, x1, 3       //x1 = 9
    nop                 //x3 = 5.
    nop
    nop
    //ANDI Instructions
    //FAILURE HERE.
    andi x3, x1, 3
    nop             //x3 = B(11).
    nop
    nop
    //Four NOPs required
 	nop
 	nop             //x3 = 1
 	nop
 	nop
  	//halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Immediate (r-type) ALU operations
 */
    //Need to test with false error introductions
    //ADD
    li x1, 1
    li x2, -2
    li x4, -5
    li x5, 16
    //Add positive number and a zero (1, 0)
    add x3, x0, x1      //x1 = 1
    nop                 //x2 = -2
    nop                 //x4 = -5
    nop                 //x5 = 16
    //Add a negative number and zero (-2, 0)
    add x3, x0, x2
    nop                 //x3 = 1
    nop
    nop
    //Add two positive numbers (1, 1)
    add x3, x1, x1
    nop                 //x3 = -2
    nop
    nop
    //Add two negative numbers (-2, -2)
    add x3, x2, x2
    nop                 //x3 = 2
    nop
    nop
    //Add a negative number and a positive number (-2, 1)
    add x3, x1, x2
    nop                 //x3 = -4
    nop
    nop
    //SUB
    //Negative minus a negative number (-2, -2)
    sub x3, x2, x2
    nop                 //x3 = -1
    nop
    nop
    //Negative minus a positive number (-2, 1)
    sub x3, x2, x1
    nop                 //x3 = 0
    nop
    nop
    //Positive number minus a negative number (1, -2)
    sub x3, x1, x2
    nop                 //x3 = -3
    nop
    nop
    //Positive number minus a positive number (1, 1)
    sub x3, x1, x1
    nop                 //x3 = 3
    nop
    nop
    //SLL - shifts bits to the right and pads with zeros
    //Shift to the left by one bit, x3 should be 2
    sll x3, x1, x1
    nop                 //x3 = 0
    nop
    nop
    //Shift to the left by a negative amount. x3 should be moved over by 14 bits (be 16384)
    sll x3, x1, x2
    nop                 //x3  = 2
    nop
    nop
    //SLT - if r1 < r2, rd = 1. Else rd = 0.
    //Compare two equal numbers, ( 0 < 0), 0
    slt x3, x1, x1
    nop                 //x3 = x40000
    nop
    nop
    //Compare less than, true (0 < 1), 1
    slt x3, x0, x1
    nop                 //x3 = 0
    nop
    nop
    //Compare less than, false, 1 < -2), 0
    //FAILURE.
    slt x3, x1, x2
    nop                 //x3 = 1
    nop
    nop
    //SLTU - Same as slt, but unsigned. Recycled sltiu checks.
    //Compare equal
    sltu x3, x1, x1     //x3 = 0			
    nop
    nop
    nop
    //Test a positive and a negative number.
    //1 should be smaller than -2 unsigned, so x3 should be 1.
    sltu x3, x1, x2    
    li x6, -1                 //x3 = 0                                  
    nop
    nop
    //Test two negative numbers
    //-1 should be greater than -5 unsigned, so x3 should be 0.
    li x2, 3
    sltu x3, x6, x4     //x3 = 1        
    nop                 //x1 = -6
    nop
    nop
    //XOR
    //0011^0001 -> 0010 (2). Tests all combination of bits.
    xor x3, x1, x2      
    nop                 //x3 = 0
    nop
    nop
    //SRL - Inserted bits are zeros. 010 -> 001, Shifted 0001_0000 by 1 bit -> 8
    srl x3, x5, x1
    nop                 //x3 = 2
    nop
    nop
    //SRA - Same as SRL except it replicates the sign bit in the vacated bits. (101 -> 110
    //Test with a positive number, Shifted 0001_0000 by three bits bit -> 2
    sra x3, x5, x2
    nop                 //x3 = 8                 
    nop
    nop
    //Test with a negative number, Shifted 1101 by 1 bits -> 1110 (D)
    sra x3, x4, x1
    nop                 //x3 = 2
    nop
    nop
    //OR
    //ORing 3 and 1 does a nice mix of bits -> 3
    or x3, x2, x1
    nop                 //x3 = D
    nop
    nop
    //AND
    //Just with like OR, 3 and 1 have a combination of all bits.
    and x3, x2, x1
    nop                 //x3 = 3
    nop
    nop
    //FOUR NOPs
	nop
	nop                 //x3 = 1
	nop
	nop
 	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Immediate (r-type immediate) ALU operations
 */
    //SLLI
    //Shift 1 left by 1, should be 2.
    slli x3, x1, 1
    nop                 
    nop
    nop
    //Shift to the left by a negative amount. x3 should be moved over by 14 bits (be 16384)
    slli x3, x1, -2
    nop                 //x3  = 2
    nop
    nop
    //SRLI - Shift to the right; Pad with zeros. 16 -> 8
    srli x3, x5, 1
    nop                 //x3 = 16384
    nop
    nop
    //SRAI - Shift right; pad with sign bit.
    //Shift positive number; 16 -> 4
    srai x3, x5, 2
    nop                 //x3 = 8
    nop
    nop
    //Shift negative number; x4 = -5. 1101 -> 1110 (-6).
    srai x3, x4, 1
    nop                 //x3 = 4
    nop
    nop
    //FOUR NOPs
	nop
	nop                 //x3 = -6
	nop
	nop
 	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Data hazard detection and forwarding test sequences
 */
 	addi x2, x0, 1				// load x2 register with 1
 	addi x3, x0, 2				// load x3 register with 2
 	addi x4, x0, 3				// load x4 register with 3
 	addi x5, x0, -1				// load x5 register with -1
    //WB -> ID data hazards.
    add x2, x3, x4              //x3 =2, x4 =3, x2 = 1
	nop
	nop
    add x3, x2, x4              //x2 = 5, x4 = 3
    nop
	nop
    nop
    nop
    nop                         //x3 = 8
    //WB -> EX Data hazards
    add x2, x3, x4              //x3 = 8, x4 = 3
    nop
    add x3, x2, x4              //x2 = 11, x4 = 3
    nop
    nop
    nop
    nop
    nop                         //x3 = 14
    //MEM -> EX Data hazards.
    add x2, x3, x4              //x3 = 14, x4 = 3
    add x3, x2, x4              //x2 = 17, x4 = 3
    nop
    nop
    nop
    nop
    nop                         //x3 = 20
  	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Branch (b-type) operations
 */

	nop
	nop
	nop
	nop
	beq x0, x0, PASS
BRANCH_FAIL:
	nop
	nop
	nop
	nop
	halt		// Branch test has failed, time to debug
	nop
	nop
	nop
	nop
PASS:
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	jump instruction operations
 */
	nop
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Store (s-type)  operations
 */
 	// Loading test data into registers for Store / Load tests
 	addi x20, x0, 0x765
 	slli x20, x20, 12
 	ori	x20, x20, 0x432
 	slli x20, x20, 8
 	ori x20, x20, 0x10				// x20 = 0x76543210
 	xori x21, x20, 0xfff			// x21 = 0x89abcdef
 	// Load register x10 with base DATA memory location
 	addi x10, x0, (DATA >> 12)		// Assume DATA memory address less than 24-bits
 	slli x10, x10, 12				// Move the upper 12-bits to locations 12..23
 	ori x10, x10, (DATA & 0xfff)	// OR in the lower 12-bits to create all 24-bits
 	// Load register x11 with base DATA_MINU location
 	addi x11, x0, (DATA_MINUS >> 12)	// Assume DATA memory address less than 24-bits
 	slli x11, x11, 12					// Move the upper 12-bits to locations 12..23
 	ori x11, x11, (DATA_MINUS & 0xfff)	// OR in the lower 12-bits to create all 24-bits
 	// start of Store Instruction test
	nop
	nop
	nop
	nop
  	halt
  	nop
  	beq x0, x0, LOAD_TEST
  	nop
  	nop
 /*
 	Data Memory Space for regression test
 	- There are 8 NOP locations which are available
 		to be overwritten for test
 	- Accessing the first data location by 0 offset of x10 => 0(x10)
 	- Accessing the 1st byte in data space is 1 offset of x10 => 1(x10)
 	- Accessing the 2nd half-word in data space is 2 offset of x10 => 2(x10)
 	- Accessing the 2nd word in data space is 4 offset of x10 => 4(x10)
 */
DATA:
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 DATA_MINUS:

 /*
 	Load (l-type)  operations
 */
LOAD_TEST:
	nop
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 LOAD_FAIL:							// Using branch statements, if load does not
 	nop								// return result expected, branch to LOAD_FAIL label
 	nop
 	nop
 	halt
 	nop
 	nop
 	nop
 	nop