package main

import (
	"fmt"
	"io"
	"net/http"
)

var (
	version = "dev"
	commit  = "none"
	date    = "unknown"
)

func Hello() string {
	return fmt.Sprintf("Version: %s\nCommit: %s\nBuild Date: %s\n", version, commit, date)
}

func handle(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, Hello())
}

func main() {
	portNumber := "9000"
	http.HandleFunc("/", handle)
	fmt.Println("Server listening on port", portNumber)
	http.ListenAndServe(":"+portNumber, nil)
}
