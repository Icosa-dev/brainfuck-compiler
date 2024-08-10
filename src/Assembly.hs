module Assembly where

import Text.Printf

assemblyHeader = "section .bss\nmemory resb 30000\nsection .text\nglobal _start\n_start:\nmov rsi, memory\n" :: String
assemblyFooter = "mov rax, 60\nmov rdi, 0\nsyscall\n" :: String

assemblyIncrementPointer = "inc rsi\n" :: String
assemblyDecrementPointer = "dec rsi\n" :: String

assemblyIncrementValue = "inc byte [rsi]\n" :: String
assemblyDecrementValue = "dec byte [rsi]\n" :: String

assemblyOutputValue = "mov rax, 1\nmov rdi, 1\nmov rdx, 1\nsyscall\n" :: String
assemblyInputValue  = "mov rax, 0\nmov rdi, 0\nmov rdx, 1\nsyscall\n" :: String

assemblyNasmCommand  = "nasm -felf64 -o output.o output.asm" :: String
assemblyLdCommand    = "ld -o output output.o" :: String
assemblyCleanCommand = "rm output.o output.asm" :: String

getLoopLabel :: Int -> String
getLoopLabel loopCount = printf ".L%d:\n" loopCount

getLoopCheck :: Int -> String
getLoopCheck loopCount = printf "cmp byte [rsi], 0\njne .L%d\n" loopCount
