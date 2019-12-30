package main

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"os"
	"strings"
)

//Project struct contains websites list
type Project struct {
	name      string
	container string
	engine    string
	url       string
}

func main() {
	config := "/data/websites.txt"
	if _, err := os.Stat(config); os.IsNotExist(err) {
		log.Fatal("websites.txt does not exist")
	}

	plist := getProjects(config)

	c := make(chan int, len(plist))

	// prepare workers
	for _, ii := range plist {
		go worker(c, ii)
	}

	// launch workers
	for i := range plist {
		c <- i
	}

	// close channel
	close(c)
}

func worker(c chan int, p Project) {
	// check if folder exists
	_, err := os.Stat("/data/" + p.container)
	if errors.Is(err, os.ErrNotExist) {
		os.MkdirAll("/data/" + p.container, 0755)
	}

	<-c
}

func getProjects(config string) []Project {
	f, err := os.Open("test.txt")
	handle(err, "can't open projects list", true)
	defer f.Close()

	scanner := bufio.NewScanner(f)
	scanner.Split(bufio.ScanLines)

	var p []Project
	i := 0

	for scanner.Scan() {
		tmp := strings.Split(scanner.Text(), " ")
		p[i].name = tmp[0]
		p[i].container = tmp[1]
		p[i].engine = tmp[2]
		p[i].url = tmp[3]
	}

	return p
}

func handle(err error, message string, exit bool) error {
	if err != nil {
		//use new go1.13 wrapping feature
		if exit == true {
			log.Fatalf("%s: %w", message, err)
		}
		return fmt.Errorf("%s: %w", message, err)
	}
	return nil
}
