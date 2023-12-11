-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 11   --
-- = = = = = = = = = = = == = = --

print("Advent of Code 2023\nDay 11: Cosmic Expansion")
package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

-- local file = aoc.fileRead('../test.txt')
local file = aoc.fileRead('../input.txt')

local lines = aoc.explode("\n", file)

local function addVertical(arr)
    local index = 1
    local result = {}
    local ex = {}
    for j = 1, #arr[index] do
        local check = 0
        for i = 1, #arr do
            local c = arr[i]:sub(j,j)
            if c ~= "." then
                check = check + 1
            end
        end
        if check == 0 then
            table.insert(ex, j)
        end
    end
    for j, v in ipairs(ex) do
        print("index " .. v)
        for i = 1, #arr do
            arr[i] = arr[i]:sub(1, v + j - 1) .. "." .. arr[i]:sub(v + j, #arr[i])
        end
    end

    return arr
end

local function findCoordinates(arr)
    local coor = {}
    for i = 1, #arr do
        for j = 1, #arr[i] do
            local c = arr[i]:sub(j,j)
            if tonumber(c) then
                table.insert(coor, i)
                table.insert(coor, j)
            end
        end
    end
    return coor
end

local function addingLine(arr, count)
    local result = {}
    for i = 1, #arr do
        local check = false
        local hash = nil
        for j = 1, #arr[i] do
            local c = arr[i]:sub(j, j)
            if c == "#" then
                check = true
                count = count + 1
                hash = j
                arr[i] = arr[i]:sub(1, hash - 1) .. count .. arr[i]:sub(hash + 1, #arr[i])
            end
        end
        table.insert(result, arr[i])
        if not check then
            table.insert(result, arr[i])
        end
    end
    result = addVertical(result)
    local coor = findCoordinates(result)
    return result, coor
end

local function universeExpansion(arr)
    -- local index = 1
    local result, coor = addingLine(arr, 0)
    return result, coor
end

local expanded, coordinates = universeExpansion(lines)
print(table.concat(expanded, "\n") .. "\nx-length: " .. #expanded .. ", y-length: " .. #expanded[1])

-- print galaxies
for i = 1, #coordinates, 2 do
    print(" => (" .. coordinates[i] .. "," .. coordinates[i+1] .. ")")
end

local function shortestPath(arr)
    local count = 0
    local pair = 0
    for i = 1, #arr, 2 do
        local x, y = arr[i], arr[i+1]
        -- print("x: " .. x .. ", y: " .. y)
        -- print("Comparing to:")
        for j = i + 2, #arr, 2 do
            pair = pair + 1
            local tempX, tempY = arr[j], arr[j+1]
            count = count + tempX - x
            if tempY > y then
                count = count + tempY - y
                print("Pair " .. arr[i] .. " " .. arr[j] .. " Count: " .. tempX - x + tempY - y)
            else
                print("Pair " .. arr[i] .. " " .. arr[j] .. " Count: " .. tempX - x + y - tempY)
                count = count + y - tempY
            end
        end
        -- print("**************")
    end
    print("There is " .. pair .. " pairs")
    return count
end

local result = shortestPath(coordinates)
print("Result of part one: " .. result)
