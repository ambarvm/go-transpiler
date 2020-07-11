package tests

import "fmt"

func main() {
	var name = 1
	var arr [5]int

	for i := 0; i < name; i++ {
		fmt.Println(i)
	}

	for name < 10 {
		name++
		continue
		fmt.Println(name)
	}

	for key, val := range arr {
		fmt.Println(key, ":", val)
		break
	}
}
