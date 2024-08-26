package utils

import (
    "os"
    "bufio"
)

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func ReadFile(filename string) []string {
    file, err := os.Open(filename)
    if err != nil {
        panic(err)
    }
    defer file.Close()

    var lines []string
    scaner := bufio.NewScanner(file)

    for scaner.Scan() {
        lines = append(lines, scaner.Text())
    }

    if err := scaner.Err(); err != nil {
        panic(err)
    }

    return lines
}
