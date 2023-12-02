-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 02   --
-- = = = = = = = = = = = == = = --

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

-- local file = aoc.fileRead('../test.txt')
local file = aoc.fileRead('../input.txt')

local arr = aoc.explode("\n", file)

-- print("Size of table: " ..#arr)
-- print(table.concat(arr, "\n"))

local function extractOneGame(str)
    return aoc.explode(" ", str)
end

-- print(table.concat(extractOneGame(arr[1]), "\n"))

local function checkCubes(col, num, str, lim)
    for i = 1, #str do
        if string.find(col, str[i]) then
            -- print("Checking for color: " .. col .. ", value: " .. num)
            if num > lim[i] then
                return 1
            else
                return 0
            end
        end
    end
end

local function isGamePossible(niz)
    -- print(table.concat(niz, " "))
    local colors = {'red', 'green', 'blue'}
    local limit = {12, 13, 14}
    local err = 0
    for i = 4, #niz, 2 do
        err = checkCubes(niz[i], tonumber(niz[i-1]), colors, limit)
        if err ~= 0 then
            return false
        end
    end
    return true
end

local function game(ar)
    local temp
    local count = 0
    for i = 1, #ar do
        temp = extractOneGame(ar[i])
        if isGamePossible(temp) then
            count = count + i
            -- print("Game: " .. i .. " is possible?")
        end
    end
    return count
end

local res = game(arr)
print("Result of part 0ne: " .. res)

local function maxColor(gam, color)
    local max = 0.0
    for i = 4, #gam, 2 do
        if string.find(gam[i], color) then
            local num = tonumber(gam[i-1])
            if max < num then
                max = num
            end
        end
    end
    return max
end

-- Find the sum of power of fewest number of cubes of each color
local function gameFew(input)
    local temp
    local count = 0
    for i = 1, #input do
        temp = extractOneGame(input[i])
        local red = maxColor(temp, "red")
        local green = maxColor(temp, "green")
        local blue = maxColor(temp, "blue")
        count = count + red * green * blue
    end
    return count
end

local resPartTwo = gameFew(arr)
print("Result of part 0ne: " .. resPartTwo)
