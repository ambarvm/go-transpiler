package main

import (
	"fmt"
)
func f() int {
	

	return 567
}

func main() {

	var a = 23
        a = 789
        a += 5
        a = f() // here f() is used as an expression
        a++  //increment
        fmt.Printf("%v\n", a)
        a--   //decrement
       fmt.Printf("%v\n", a)

}

