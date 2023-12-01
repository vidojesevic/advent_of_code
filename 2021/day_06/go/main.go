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

func fishes(init []int64) int64 {
    var count int64 = int64(len(init))
    for i := 0; i < 80; i++ {
        for j := 0; j < len(init); j++ {
            init[j]--
            if init[j] == -1 {
                init[j] = 6
                init = append(init, 9)
                count++
            }
        }
    }
    return count
}
//
// func partTwo(init []int64) int {
//     for i := 0; i < 200; i++ {
//         for j := 0; j < len(init); j++ {
//             init[j]--
//             if init[j] == -1 {
//                 init[j] = 6
//                 init = append(init, 9)
//             }
//         }
//     }
//     return len(init)
// }

func main() {

    // fileStr := readFile("../input.txt")
    fileStr := readFile("../test.txt")
    // fmt.Printf("This is output of the file: %s", fileStr)

    fileArr := explode(",", fileStr)
    arrInt := makeIntOfStr(fileArr)

    // fmt.Printf("Length of the array is: %d\n", len(arrInt))
    // fmt.Printf("Array: %v\n", arrInt)

    count := fishes(arrInt)
    fmt.Printf("Result of part one: %v\n", count)

    // countTwo := partTwo(arrInt)
    // fmt.Printf("Result of part two: %v\n", countTwo)
}
