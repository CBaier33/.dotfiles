package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"strings"
	"text/template"
	"time"
)

type JSON struct {
	Title string `json:"title"`
	Link string `json:"uri"`
}

var bookmarkTemplate string = `{{.Link}} # {{.Title}}`


func main() {

	filePath := flag.String("f", "", "path to JSON file")
	flag.Parse()

	if *filePath == "" {
		fmt.Println("missing -f (file)")
		os.Exit(1)
	} else {
		fmt.Printf("Converting: %s | ", *filePath)
	}

	file, err := os.ReadFile(*filePath)

	if err != nil {
		panic(err)
	}


	// Extract JSON Input
	var input JSON
	err = json.Unmarshal(file, &input)

	if err != nil {
		panic(err)
	}

	template, err := template.New("default").Parse(bookmarkTemplate)

	if err != nil {
		panic(err)
	}

	bookmarkFile, err := os.Create("booksmarks")




}
