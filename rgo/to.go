package main

import (
	"fmt"
	"time"
)

func main() {
	var out string
	read := make(chan bool, 1)
	go func() {
		time.Sleep(95 * time.Millisecond)
		out = "this is your message"
		read <- true
	}()

	select {
	case <-read:
		fmt.Println("read succeeded")
		fmt.Println(out)
	case <-time.After(100 * time.Millisecond):
		fmt.Println("timed out")
	}
}
