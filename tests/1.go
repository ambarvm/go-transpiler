package tests

import "fmt"

func main() {
	var name = 1
	name += 4

	for i := 0; i < name; i++ {
		fmt.Println(i)
	}

	if name == 5 {
		fmt.Println("name is", name)
	}

	if true {
		name++
	} else if false {
		name--
	} else {
		name = 1
	}

	for name < 10 {
		name++
		fmt.Println(name)
	}

	fmt.Println("Hello,", 'a')
}
