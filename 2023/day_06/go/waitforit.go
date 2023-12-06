package main

import (
    "fmt"
    "os"
    "log"
    "strings"
)

func checkError(e error) {
    if e != nil {
        log.Printf("Error: %v", e)
    }
}

func readFile(path string) string {
    file, err := os.ReadFile(path)
    checkError(err)

    // fmt.Printf("File type: %T\n", file)

    return string(file)
}

func explode(div string, file string) []string {
    if len(div) >= len(file) {
        log.Fatal("Bad function call")
    }
    return strings.Split(file, div)
}

func main() {
    file := readFile("../test.txt")
    // file := readFile("../input.txt")
    // fmt.Printf("Content:\n%v", file)
    str := explode("\n", file)
    dataStr := explode(" ", str[0])
    fmt.Printf("Times: %v\n", dataStr)
    times := explode(" ", dataStr[0])
    fmt.Printf("Time 1: %v", times)

    fmt.Println("Advent of Code")
    fmt.Println("Day 6: Wait for it")
}
