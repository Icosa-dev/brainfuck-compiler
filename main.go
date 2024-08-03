package main

import (
	"fmt"
	"bfcompiler/compiler"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Error: no input file")
	}

	inputFile, err := os.ReadFile(os.Args[1])
	if err != nil {
		fmt.Println("Error:", err)
	}

	err = compiler.CompileBrainfuck(inputFile)
	if err != nil {
		fmt.Println("Error:", err)
	}
}
