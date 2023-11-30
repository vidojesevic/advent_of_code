-- Dive
-- forward X - increases horizontal by X units
-- down X - increases the depth by X units
-- up X - decreases the depth by X units
package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

local test = aoc.fileRead('../input.txt')
-- local test = aoc.fileRead('../test.txt')

local lineCount = aoc.lines(test)

local positionTable = aoc.extractMesurmentsInTable(test)

local function extractNumberFromString(item)
    local number = string.match(item, "%d+")
    return tonumber(number)
end

local function findoutPosition(tableFile)
    local position = 0
    local horizontal = 0
    local depth = 0
    for i = 1, #tableFile do
        local num = extractNumberFromString(tableFile[i])
        if string.match(tableFile[i], 'forward') then
            horizontal = horizontal + num
        elseif string.match(tableFile[i], 'down') then
            depth = depth + num
        elseif string.match(tableFile[i], 'up') then
            depth = depth - num
        end
    end
    position = depth * horizontal
    return position
end

local resultPartOne = findoutPosition(positionTable)
print("Part one | Current possition is " .. resultPartOne)

local function findoutPositionAim(tableFile)
    local position = 0
    local horizontal = 0
    local depth = 0
    local aim = 0
    for i = 1, #tableFile do
        local num = extractNumberFromString(tableFile[i])
        if string.match(tableFile[i], 'forward') then
            horizontal = horizontal + num
            depth = depth + aim * num
        elseif string.match(tableFile[i], 'down') then
            aim = aim + num
        elseif string.match(tableFile[i], 'up') then
            aim = aim - num
        end
    end
    position = depth * horizontal
    return position
end

local resultPartTwo = findoutPositionAim(positionTable)
print("Part two | Current possition is " .. resultPartTwo)
