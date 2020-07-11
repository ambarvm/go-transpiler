package main

import "fmt"

func main() {
   var a uint = 9	/* 10 = 1001 */  
   var b uint = 10	/* 10 = 1010 */
   var c uint = 0          

   c = a & b       
   fmt.Printf("a & b = %d\n", c )

   c = a | b      
   fmt.Printf("a | b = %d\n", c )

   c = a ^ b       
   fmt.Printf("a ^ b = is %d\n", c )

   c = a << 2     
   fmt.Printf("a<<2 = %d\n", c )

   c = a >> 2     
   fmt.Printf("a>>2 = %d\n", c )
}
