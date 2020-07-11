package main

import (
	"fmt"
)
func main() {
    { // start outer block
        a := 1
        fmt.Println(a)
        { // start inner block
            b := 2
            fmt.Println(b)
        } // end inner block
    } // end outer block
}
