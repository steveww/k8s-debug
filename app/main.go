package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
)

func formatRequest(req *http.Request) string {
	var result []string

	url := fmt.Sprintf("%v %v %v", req.Method, req.URL, req.Proto)
	result = append(result, url)

	result = append(result, fmt.Sprintf("Host: %v", req.Host))
	result = append(result, fmt.Sprintf("Remote: %v", req.RemoteAddr))

	// loop through headers
	for name, values := range req.Header {
		name = strings.ToLower(name)
		for _, v := range values {
			result = append(result, fmt.Sprintf("%v: %v", name, v))
		}
	}

	if req.Method == "POST" {
		req.ParseForm()
		result = append(result, "\n")
		result = append(result, req.Form.Encode())
	}

	return strings.Join(result, "\n")
}

func handler(w http.ResponseWriter, req *http.Request) {
	log.Println("handling request")
	fmt.Fprintln(w, formatRequest(req))
}

func main() {
	host := os.Getenv("APP_HOST")
	if len(host) == 0 {
		host = "0.0.0.0"
	}
	port := os.Getenv("APP_PORT")
	if len(port) == 0 {
		port = "8080"
	}
	address := fmt.Sprintf("%v:%v", host, port)

	// Pattern / matches everything
	http.HandleFunc("/", handler)

	log.Printf("Starting on %v\n", address)
	if err := http.ListenAndServe(address, nil); err != nil {
		log.Fatal(err)
	}
}
