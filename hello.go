package main

import (
	"log"
	"net/http"
	"os"
)

func main() {

	wd, _ := os.Getwd()
	log.Println("Args:", os.Args)
	log.Println("UID:", os.Getuid(), "GID:", os.Getgid())
	log.Println("Working directly:", wd)
	log.Println("Listening on:", "0.0.0.0:8080")

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.Println(r.Method, r.URL.Path)
		w.Write([]byte("hello !!"))
	})

	if err := http.ListenAndServe("0.0.0.0:8080", nil); err != http.ErrServerClosed {
		panic(err)
	}

}
