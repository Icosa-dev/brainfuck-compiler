# Brainfuck Compiler

A basic brainfuck compiler written in go. It compiles brainfuck code to x86-64 machine code.

## Build
To build the project you will need go installed. Then you can run `go build -o bfcompiler main.go` to get the `main` executable. You will also need NASM installed as the compiler uses it as its assembler. 

NOTE: The compiler is written to target x86-64 machines running a linux kernel. The executable may work on other \*NIX kernels but this is not a guarantee. It also uses the `ld` linker which is default for GNU/Linux systems but not for all \*NIX systems.

## Usage
```
Usage: bfcompiler <input-file>
```
