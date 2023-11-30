-- How many measurements are larger than the previous measurement?

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

local test = aoc.fileRead('../input.txt')
-- local test = aoc.fileRead('../test.txt')

local measurement = aoc.extractMesurmentsInTable(test)

local function findHowManyEncreases(measur, line)
    local count = 0
    for i = 2, line do
        if measur[i] > measur[i-1] then
            count = count + 1
        end
    end
    return count
end

local result = findHowManyEncreases(measurement, #measurement)
print("Part one result: " .. result)

-- Part Two

local function measurementTwo(tableMeasure)
    local measure = {}
    for i = 3, #measurement do
        local temp = tableMeasure[i] + tableMeasure[i-1] + tableMeasure[i-2]
        table.insert(measure, temp)
    end
    return measure
end

local partTwoTable = measurementTwo(measurement)

local resultTwo = findHowManyEncreases(partTwoTable, #partTwoTable)
print("Part two result: " .. resultTwo)
