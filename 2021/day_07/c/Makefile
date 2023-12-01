# Advent Of Code Day 7: The Treachery of Whales

CC = gcc
SRC = crab.c
OUT = crab

CFLAGS = -g -Wall -Wextra
STD = c11

all: $(OUT)

$(OUT): $(SRC)
	$(CC) $(CFLAGS) -std=$(STD) -o $(OUT) $(SRC)

clean:
	rm -rv $(OUT)
