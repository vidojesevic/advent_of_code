-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 04   --
-- = = = = = = = = = = = == = = --

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

-- local file = aoc.fileRead('../test.txt')
local file = aoc.fileRead('../input.txt')

local card = aoc.explode("\n", file)

print("Size of table: " ..#card)
-- print(table.concat(card, "\n"))

local function game(win, gam)
    local count = 0
    for i = 1, #win do
        for j = 1, #gam do
            if win[i] == gam[j] then
                -- print("Found number " .. win[i])
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

local function game2(win, gam)
    local count = 0
    for i = 1, #win do
        for j = 1, #gam do
            if win[i] == gam[j] then
                -- print("Found number " .. win[i])
                table.remove(gam, j)
                count = 1 + count
            end
        end
    end
    return count
end

local function partTwo(array)
    local copies = {}
    for _ = 1, #array do
        table.insert(copies, 1)
    end

    for i = 1, #array do
        -- print(table.concat(copies, " "))
        local single = aoc.explode(":", array[i])
        local numb = aoc.explode("|", single[2])
        local win = aoc.explode(" ", numb[1])
        local gam = aoc.explode(" ", numb[2])
        local temp = game2(win, gam)
        for j = i + 1, i + temp do
            copies[j] = copies[j] + copies[i]
        end
    end
    return copies
end

local result = separateEachCard(card)
print("Result of part one: " .. result)

local copy = partTwo(card)

local function copies(arr)
    local count = 0
    for i = 1, #arr do
        count = count + arr[i]
    end
    return count
end

local resultTwo = copies(copy)

print("Result of part two: " .. resultTwo)
