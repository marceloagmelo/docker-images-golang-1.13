package main

import (
	"log"
	"net/http"
	"text/template"
)

type Hello struct {
	Mensagem string
}

var tmpl = template.Must(template.ParseGlob("form/*"))

func Index(w http.ResponseWriter, r *http.Request) {
	msg := Hello{}
        res := []Hello{}

        msg.Mensagem = "Hello World"
        res = append(res, msg)
        tmpl.ExecuteTemplate(w, "Index", res)
}

func main() {
	log.Println("Server started on: http://localhost:8080")
	http.HandleFunc("/", Index)
	http.ListenAndServe(":8080", nil)
}
