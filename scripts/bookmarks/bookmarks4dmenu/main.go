package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
)

type Node struct {
	Title    string `json:"title"`
	Type     string `json:"type"`
	URI      string `json:"uri"`
	Children []Node `json:"children"`
}

func extractBookmarks(n Node, out *[]string) {
	// If this is a bookmark
	if n.Type == "text/x-moz-place" && n.URI != "" {
		*out = append(*out, fmt.Sprintf("%s # %s", n.URI, n.Title))
	}

	// Recurse into children
	for _, c := range n.Children {
		extractBookmarks(c, out)
	}
}

func main() {
	// Path to your JSON file
	//filePath := "bookmarks.json"
	filePath := flag.String("f", "", "path to JSON file")
	flag.Parse()

	if *filePath == "" {
		fmt.Println("missing -f (file)")
		os.Exit(1)
	} else {
		fmt.Printf("Converting: %s | ", *filePath)
	}

	//file, err := os.ReadFile(*filePath)

	data, err := os.ReadFile(*filePath)
	if err != nil {
		log.Fatalf("Failed to read file: %v\n", err)
	}

	var root Node
	if err := json.Unmarshal(data, &root); err != nil {
		log.Fatalf("Failed to parse JSON: %v\n", err)
	}

	var results []string
	extractBookmarks(root, &results)

	// Print to stdout
	//for _, line := range results {
  //fmt.Println(line)
  //}

	// Optionally also save to file
	output := "bookmarks"
	f, err := os.Create(output)
	if err != nil {
		log.Fatalf("Failed to write output: %v\n", err)
	}
	defer f.Close()

	for _, line := range results {
		f.WriteString(line + "\n")
	}

	fmt.Printf("Done! Extracted %d bookmarks.\n", len(results))
}

