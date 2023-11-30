#ifndef CRAB_H
#define CRAB_H

#define MAX_NUMBERS 1024

int* readFile(const char *filePath);
int findMin(int* arr, int size);
int findMax(int* arr, int size);
int calculateFuel(int* num, int size, int min, int max);

#endif
