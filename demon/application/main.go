package main

import (
	"log"
)

func main() {
	demon, err := NewDemon()

	if err != nil {
		log.Fatal(err)
	}

	demon.Listen()
}