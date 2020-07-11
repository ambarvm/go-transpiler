package tests

import "fmt"

func literals() {
	bar(1, "hi")
}

func bar(a int, b string) {
	fmt.Println("bar:", a, b)
}

func baz(a int, b string, args ...int) {
	fmt.Println("baz:", a, b)
}
