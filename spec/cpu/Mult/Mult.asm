// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

// Idea: Sum R0 as many time as R1.

// Limitations / Improvements:
// * If one of the inputs is zero, then it should short-circuit and return zero
// * The loop should use MIN(R0, R1) to run as less iterations as possible

  // Initialize output in `R2` and loop's control variable in `i`
  @R2
  M=0
  @i
  M=1

// Sum R0 a number of R1 times and update R2 with the result
(LOOP)
  // Load i and R1 to check i < R1
  @i
  D=M
  @R1
  D=D-M
  @END
  // if i > R1 goto END
  D;JGT
  // If i <= R1, then accumulate R0 in R2: R2 = R2 + R1
  @R0
  D=M
  @R2
  D=D+M
  M=D
  // Increase i and loop
  @i
  M=M+1
  @LOOP
  0;JMP

// Construction to end the program
(END)
  @END
  0;JMP

