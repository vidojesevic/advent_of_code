#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "crab.h"

int main(void) {
    printf("Advent of Code 2021 || Day 07\n");
    // int size = 1000;
    int size = 10;

    int *num = readFile("../test.txt");
    // int *num = readFile("../input.txt");

    printf("Size of array: %d\nValues:\n", size);

    // for (int i = 0; i < size; ++i) {
    //     printf("%d: %d\n", i, num[i]);
    // }
    int min = findMin(num, size);
    int max = findMax(num, size);

    int result = calculateFuel(num, size, min, max);
    printf("Result part one: %d\n", result);

    free(num);

    return 0;
}

int* readFile(const char *filePath) {
    int ch;
    char arr[MAX_NUMBERS * 5];
    int* num = malloc(MAX_NUMBERS * sizeof(int));

    FILE *fp = fopen(filePath, "r");
    if (fp == NULL) {
        fputs("Failed to open the file\n", stderr);
        exit(EXIT_FAILURE);
    }

    int i = 0;
    while ((ch = fgetc(fp)) != EOF) {
        arr[i] = (char)ch;
        i++;
    }

    char* div = ",";
    char* token = strtok(arr, div);
    i = 0;

    while (token != NULL && i < MAX_NUMBERS) {
        num[i] = atoi(token);
        token = strtok(NULL, div);
        i++;
    }

    fclose(fp);

    return num;
}

int findMin(int* arr, int size) {
    int min = 0;
    for (int i = 0; i < size; ++i) {
        if (min > arr[i]) {
            min = arr[i];
        }
    }
    return min;
}

int findMax(int* arr, int size) {
    int max = 0;
    for (int i = 0; i < size; ++i) {
        if (max < arr[i]) {
            max = arr[i];
        }
    }
    return max;
}

int calculateFuel(int* num, int size, int min, int max) {
    int count;

    return count;
}
