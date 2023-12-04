import fs from "node:fs";
import { isNumber } from "node:util";

const readFile = (path) => {
    fs.readFile(path, 'utf8', (err, data) => {
        if (err) {
            console.log(err);
            throw err;
        }
        // rest of code
        const arr = makeArray(data);
        arr.pop();
        const result = sumOf(arr);
        console.log("Result of part one: " + result);
    });
};

const makeArray = (data) => {
    const arr = data.split('\n');
    return arr;
};

const sumOf = (arr) => {
    let count = 0;
    const nums = [];
    // console.log("Length of string is " + arr[0].length);
    for (let i = 0; i < arr.length; i++) {
        // for (let i = 2; i < 3; i++) {
        const num = [];
        let temp = '';
        const indexes = {};
        for (let j = 0; j < arr[i].length; j++) {
            const current = arr[i][j];
            const next = arr[i][j + 1];
            const third = arr[i][j + 2];
            // const prev = arr[i][j-1];
            if (!isDigit(current) || isSymbol(current)) {
                console.log("Dot");
                // continue;
            }

            // one digit
            if ((arr[i][j-1] === undefined || !isDigit(arr[i][j-1])) && isDigit(current) && indexes[j] === undefined) {
                indexes[j] = arr[i][j];
                temp += current;
                num.push(j);
            }

            // two digit
            if (isDigit(next) && indexes[j + 1] === undefined) {
                num.push(j + 1);
                indexes[j + 1] = arr[i][j + 1];
                temp += arr[i][j + 1];
            }

            // third
            if (isDigit(third) && indexes[j + 2] === undefined) {
                num.push(j + 2);
                indexes[j + 2] = arr[i][j + 2];
                temp += arr[i][j + 2];
            }
            console.log("Checking for " + current);

            // Checking numbers
            if (nums[nums.length - 1] != temp && temp != "" && temp.length <= 3) {
                const check = isValid(arr, i, num);
                nums.push(temp);
                if (check !== null) {
                    console.log("Temp: " + temp);
                    count += Number(temp);
                }
            }
        }
    }
    return count;
}

const isValid = (arr, line, ind) => {
    console.log("Line: " + line + " => Indexes: " + ind);
    for (let i = 0; i < ind.length; i++) {
        const current = ind[i];
        const next = ind[i] + 1;
        const prev = ind[i] - 1;
        // console.log("Coordinates: (" + line + "," + current + ")");
        // horizontal right
        if (arr[line][current + 1] !== undefined && !isDigit(arr[line][next]) && isSymbol(arr[line][next])) {
            console.log("Right valid! (" + line + "," + (current + 1) + ")");
            return 1;
        }
        // horizontal left
        if (arr[line][current - 1] !== undefined && !isDigit(arr[line][prev]) && isSymbol(arr[line][prev])) {
            console.log("Left valid! (" + line + "," + (current - 1) + ")");
            return 1;
        }
        // vertical down
        if (arr[line + 1] !== undefined && !isDigit(arr[line+1][current]) && isSymbol(arr[line+1][current])) {
            console.log("Down valid! (" + (line + 1) + "," + (current) + ")");
            return 1;
        }
        // vertical up
        if (arr[line - 1] !== undefined && !isDigit(arr[line - 1][current]) && isSymbol(arr[line - 1][current])) {
            console.log("Up valid! (" + (line - 1) + "," + (current) + ")");
            return 1;
        }
        // diagonal to bottom right
        if (arr[line+1] !== undefined && arr[line + 1][next] && current !== arr.length - 1 && !isDigit(arr[line+1][next]) && isSymbol(arr[line+1][next])) {
            console.log("Down valid! (" + (line + 1) + "," + (current) + ")");
            return 1;
        }
        // diagonal to bottom left
        if (arr[line+1] !== undefined && arr[line + 1][prev] !== undefined && current !== 0 && !isDigit(arr[line+1][prev]) && isSymbol(arr[line+1][prev])) {
            console.log("bottom left");
            return 1;
        }
        // diagonal to upper right
        if (arr[line-1] !== undefined && current !== arr.length - 1 && !isDigit(arr[line-1][next]) && isSymbol(arr[line-1][next])) {
            console.log("upper right");
            return 1;
        }
        // diagonal to upper left
        if (arr[line-1] !== undefined && current !== 0 && !isDigit(arr[line-1][prev]) && isSymbol(arr[line-1][prev])) {
            console.log("upper left");
            return 1;
        }
    }
    return null;
};

const isDigit = (chr) => {
    const number = /^\d+$/;
    if (number.test(chr)) {
        return true;
    }
    return false;
};

const isSymbol = (char) => {
    const dot = /^[!@#\$%\^\&*\)\(+=_-]+$/;
    if (char.match(dot)) {
        return true;
    }

    return false;
}

const main = (file) => {
    console.log("Advent of Code 2023\nDay 03: Gear Ratios");

    readFile(file);
};

// main("../test.txt");
main("../input.txt");
console.log("Wrong answer 1: 514400");
console.log("Wrong answer 2: 514455");
