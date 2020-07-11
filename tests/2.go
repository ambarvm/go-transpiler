package tests

import "fmt"

func forrange() {
	var arr [5]int

	for key, val := range arr {
		fmt.Println(key, ":", val)
	}
}
