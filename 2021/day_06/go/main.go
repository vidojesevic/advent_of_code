package main

import (
    "fmt"
    "os"
    "log"
    "strings"
    "strconv"
)

func readFile(path string) string {
    file, err := os.ReadFile(path)
    if err != nil {
        log.Printf("Cannot read the file: %v", err)
    }

    return string(file)
}

func explode(div string, text string) []string {
    if len(div) > len(text) {
        log.Fatal("Bad function call!\n")
    }
    return strings.Split(text, div)
}

func makeIntOfStr(arr []string) []int64 {
    var arrInt []int64
    for i := 0; i < len(arr); i++ {
        if strings.Contains(arr[i], "\n") {
            arr[i] = strings.Trim(arr[i], "\n")
        }
        num, err := strconv.ParseInt(arr[i], 10, 0)
        if err != nil {
            log.Printf("Failed to convert string to int: %v", err)
        }
        arrInt = append(arrInt, num)
    }
    return arrInt
}

func fishes(initial []int64) int {
    for i := 0; i < 80; i++ {
        for j := 0; j < len(initial); j++ {
            initial[j] -= 1
            if initial[j] == -1 {
                initial[j] = 6
                initial = append(initial, 9)
            }
        }
        // fmt.Printf("Day %v: %v\n", i+1, initial)
    }
    return len(initial)
}

func main() {

    fileStr := readFile("../input.txt")
    fmt.Printf("This is output of the file: %s", fileStr)

    fileArr := explode(",", fileStr)
    arrInt := makeIntOfStr(fileArr)

    // fmt.Printf("Length of the array is: %d\n", len(arrInt))
    // fmt.Printf("Array: %v\n", arrInt)

    count := fishes(arrInt)
    fmt.Printf("Result: %v\n", count)
}
