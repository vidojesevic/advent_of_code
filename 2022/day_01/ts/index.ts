const getInputArray = async (file: string): Promise<Array<string>> => {
    const input = Bun.file(file)

    const text = await input.text()

    return text.split('\n');
}

const findMaxCalories = (inputArray: Array<string>): number => {
    let maxCalories = 0;
    let currentCalories = 0;

    for (const line of inputArray) {
        if (line !== "") {
            currentCalories += parseInt(line);
        } else {
            if (currentCalories > maxCalories) {
                maxCalories = currentCalories;
            }
            currentCalories = 0;
        }
    }

    return maxCalories;
}

const findTop3Calories = (inputArray: Array<string>): number => {
    let elfArray = [];
    let elf = 0;

    for (const line of inputArray) {
        if (line !== "") {
            elf += parseInt(line);
        } else {
            elfArray.push(elf);
            elf = 0;
        }
    }

    elfArray.sort((a, b) => b - a);

    return elfArray[0] + elfArray[1] + elfArray[2];
}

const main = async () => {
    const inputArray = await getInputArray('input.txt');

    const result = findMaxCalories(inputArray);

    console.log("Part one: ", result);

    const partTwoResult = findTop3Calories(inputArray);

    console.log("Part two: ", partTwoResult);
}

main();
