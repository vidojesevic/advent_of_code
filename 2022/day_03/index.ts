const charToNumber = (char: string): number => {
    if (char === char.toLowerCase()) {
        // console.log("Char", char, "Value", char.charCodeAt(0) - 96);
        return char.charCodeAt(0) - 96;
    }

    // console.log("Char", char, "Value", char.charCodeAt(0) - 38);
    return char.charCodeAt(0) - 38;
};

const findCharacter = (items: string, len: number): number => {
    for (let i = 0; i < len / 2; ++i) {
        for (let j = len / 2; j < len; ++j) {
            if (items[i] === items[j]) {
                return charToNumber(items[i]);
            }
        }
    }

    return 0;
};

const calculatePriority = (lines: string[]): number => {
    let sum = 0;

    for (let i = 0; i < lines.length; i++) {

        sum += findCharacter(lines[i], lines[i].length);
    }

    return sum;
}

const calculatePriorityTwo = (lines: string[]): number => {
    let sum = 0;

    for (let i = 0; i < lines.length; i += 3) {

        sum += findBadge(lines[i], lines[i + 1], lines[i + 2]);
    }

    return sum;
}

const findBadge = (a: string, b: string, c: string): number => {
    for (let i = 0; i < a.length; ++i) {
        if (b.includes(a[i]) && c.includes(a[i])) {
            return charToNumber(a[i]);
        }
    }

    return 0;
}

const main = async () => {
    const file = Bun.file("input.txt");
    const text = await file.text();
    const lines = text.split("\n");

    console.log("Result of part one", calculatePriority(lines));

    console.log("Result of part one", calculatePriorityTwo(lines));
};

await main();
