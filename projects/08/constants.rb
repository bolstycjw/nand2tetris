# frozen_string_literal: true

C_ARITHMETIC = 0
C_PUSH = 1
C_POP = 2
C_LABEL = 3
C_GOTO = 4
C_IF = 5
C_FUNCTION = 6
C_RETURN = 7
C_CALL = 8

INIT = <<~ASM
  @256
  D=A
  @SP
  M=D
ASM

RETURN = <<~ASM
  @LCL
  D=M
  @5
  A=D-A
  D=M
  @R13
  M=D
  @SP
  A=M-1
  D=M
  @ARG
  A=M
  M=D
  D=A+1
  @SP
  M=D
  @LCL
  AM=M-1
  D=M
  @THAT
  M=D
  @LCL
  AM=M-1
  D=M
  @THIS
  M=D
  @LCL
  AM=M-1
  D=M
  @ARG
  M=D
  @LCL
  A=M-1
  D=M
  @LCL
  M=D
  @R13
  A=M
  0;JMP
ASM

ADD = <<~ASM
  AM=M-1
  D=M
  A=A-1
  M=D+M
ASM

SUB = <<~ASM
  AM=M-1
  D=M
  A=A-1
  M=M-D
ASM

NEG = <<~ASM
  A=M-1
  M=M
ASM

AND = <<~ASM
  AM=M-1
  D=M
  A=A-1
  M=D&M
ASM

OR = <<~ASM
  AM=M-1
  D=M
  A=A-1
  M=D|M
ASM

NOT = <<~ASM
  A=M-1
  M=!M
ASM

POP = <<~ASM
  @R13
  M=D
  @SP
  AM=M-1
  D=M
  @R13
  A=M
  M=D
ASM

PUSH = <<~ASM
  @SP
  A=M
  M=D
  @SP
  M=M+1
ASM

SEGMENTS = {
  'local' => 'LCL',
  'argument' => 'ARG',
  'this' => 'THIS',
  'that' => 'THAT',
  'pointer' => 'R3',
  'temp' => 'R5'
}.freeze
