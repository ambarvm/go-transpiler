package tests

import "fmt"

func literals() {
	floats := .12_1e4 + 0x_1.2_1p-2
	ints := 111_000 + 100 + 0xff
	runes := 'a' + '\n' + '\\'
	bools := true && false

	fmt.Println(floats, ints, runes, bools)
}
