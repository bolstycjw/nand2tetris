@17
D=A
@SP
A=M
M=D
@SP
M=M+1
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@EQ.true.0
D;JEQ
@SP
A=M-1
M=0
@EQ.end.0
0;JMP
(EQ.true.0)
@SP
A=M-1
M=-1
(EQ.end.0)
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
@16
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@EQ.true.1
D;JEQ
@SP
A=M-1
M=0
@EQ.end.1
0;JMP
(EQ.true.1)
@SP
A=M-1
M=-1
(EQ.end.1)
@16
D=A
@SP
A=M
M=D
@SP
M=M+1
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@EQ.true.2
D;JEQ
@SP
A=M-1
M=0
@EQ.end.2
0;JMP
(EQ.true.2)
@SP
A=M-1
M=-1
(EQ.end.2)
@892
D=A
@SP
A=M
M=D
@SP
M=M+1
@891
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@LT.true.0
D;JLT
@SP
A=M-1
M=0
@LT.end.0
0;JMP
(LT.true.0)
@SP
A=M-1
M=-1
(LT.end.0)
@891
D=A
@SP
A=M
M=D
@SP
M=M+1
@892
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@LT.true.1
D;JLT
@SP
A=M-1
M=0
@LT.end.1
0;JMP
(LT.true.1)
@SP
A=M-1
M=-1
(LT.end.1)
@891
D=A
@SP
A=M
M=D
@SP
M=M+1
@891
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@LT.true.2
D;JLT
@SP
A=M-1
M=0
@LT.end.2
0;JMP
(LT.true.2)
@SP
A=M-1
M=-1
(LT.end.2)
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@GT.true.0
D;JGT
@SP
A=M-1
M=0
@GT.end.0
0;JMP
(GT.true.0)
@SP
A=M-1
M=-1
(GT.end.0)
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@GT.true.1
D;JGT
@SP
A=M-1
M=0
@GT.end.1
0;JMP
(GT.true.1)
@SP
A=M-1
M=-1
(GT.end.1)
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
D=M-D
@GT.true.2
D;JGT
@SP
A=M-1
M=0
@GT.end.2
0;JMP
(GT.true.2)
@SP
A=M-1
M=-1
(GT.end.2)
@57
D=A
@SP
A=M
M=D
@SP
M=M+1
@31
D=A
@SP
A=M
M=D
@SP
M=M+1
@53
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
M=D+M
@112
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
M=D-M
@SP
A=M-1
M=M
@SP
AM=M-1
D=M
A=A-1
M=D&M
@82
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
A=A-1
M=D|M
@SP
A=M-1
M=!M
