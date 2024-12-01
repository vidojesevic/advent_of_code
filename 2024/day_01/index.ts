// --- Day 1: Historian Hysteria ---

const fillArray = (distance: string[], side: number): number[] => {
    let result = [];
    for (let i = 0; i < distance.length; ++i) {
        let temp = distance[i].split("   ")[side];
        if (temp !== "" && temp !== undefined)
            result.push(temp);
    }
    return result;
}

const calculateDistance = (left: number[], right: number[]): number => {
    let sum = 0;

    for (let i = 0; i < left.length; ++i) {
        sum += Math.abs(left[i] - right[i]);
    }

    return sum;
}

const calculatePartTwo = (left: number[], right: number[]): number => {
    let sum = 0;

    for (let i = 0; i < left.length; ++i) {
        for (let j = 0; j < right.length; ++j) {
            if (left[i] === right[j]) {
                sum += Math.abs(left[i]);
            }
        }
    }

    return sum;
}


const main = async () => {
    const file = Bun.file("input.txt")
    const distances = await file.text();

    let left = fillArray(distances.split("\n"), 0);
    let right = fillArray(distances.split("\n"), 1);

    const resultPartOne = calculateDistance(left.sort((a, b) => a - b), right.sort((a, b) => a - b));

    console.log("Result of part one", resultPartOne);

    console.log(calculatePartTwo(left.sort((a, b) => a - b), right.sort((a, b) => a - b)));
}

await main();
