-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 11   --
-- = = = = = = = = = = = == = = --

print("Advent of Code 2023\nDay 11: Cosmic Expansion")
package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

local file = aoc.fileRead('../test.txt')
-- local file = aoc.fileRead('../input.txt')

local lines = aoc.explode("\n", file)

local function addingLine(arr, count)
    local result, coor = {}, {}
    for i = 1, #arr do
        local check = false
        table.insert(result, arr[i])
        for j = 1, #arr[i] do
            local c = arr[i]:sub(j, j)
            if c == "#" then
                check = true
                count = count + 1
                local temp = tostring(count)
                arr[i][j] = tostring(temp)
                table.insert(coor, i)
                table.insert(coor, j)
            end
        end
        if not check then
            table.insert(result, arr[i])
        end
    end
    return result, coor
end

local function universeExpansion(arr)
    local count = 0
    -- local index = 1
    local result, coor = addingLine(arr, count)
    return result, coor
end

local expanded, coordinates = universeExpansion(lines)
print(table.concat(expanded, "\n") .. "\nfile length: " .. #expanded)

-- print galaxies
for i = 1, #coordinates, 2 do
    print(coordinates[i] .. " => (" .. coordinates[i+1] .. "," .. coordinates[i+2] .. ")")
end

local function shortestPath(arr)
    local count = 0
    local pair = 0
    for i = 1, #arr, 2 do
        local x, y = arr[i], arr[i+1]
        print("x: " .. x .. ", y: " .. y)
        print("Comparing to:")
        for j = i + 2, #arr, 2 do
            pair = pair + 1
            local tempX, tempY = arr[j], arr[j+1]
            count = count + tempX - x
            if tempY > y then
                count = count + tempY - y
                print("Pair " .. arr[i - 1] .. " " .. arr[j - 1] .. " Count: " .. tempX - x + tempY - y)
            else
                print("Pair " .. arr[i - 1] .. " " .. arr[j - 1] .. " Count: " .. tempX - x + y - tempY)
                count = count + y - tempY
            end
        end
        print("**************")
    end
    print("There is " .. pair .. " pairs")
    return count
end

local result = shortestPath(coordinates)
print("Result of part one: " .. result)
