package main

import (
    "fmt"
    "camel_cards/utils"
    "strings"
    "strconv"
)

type Card struct {
    label   string
    rank    int
}

type Hand struct {
    cards string
    rank int
    bid int
}

type HandStrength int

const (
    FiveOfAKind HandStrength = iota + 7
    FourOfAKind = 6
    FullHouse = 5
    ThreeOfAKind = 4
    TwoPair = 3
    OnePair = 2
    HighCard = 1
)

func (c *Card) initListOfAvailableCards() []Card {
    list := [13]string{"A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"}
    cards := make([]Card, len(list))
    for i, v := range list {
        cards[i] = Card{label: v, rank: 13 - i}
    }
    return cards
}

func checkStrengts(cards string) int {
    count := make(map[rune]int)
    for _, char := range cards {
        count[char]++
    }

    res := 0

    if len(count) == 1 {
        res = FiveOfAKind
    }

    if len(count) == 2 && count['A'] == 1 || count['A'] == 4 {
        res = FourOfAKind
    }

    if len(count) == 2 && count['A'] == 2 || count['A'] == 3 {
        res = FullHouse
    }

    if len(count) == 3 && count['A'] == 1 || count['A'] == 3 {
        res = FullHouse
    }

    return res
}

func main() {
    // cards := Card{}
    // availableCards := cards.initListOfAvailableCards()

    // read from file
    input := utils.ReadFile("../test.txt")

    allCards := make([]Hand, 0, len(input))
    currentRank := 1

    for _, v := range input {
        temp := strings.Split(v, " ")
        strengts := checkStrengts(temp[0])

        bid, err := strconv.Atoi(temp[1])
        if err != nil {
            panic(err)
        }

        allCards = append(allCards, Hand{cards: temp[0], rank: strengts, bid: bid})
        currentRank++
    }

    for _, v := range allCards {
        fmt.Printf("Hand: %v - Strength: %v - Bid: %v\n", v.cards, v.rank, v.bid)
    }
}
