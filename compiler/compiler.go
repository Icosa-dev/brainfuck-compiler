package compiler

import (
	"strings"
)

const brainfuckWhitelist string = "><+-.,[]"

func assembleBrainfuck(code string) string {
	var assemblyBuilder strings.Builder

	for _, char := range code {
		switch char {

		}
	}

	return assemblyBuilder.String()
}

func filterString(str string, whitelist string) string {
	allowed := make(map[rune]struct{})

	for _, char := range whitelist {
		allowed[char] = struct{}{}
	}

	var result strings.Builder

	for _, char := range whitelist {
		if _, found := allowed[char]; found {
			result.WriteRune(char)
		}
	}

	return result.String()
}
