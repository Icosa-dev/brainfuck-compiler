package main

import (
	"fmt"
	"bfcompiler/compiler"
	"os"
  "flag"
)

func main() {
  asmFlag     := flag.Bool("asm", false, "outputs only the assembly file")
  nocleanFlag := flag.Bool("noclean", false, "compiles the executable and keeps the intermediate object and assembly files")
  iFlag       := flag.String("i", "", "input file")

  flag.Parse()
  
  inputFile, err := os.ReadFile(*iFlag)
  if err != nil {
    fmt.Println("Error:", err)
  }

  err = compiler.CompileBrainfuck(inputFile)
  if err != nil {
    fmt.Println("Error:", err)
  }

  if *asmFlag {
    return
  } else {
    err = compiler.GenerateExecutable()
    if err != nil {
      fmt.Println("Error:", err)
    }

    if !*nocleanFlag {
      err = compiler.CleanBuildFiles()
      if err != nil {
        fmt.Println("Error:", err)
      }
    }
  }
}
