package main

import (
	"fmt"
	"log"
    "os"
    "strings"
    "strconv"
)

// var memo = make(map[int]int)

func checkError(e error) {
    if e != nil {
        log.Printf("Error: %v", e)
    }
}

func readFile(path string) string {
    file, err := os.ReadFile(path)
    checkError(err)

    fmt.Printf("File type: %T\n", file)

    return string(file)
}

func explode(div string, file string) []string {
    if len(div) >= len(file) {
        log.Fatal("Bad function call")
    }
    return strings.Split(file, div)
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

func findMin(arr []int64) int64 {
    if len(arr) <= 0 {
        log.Fatal("Array length is less or equal to 0!")
    }
    min := arr[0]
    for i := 1; i < len(arr); i++ {
        if min > arr[i] {
            min = arr[i]
        }
    }
    return min
}

func findMax(arr []int64) int64 {
    if len(arr) <= 0 {
        log.Fatal("Array length is less or equal to 0!")
    }
    max := arr[0]
    for i := 1; i < len(arr); i++ {
        if max < arr[i] {
            max = arr[i]
        }
    }
    return max
}

func calculateFuel(arr []int64, min int64, max int64) int64 {
    var count int64
    target := min + 2
    for j := target; j <= max; j++ {
        var temp int64 = 0
        for i := 0; i < len(arr); i++ {
            if target > arr[i] {
                temp += target - arr[i]
            } else if arr[i] > target {
                temp += arr[i] - target
            }
        }
        if count == 0 {
            count = temp
        }
        if count > temp {
            count = temp
        }
        target++
    }

    return count
}

func main() {
    fmt.Println("Advent of Code 2021, Day 07!")

    // str := readFile("../test.txt")
    str := readFile("../input.txt")
    strArr := explode(",", str)
    arr := makeIntOfStr(strArr)
    fmt.Printf("Type: %T\nSize: %v\n", arr, len(arr))
    min := findMin(arr)
    max := findMax(arr)
    // fmt.Printf("Max: %v, min: %v\n", max, min)

    // let's start
    result := calculateFuel(arr, min, max)
    fmt.Printf("Result part one: %v\n", result)
}
