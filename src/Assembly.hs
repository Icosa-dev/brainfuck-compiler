module Assembly where

import Text.Printf

assemblyHeader           :: String
assemblyFooter           :: String
assemblyIncrementPointer :: String
assemblyDecrementPointer :: String
assemblyIncrementValue   :: String
assemblyDecrementValue   :: String
assemblyOutputValue      :: String
assemblyInputValue       :: String
assemblyNasmCommand      :: String
assemblyLdCommand        :: String
assemblyCleanCommand     :: String

assemblyHeader = "section .bss\nmemory resb 30000\nsection .text\nglobal _start\n_start:\nmov rsi, memory\n"
assemblyFooter = "mov rax, 60\nmov rdi, 0\nsyscall\n"

assemblyIncrementPointer = "inc rsi\n"
assemblyDecrementPointer = "dec rsi\n"

assemblyIncrementValue = "inc byte [rsi]\n"
assemblyDecrementValue = "dec byte [rsi]\n"

assemblyOutputValue = "mov rax, 1\nmov rdi, 1\nmov rdx, 1\nsyscall\n"
assemblyInputValue  = "mov rax, 0\nmov rdi, 0\nmov rdx, 1\nsyscall\n"

assemblyNasmCommand  = "nasm -felf64 -o output.o output.asm"
assemblyLdCommand    = "ld -o output output.o" 
assemblyCleanCommand = "rm output.o output.asm"

getLoopLabel :: Int -> String
getLoopLabel loopCount = printf ".L%d:\n" loopCount

getLoopCheck :: Int -> String
getLoopCheck loopCount = printf "cmp byte [rsi], 0\njne .L%d\n" loopCount
