package main
import "fmt"
 
func main() {
  x := 2
 
  switch x {
    case 1:
      fmt.Println("One")
      fallthrough
    case 2:
      fmt.Println("Two")
      fallthrough
    case 3:
      fmt.Println("Three")
  }
}
