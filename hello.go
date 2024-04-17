package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.Println(r.Method, r.URL.Path)
		w.Write([]byte("hello !!"))
	})

	log.Println("args", os.Args)
	log.Println(os.Getwd())
	log.Println("listen", ":8080")
	if err := http.ListenAndServe(":8080", nil); err != http.ErrServerClosed {
		panic(err)
	}
}
