package compiler

import (
	"strings"
	"os"
	"os/exec"
)

const brainfuckWhitelist string = "><+-.,[]"

func CompileBrainfuck(code []byte) error {
	assemblyCode := []byte(assembleBrainfuck(string(code)))

	// create assembly file
	file, err := os.Create("output.asm")
	if err != nil {
		return err
	}
	defer file.Close()

	// write assembly to file
	_, err = file.Write(assemblyCode)
	if err != nil {
		return err
	}

	// assemble object file
	cmd := exec.Command("sh", "-c", AsmAssembleCommand)
	err = cmd.Run()
	if err != nil {
		return err
	}

	// link executable
	cmd = exec.Command("sh", "-c", AsmLinkCommand)
	err = cmd.Run()
	if err != nil {
		return err
	}

	// clean build files
	//cmd = exec.Command("sh", "-c", AsmCleanCommand)
	//err = cmd.Run()
	//if err != nil {
	//	return err
	//}

	// if no errors return nil
	return nil
}

func assembleBrainfuck(rawCode string) string {
	code := filterString(rawCode, brainfuckWhitelist)

	var assemblyBuilder strings.Builder

	assemblyBuilder.WriteString(AsmHeader)

	var loopCount uint = 0

	for _, char := range code {
		switch char {
		case '>':
			assemblyBuilder.WriteString(AsmIncrementPointer)
		case '<':
			assemblyBuilder.WriteString(AsmDecrementPointer)
		case '+':
			assemblyBuilder.WriteString(AsmIncrementData)
		case '-':
			assemblyBuilder.WriteString(AsmDecrementData)
		case '.':
			assemblyBuilder.WriteString(AsmOutputData)
		case ',':
			assemblyBuilder.WriteString(AsmInputData)
		case '[':
			assemblyBuilder.WriteString(GetLoopLabel(loopCount))
			loopCount++
		case ']':
			loopCount--
			assemblyBuilder.WriteString(GetLoopCheck(loopCount))
		}
	}

	assemblyBuilder.WriteString(AsmFooter)

	return assemblyBuilder.String()
}

func filterString(str string, whitelist string) string {
	allowed := make(map[rune]struct{})

	for _, char := range whitelist {
		allowed[char] = struct{}{}
	}

	var result strings.Builder

	for _, char := range str {
		if _, found := allowed[char]; found {
			result.WriteRune(char)
		}
	}

	return result.String()
}
