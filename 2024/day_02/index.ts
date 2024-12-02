const calculateResult = (measures: string[], two = false): number => {
    let result = 0;

    for (let i = 0; i < measures.length; i++) {
        let increased = 0;
        let decreased = 0;
        let measure = measures[i].split(" ").map(element => Number(element));
        for (let j = 1; j < measures[i].length; j++) {

            if (measure[j] > measure[j - 1] && Math.abs(measure[j] - measure[j - 1]) <= 3) {
                increased++;
            }

            if (measure[j] < measure[j - 1] && Math.abs(measure[j - 1] - measure[j]) <= 3) {
                decreased++;
            }
        }

        if (increased === measure.length - 1 || decreased === measure.length - 1) {
            result++;
        } else if (two) {
            result += calculatePartTwo(measure);
        }
    }


    return result;
}

const calculatePartTwo = (measure: number[]): number => {

    for (let i = 0; i < measure.length; i++) {
        let increased = 0;
        let decreased = 0;
        const combination = [...measure.slice(0, i), ...measure.slice(i + 1)];

        for (let j = 1; j < combination.length; j++) {

            if (combination[j] > combination[j - 1] && Math.abs(combination[j] - combination[j - 1]) <= 3) {
                increased++;
            }

            if (combination[j] < combination[j - 1] && Math.abs(combination[j - 1] - combination[j]) <= 3) {
                decreased++;
            }
        }

        if (increased === combination.length - 1 || decreased === combination.length - 1) {
            return 1;
        }
    }

    return 0;
}

const main = async () => {
    const input = Bun.file("input.txt");
    const measures = await input.text();
    const lines = measures
        .split("\n")
        .filter(line => line !== "");


    console.log("Result of part one:", calculateResult(lines))

    console.log("Result of part two:", calculateResult(lines, true))
};

await main();
