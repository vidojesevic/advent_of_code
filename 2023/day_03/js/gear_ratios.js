import fs from "node:fs";

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
        // for (let i = 0; i < 1; i++) {
        const indexes = {};
        let num = [];
        let temp = '';
        for (let j = 0; j < arr[i].length; j++) {
            const current = arr[i][j];
            const next = arr[i][j + 1];
            const third = arr[i][j + 2];
            if (!isDigit(current) || isSymbol(current)) {
                continue;
            }
            // one digit
            if (isDigit(current) && !indexes[i]) {
                indexes[j] = arr[i][j];
                temp += current;
                num.push(j);
            }
            // two digit
            if (next != undefined && isDigit(next) && !indexes[j + 1]) {
                num.push(j + 1);
                indexes[j + 1] = arr[i][j + 1];
                temp += arr[i][j + 1];
            }
            // third
            if (third !== undefined && isDigit(third) && !indexes[j + 2]) {
                indexes[j + 2] = arr[i][j + 2];
                temp += arr[i][j + 2];
                num.push(j + 2);
            }

            // Checking numbers
            if (nums[nums.length - 1] !== temp && temp !== "" && temp.length <= 3) {
                nums.push(temp);
                console.log(nums);
                console.log(num);
                const check = isValid(arr, i, num);
                if (check !== null) {
                    console.log("Temp: " + temp);
                    count += Number(temp);
                }
            }
            console.log(indexes);
        }
        // console.log("Index: " + num);
        num = [];
    }
    console.log(arr);
    return count;
}

const isValid = (arr, line, ind) => {
    for (let i = 0; i < ind.length; i++) {
        const current = ind[i];
        // console.log("Coordinates: (" + line + "," + current + ")");
        // console.log("Length of indexes: " + ind.length);
        // horizontal right
        if (arr[line][current + 1] !== undefined && !isDigit(arr[line][current + 1]) && isSymbol(arr[line][current + 1])) {
            console.log("Right valid! (" + line + "," + (current + 1) + ")");
            return 1;
        }
        // horizontal left
        if (arr[line][current - 1] !== undefined && !isDigit(arr[line][current - 1]) && isSymbol(arr[line][current - 1])) {
            console.log("Left valid! (" + line + "," + (current - 1) + ")");
            return 1;
        }
        // vertical down
        if (arr[line + 1] !== undefined && !isDigit(arr[line+1][current]) && isSymbol(arr[line+1][current])) {
            console.log("Down valid! (" + (line + 1) + "," + (current) + ")");
            return 1;
        }
        // vertical up
        if (arr[line - 1] !== undefined && !isDigit(arr[line-1][current]) && isSymbol(arr[line-1][current])) {
            console.log("Up valid! (" + (line - 1) + "," + (current) + ")");
            return 1;
        }
        // diagonal to bottom right
        if (arr[line+1] !== undefined && current !== arr.length - 1 && !isDigit(arr[line+1][current + 1]) && isSymbol(arr[line+1][current + 1])) {
            console.log("bottom right");
            return 1;
        }
        // diagonal to bottom left
        if (arr[line+1] !== undefined && current !== 0 && !isDigit(arr[line+1][current - 1]) && isSymbol(arr[line+1][current])) {
            console.log("bottom left");
            return 1;
        }
        // diagonal to upper right
        if (arr[line-1] !== undefined && current !== arr.length - 1 && !isDigit(arr[line-1][current + 1]) && isSymbol(arr[line-1][current + 1])) {
            console.log("upper right");
            return 1;
        }
        // diagonal to upper left
        if (arr[line-1] !== undefined && current !== 0 && !isDigit(arr[line-1][current - 1]) && isSymbol(arr[line-1][current - 1])) {
            console.log("upper left");
            return 1;
        }
    }
    return null;
};

const isDigit = (char) => /\d/.test(char);

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
