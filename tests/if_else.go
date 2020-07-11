package main

import "fmt"

func main() {
   var a int = 100;
   if( a < 10 ) {
      fmt.Printf("a is less than 10\n" );
   } else {
      fmt.Printf("a is not less than 10\n" );
   }
   fmt.Printf("value of a is : %d\n", a);
}
