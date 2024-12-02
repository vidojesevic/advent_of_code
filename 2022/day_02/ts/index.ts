enum MyHand {
    X = 1, // Rock
    Y = 2, // Paper
    Z = 3 // Scissors
}

enum Game {
    loss = 0,
    draw = 3,
    win = 6
}

const readFromFile = async (path: string): Promise<string> => {
    return path && await Bun.file(path).text();
}

const calculateGames = (input: string, partTwo: boolean): number => {
    const inputArray = input.split('\n');
    let result = 0;

    for (const line of inputArray) {
        if (line !== '') {
            result += partTwo
                ? playGameForReal(line.split(' ')[0], line.split(' ')[1])
                : playGame(line.split(' ')[0], line.split(' ')[1]) + MyHand[line.split(' ')[1] as keyof typeof MyHand];
        }
    }

    return result;
}

const playGame = (elfHand: string, myHand: string): number | any => {
    if (myHand === "X" && elfHand === "A"
        || myHand === "Y" && elfHand === "B"
        || myHand === "Z" && elfHand === "C"
    ) {
        return Game.draw;
    }

    if (myHand === "X" && elfHand === 'B'
        || myHand === "Y" && elfHand === 'C'
        || myHand == "Z" && elfHand === "A"
    ) {
        return Game.loss;
    }

    if (myHand === "X" && elfHand === "C"
        || myHand === 'Y' && elfHand === 'A'
        || myHand === "Z" && elfHand === "B"
    ) {
        return Game.win;
    }

}

const playGameForReal = (elfHand: string, expect: string): number | any => {
    // draw
    if (expect === "Y") {
        if (elfHand === "A")
            return 4;
        if (elfHand === "B")
            return 5;
        if (elfHand === "C")
            return 6;
    }

    // lose
    if (expect === "X" && elfHand === "B")
        return Game.loss + 1;
    if (expect === "X" && elfHand === "C")
        return 2;
    if (expect === "X" && elfHand === "A")
        return 3

    // win
    if (expect === "Z") {
        if (elfHand === "B")
            return 9;
        if (elfHand === "C")
            return 7;
        if (elfHand === "A")
            return 8;
    }
}

const main = async () => {
    const fileString = await readFromFile('input.txt')
    console.log("Part one: " + calculateGames(fileString, false));
    console.log("Part two: " + calculateGames(fileString, true));
}

await main();
