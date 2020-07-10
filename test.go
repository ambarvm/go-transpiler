package main

import "fmt"

func main() {
	var name = 1
	name += 4

	for i := 0; i < name; i++ {
		fmt.Println(name)
	}

	fmt.Println("Hello,", name)
}
