package main

import "fmt"

func main() {
	var value int = 1
	value = value + 1

	for i := 0; i < 5; i++ {
		fmt.Println(i)
	}

	if "one" == "all" && true {
		fmt.Println("One is all, all is one.")
	}
	fmt.Println("Hello World", value)
}
