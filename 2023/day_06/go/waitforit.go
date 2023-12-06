package main

import (
    "fmt"
    "os"
    "log"
    "strings"
    "strconv"
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

func extractData(data []string) []int64 {
    var arr []int64
    // fmt.Printf("Values: %v\n", data[2])
    for i := 0; i < len(data); i++ {
        if n, err := strconv.ParseInt(data[i], 10, 0); err == nil {
            arr = append(arr, n)
        } else {
            // fmt.Printf("%v is not an integer.", data[i])
            continue
        }
    }

    return arr
}

func race(time []int64, dist []int64) int64 {
    var count int64 = 0
    var result int64 = 0
    for i := 0; i < len(time); i++ {
        fmt.Printf("Time: %v, dist: %v\n", time[i], dist[i])
        for j := 0; j < int(time[i]); j++ {
            var temp int64 = 0
            var press = int64(j) + 1
            var rang = time[i] - int64(j) - 1
            for k := 0; int64(k) < rang; k++ {
                temp += press
            }
            // fmt.Printf("temp: %v, dist: %v\n", temp, dist[i])
            if temp > dist[i] {
                count++
            }
        }
        fmt.Printf("count: %v\n", count)
        if result != 0 {
            result = result * count
        } else {
            result = count
        }
        count = 0
    }

    return result
}

func extractPartTwo(data []string) (int, error) {
    str := ""

    for i := 0; i < len(data); i++ {
        // fmt.Printf("current: %v\n", data[i])
        if n, err := strconv.ParseInt(data[i], 10, 0); err == nil {
            str = str + fmt.Sprintf("%d", n)
        } else {
            continue
        }
    }
    // fmt.Printf("string value: %v\n", str)

    return strconv.Atoi(str)
}

func raceFinal(time int, dist int) int {
    var count int = 0
    for j := 0; j < time; j++ {
        if (time - j - 1) * (j + 1) > dist {
            count++
            fmt.Printf("Race won: %v\n", count)
        }
    }

    return count
}

func main() {
    fmt.Println("Advent of Code")
    fmt.Println("Day 6: Wait for it")

    file := readFile("../test.txt")
    // file := readFile("../input.txt")
    str := explode("\n", file)
    timeStr := explode(" ", str[0])
    // fmt.Printf("Times: %v\n", timeStr)
    distStr := explode(" ", str[1])
    // fmt.Printf("Distance: %v\n", distStr)
    times := extractData(timeStr)
    // fmt.Printf("Times: %v\n", times)
    dist := extractData(distStr)
    // fmt.Printf("Distance: %v\n", dist)

    res := race(times, dist)
    fmt.Printf("Result of part one: %v\n", res)

    // part two
    tim, e := extractPartTwo(timeStr)
    dis, r := extractPartTwo(distStr)
    if e != nil && r != nil {
        log.Printf("Errors: %v\n%v\n", e, r)
    }
    // fmt.Printf("Time: %v, Distance: %v\n", tim, dis)

    resTwo := raceFinal(tim, dis)
    fmt.Printf("Result of part two: %v\n", resTwo)
}
