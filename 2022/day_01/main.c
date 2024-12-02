#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sortArrays(int arr[], int index);

int main (void) {
    FILE *file;
    char line[256];
    int sum = 0;
    int current = 0;
    int elfs[3000];
    int index = 0;
    int best = 0;

    file = fopen("input.txt", "r");

    if (file == NULL) {
        printf("There is an error while reading file!\n");
        return EXIT_FAILURE;
    }

    while (fgets(line, sizeof(line), file)) {
        line[strcspn(line, "\n")] = 0;

        if (strlen(line) == 0)
        {
            if (sum < current) {
                sum = current;
            }
            elfs[index] = current;
            index++;
            current = 0;
        }

        if (strlen(line) > 0) {
            current += atoi(line);
        }
    }

    printf("Result of part one: %d\n", sum);

    best = sortArrays(elfs, index);

    printf("Result of part two id %d\n", best);

    fclose(file);
    file = NULL;
    return EXIT_SUCCESS;
}

int sortArrays(int arr[], int index) {
    int swapped = 0;

    for (int i = 0; i < index - 1; i++) {
        for (int j = 0; j < index - i - 1; j++) {
            if (arr[j] < arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                swapped = 1;
            }
        }

        if (swapped == 0) {
            break;
        }
    }

    return arr[0] + arr[1] + arr[2];
}