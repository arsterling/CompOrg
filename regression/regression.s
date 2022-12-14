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
 	nop             //x3 = 1 -> Failure. The register doesn't update from previous value.
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
 	//halt
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
    slli x3, x1, -1
    nop                 //x3  = 2
    nop
    nop
    //SRLI - Shift to the right; Pad with zeros. 16 -> 8
    srli x3, x5, 1
    nop                 //x3 = 16384
    nop
    nop
    //SRAI - Shift right; pad with sign bit. (Should have a failure)
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
    li x1, 1
    li x2, 2
    li x3, -3
    li x4, -4
	nop
	nop
	nop
	nop
BEQN:
    //Test less than - Should not take this brancdh
    beq x1, x2, BEQN
    nop
    nop
    //Test Greater than - should not take this branch
    beq x2, x1, BRANCH_FAIL
    nop
    nop
    //Test Equal - should take this branch
	beq x0, x0, PASS
    nop
    nop
PASS:
BNEN:
    //test equal to - should not take this branch
    bne x0, x0, BNEN
    nop
    nop
    //Test less than - should take this branch
    bne x1, x2, PASS2
    nop
    nop
PASS2:
    //Test greater than - should take this branch
    bne x2, x1, PASS3
    nop
    nop
PASS3:
    //test less than - should take this branch
    blt x1, x2, PASS4
    nop
    nop
PASS4:
    //test equal to - should not take this branch
    blt x0, x0, BRANCH_FAIL
    nop
    nop
BLTN:
    //test greater than - should not take this branch
    blt x2, x1, BLTN
    nop
    nop
BGEN:
    //Text less than - should not branch
    bge x1, x2, BGEN
    nop
    nop
    //Test greater than - take this branch
    bge x2, x1, PASS5
    nop
    nop
PASS5:
    //Test equal to - should take this branch
    bge x0, x0, PASS6
    nop
    nop
PASS6:
BLTUN:
    //Test equal values - should not branch.
    bltu x0, x0, BLTUN
    nop
    nop
    //test greater than - should fail
    bltu x2, x1, BRANCH_FAIL
    nop
    nop
    //Test negative and positive values - should branch (1 < -3 unsigned)
    bltu x1, x3, PASS7
    nop
    nop
PASS7:
BGEUN:
    //test a less than case - Don't Branch
    bgeu x1, x3, BGEUN
    nop
    nop
PASS8:
    //Test equal to - Branch
    bgeu x1, x1, PASS9
    nop
    nop
PASS9:
    //Test a greater than - Branch
    bgeu x3, x1, PASS_FINAL
    nop
    nop
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
PASS_FINAL:
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
    //JAL Test (Fail should be here)
    jal x2, JAL_PASS
	nop
	nop
	nop
JAL_PASS:
    nop
    nop
    nop
    nop
	nop
    //JALR Test - should jump to the JALRPASS label.
    auipc x1, 0
    nop
    nop
    nop
    nop
    nop
    jalr x2, 48(x1)
    nop
    nop
    nop
    nop
    nop
JALRPASS:
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
 	//Start of Store Instruction test
    //Store Byte:
    sb x20, 0(x10)          //1000: 0x10
    srli x23, x20, 8        //x23: 0x765432
    sb x23, 1(x10)          //1001: 0x32
    srli x23, x23, 8        //x23: 0x7654
    sb x23, 2(x10)          //1002: 54
    srli x23, x23, 8        //x23: 0x76
    sb x23, 3(x10)          //1003: 76
    srli x23, x23, 8        //x23 = 0x0
    //Store Half Word:
 	sh x21, 4(x10)          //1004-1005: ef-cd
    srli x23, x21, 8        //x23: 0x89ab
    sh x23, 6(x10)          //1006-1007: ab-89
    //Store Word
    sw x20, 8(x10)          //1008-1012: 10-32-54-76
    //Easiest to test, negative offset with whole word
    sw x21, -4(x11)         //1028-1032: ef-cd-ab-89
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
 	- There are 8 NOP locations which are available to be overwritten for test
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
    li x6, 0xff
    li x9, 0xfff
    slli x9, x9, 4
    ori x9, x9, 0xf         //x9 = 0xffff
    //lw test
    lw x1, 0(x10)           //x1 = 0x76543210
    //Compare - should not branch
    bne x1, x20, LOAD_FAIL
    //lh test
    lh x2, 6(x10)           //x2 = 0xffff89ab
    slli x2, x2, 16         //x2 = 0x89ab0000
    lh x8, 4(x10)           //x8 = ffffcdef
    and x8, x9, x8          //x8 = 0000cdef
    or x2, x2, x8           //x2 - 89abcdef
    //Compare - should not branch
    bne x2, x21, LOAD_FAIL
    //lhu test
    lhu x2, 6(x10)          //x2 = 0x89ab
    slli x2, x2, 16         //x2 = 0x89ab0000
    lhu x7, 4(x10)          //x7 = 0xcdef
    or x2, x2, x7           //x2 = 0x89abcdef
    //Compare - should not branch
    bne x2, x21, LOAD_FAIL
    //lb test
    lb x3, 11(x10)          //x3 = 0xffffff76
    slli x3, x3, 8          //x3 = 0xffff7600
    lb x4, 10(x10)          //x4 = 0xffffff54
    and x4, x4, x6          //x4 = 0x00000054
    or x3, x3, x4           //x3 = 0xffff7654
    slli x3, x3, 8          //x3 = 0xff765400
    lb x4, 9(x10)           //x4 = 0xffffff32
    and x4, x4, x6          //x4 = 0x00000032
    or x3, x3, x4           //x3 = 0xff765432
    slli x3, x3, 8          //x3 = 0x76543200
    lb x4, 8(x10)           //x4 = 0xffffff10
    and x4, x4, x6          //x4 = 0x00000010
    or x3, x3, x4           //x3 = 0x76543210
    //Compare - should not branch
    bne x3, x20, LOAD_FAIL
    //lbu test
    lbu x3, 11(x10)         //x3 = 0x76
    slli x3, x3, 8          //x3 = 0x7600
    lbu x4, 10(x10)         //x4 = 0x54
    or x3, x3, x4           //x3 = 0x7654
    slli x3, x3, 8          //x3 = 0x765400
    lbu x4, 9(x10)          //x4 = 0x32
    or x3, x3, x4           //x3 = 0x765432
    slli x3, x3, 8          //x3 = 0x76543200
    lbu x4, 8(x10)          //x4 = 0x10
    or x3, x3, x4           //x3 = 0x76543210
    //Compare - should not branch
    bne x3, x20, LOAD_FAIL
    //Negative offset test
    lw x5, -4(x11)          //x5 = 0x89abcdef
    //Compare - Should not branch
    bne x5, x21, BRANCH_FAIL
	nop
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 LOAD_FAIL:							// Using branch statements, if load does not return result expected, branch to LOAD_FAIL label
 	nop								
 	nop
 	nop
 	halt
 	nop
 	nop
 	nop
 	nop