-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 04   --
-- = = = = = = = = = = = == = = --

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

local file = aoc.fileRead('../test.txt')
-- local file = aoc.fileRead('../input.txt')

local card = aoc.explode("\n", file)

print("Size of table: " ..#card)
print(table.concat(card, "\n"))

local function game(win, gam)
    local count = 0
    for i = 1, #win do
        for j = 1, #gam do
            if win[i] == gam[j] then
                print("Found number " .. win[i])
                table.remove(gam, j)
                if count == 0 then
                    count = 1
                else
                    count = 2 * count
                end
            end
        end
    end
    return count
end

local function separateEachCard(array)
    local count = 0
    for i = 1, #array do
        local single = aoc.explode(":", array[i])
        local numb = aoc.explode("|", single[2])
        local win = aoc.explode(" ", numb[1])
        local gam = aoc.explode(" ", numb[2])
        count = count + game(win, gam)
    end
    return count
end

local function gameTwo(win, gam, index)
    local wins = {}
    for i = 1, #win do
        print("Current: " .. win[i])
        for j = 1, #gam do
            if win[i] == gam[j] then
                print("Found number " .. win[i])
                table.remove(gam, j)
                table.insert(wins, index)
                index = index + 1
            end
        end
    end
    return wins
end

local function partTwo(array)
    for i = 1, #array do
        local single = aoc.explode(":", array[i])
        local numb = aoc.explode("|", single[2])
        local win = aoc.explode(" ", numb[1])
        local gam = aoc.explode(" ", numb[2])
        local count = gameTwo(win, gam, i+1)
        print("Winning cards: " .. table.concat(count, " "))
    end
    return 0
end

local result = separateEachCard(card)
print("Result of part one: " .. result)

local res = partTwo(card)
print("Result of part two: " .. res)
