package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"os"
)

var path *string

func init() {
	path = flag.String("p", "", "pipe file")
	flag.Parse()
}

func main() {
	fmt.Println("pipe file:", *path)
	pipe, _ := os.OpenFile(*path, os.O_RDONLY, 0600)

	var buf bytes.Buffer
	io.Copy(&buf, pipe)

	pipe.Close()
	os.Remove(*path)

	fmt.Printf("read from pipe: %s\n", buf.String())
	os.Exit(0)
}
