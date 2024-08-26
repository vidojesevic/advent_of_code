package main

import (
    "fmt"
    "strings"
    "strconv"
    "camel_cards/utils"
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

type Node struct {
    value *Hand
    next  *Node
}

type LinkedList struct {
    head  *Node
    tail  *Node
}

func (c *Card) initListOfAvailableCards() []Card {
    list := [13]string{"A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"}
    cards := make([]Card, len(list))
    for i, v := range list {
        cards[i] = Card{label: v, rank: 13 - i}
    }
    return cards
}

func checkStrengtOfHand(cards string) int {
    res := 0
    count := make(map[rune]int)
    for _, char := range cards {
        count[char]++
    }

    if len(count) == 1 {
        res = 7
    }

    if len(count) == 2 {
        for _, v := range count {
            if v == 4 {
                res = 6
            } else if v == 3 {
                res = 5
            }
        }
    }

    if len(count) == 3 {
        for _, v := range count {
            if v == 1 || v == 3 {
                res = 4
            } else if v == 2 || v == 1 {
                res = 3
            }
        }
    }

    if len(count) == 4 {
        res = 2
    } else if len(count) == 5 {
        res = 1
    }

    return res
}

func (ll *LinkedList) AppendToList(hand *Hand, availableCards *[]Card) {
    newNode := &Node{value: hand}

    if ll.head == nil {
        ll.head = newNode
        ll.tail = newNode
        return
    } 

    current := ll.head
    previous := (*Node)(nil)

    for current != nil {
        if hand.rank > current.value.rank {
            break
        } else if hand.rank == current.value.rank {
            val := compareHandsWithSameRank(hand, current.value, availableCards)
            if val == hand {
                break
            }
        }
        previous = current
        current = current.next
    }

    if previous == nil {
        // Insert at the head
        newNode.next = ll.head
        ll.head = newNode
    } else if current == nil {
        // Insert at the tail
        ll.tail.next = newNode
        ll.tail = newNode
    } else {
        // Insert between nodes
        previous.next = newNode
        newNode.next = current
    }
}

func compareHandsWithSameRank(hand *Hand, current *Hand, availableCards *[]Card) *Hand {
    newCards := hand.cards
    currentCards := current.cards

    for i := 0; i < len(newCards); i++ {
        if newCards[i] == currentCards[i] {
            continue
        }

        newRank := getCardRank(string(newCards[i]), availableCards)
        currentRank := getCardRank(string(currentCards[i]), availableCards)

        if newRank > currentRank {
            return hand
        } else if newRank < currentRank {
            return current
        }
    }

    return nil
}

func getCardRank(label string, availableCards *[]Card) int {
    for _, card := range *availableCards {
        if card.label == label {
            return card.rank
        }
    }
    return -1 // Return -1 if card label is not found (should not happen)
}

func (ll *LinkedList) Print() {
    current := ll.head
    for current != nil {
        fmt.Printf("Hand: %v - Strength: %v - Bid: %v\n", current.value.cards, current.value.rank, current.value.bid)
        current = current.next
    }
}

func (ll *LinkedList) Length() int {
    length := 0
    current := ll.head

    for current != nil {
        length++
        current = current.next
    }

    return length
}

func (ll *LinkedList) Sum() int {
    length := ll.Length()
    sum := 0
    current := ll.head

    for current != nil {
        sum += current.value.bid * length
        current = current.next
        length--
    }

    return sum
}

func main() {
    cards := Card{}
    availableCards := cards.initListOfAvailableCards()

    // read from file
    input := utils.ReadFile("../input.txt")

    // currentRank := 1

    linkedList := &LinkedList{}

    for _, v := range input {
        temp := strings.Split(v, " ")
        hand := temp[0]
        strengts := checkStrengtOfHand(hand)

        bid, err := strconv.Atoi(temp[1])
        if err != nil {
            panic(err)
        }

        linkedList.AppendToList(&Hand{cards: hand, rank: strengts, bid: bid}, &availableCards)
    }

    result := linkedList.Sum()

    fmt.Printf("Result of day 07 - Part One = %v", result)
}
