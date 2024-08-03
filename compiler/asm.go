package compiler

import (
	"fmt"
)

const (
	AsmHeader = `section .bss
memory resb 30000
section .text
global _start
_start:
mov rsi, memory
`
	AsmFooter = `mov rax, 60
mov rdi, 0
syscall
`
	AsmIncrementPointer = "inc rsi\n"
	AsmDecrementPointer = "dec rsi\n"

	AsmIncrementData = "inc byte [rsi]\n"
	AsmDecrementData = "dec byte [rsi]\n"

	AsmOutputData = `
mov rax, 1
mov rdi, 1
mov rdx, 1
syscall
`
	AsmInputData = `
mov rax, 0
mov rdi, 0
mov rdx, 1
syscall
`

	AsmAssembleCommand = "nasm -felf64 -o output.o output.asm"
	AsmLinkCommand = "ld -o output output.o"
	AsmCleanCommand = "rm -f output.o output.asm"
)

func GetLoopLabel(loopCount uint) string {
	return fmt.Sprintf(".L%v:\n", loopCount)
}

func GetLoopCheck(loopCount uint) string {
	return fmt.Sprintf("cmp byte [rsi], 0\njne .L%v\n", loopCount)
}
