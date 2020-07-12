package main

func f() int {
	return 567
}

func main() {
	go f()
}
