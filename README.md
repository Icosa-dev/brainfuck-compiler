# Brainfuck Compiler

A basic brainfuck compiler written in go. It compiles brainfuck code to x86-64 machine code.

## Requirements
- NASM
- GNU Linker (ld)
- \*NIX kernel
- x86-64 CPU 

## Build
To build the project you can run the following:
```
go build -o bfcompiler main.go
```

## Usage
```
Usage of ./bfcompiler:
  -asm
    	outputs the assembly file
  -i string
    	input file
  -noclean
    	compiles the executable and keeps the intermediate object and assembly file
```
