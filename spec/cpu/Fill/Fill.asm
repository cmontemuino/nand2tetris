// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// Idea: probe to the KEYBOARD address in a loop. Black the screen completely when
//       when the value is different from zero; otherwise clear the screen

// Limitations / Improvements:
// * Keep current screen state in a variable to avoid updating the screen if state
//   did not change.

// if KBD == 0 then goto CLEAR_SCREEN else goto BLACK_SCREEN
(PROBE_KEYBOARD)
  @KBD
  D=M
  @CLEAR_SCREEN
  D;JEQ
  @BLACK_SCREEN
  0;JMP

(BLACK_SCREEN)
  @state
  M=-1
  @UPDATE_SCREEN
  0;JMP

(CLEAR_SCREEN)
  @state
  M=0
  @UPDATE_SCREEN
  0;JMP

(UPDATE_SCREEN)
  // There are 8K 16-bit registers to update. 8K = 8192
  // Define control variable i=8192
  @8192
  D=A
  @n
  M=D

  // Initialize addr to the the top-left corner of the screen
  @SCREEN
  D=A
  @addr
  M=D

(UPDATE_ROWS)
  // Check if all screen registers has been updated and probe the keyboard again
  // if n == 0 then goto PROBE_KEYBOARD
  @n
  D=M
  @PROBE_KEYBOARD
  D;JEQ


  // Load state (i.e., -1 for black or 0 for white)
  @state
  D=M

  // Load the screen address and fill it with what we have in `state`
  @addr
  A=M
  M=D

  // Advance 1 word (i.e., 16 bits) to fill the next screen chunck
  @addr
  M=M+1

  // decrement n and loop through one more register
  @n
  MD=M-1
  @UPDATE_ROWS
  0;JMP

// Construction to end the program
(END)
  @END
  0;JMP

