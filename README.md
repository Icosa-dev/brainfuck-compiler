# Brainfuck Compiler

A basic brainfuck compiler written in haskell. It compiles brainfuck code to x86-64 machine code that targets the Linux kernel.

The legacy go version is available in the `legacy-go` branch.

## Requirements
- Cabal
- NASM
- GNU Linker (ld)
- \*NIX kernel
- x86-64 CPU 

### Build

```
cabal build bfc 
cabal run bfc -- <flags>
```

### Usage
```
Brainfuck Compiler (bfc)

Usage: bfc [-c|--clean] (-i|--input FILE) [-a|--asm]

  A basic brainfuck compiler written in haskell

Available options:
  -c,--clean               Clean build artifacts
  -i,--input FILE          Input file to compile
  -a,--asm                 Only generate assembly file
  -h,--help                Show this help text
```
