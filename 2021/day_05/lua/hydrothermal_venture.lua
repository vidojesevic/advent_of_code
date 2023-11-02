-- = = = = = = = = = = = = --
--   Hydrothermal Venture  --
-- = = = = = = = = = = = = --
package.path = package.path .. ";../../modules/modules.lua"
local aoc = require("modules")

local test = aoc.fileRead("../test.txt")

-- extract coordinates
local function extractCoordinates(str)
    local vent = aoc.explode("\n", str)
    local coordinates = {}
    for i = 1, #vent do
        local temp = aoc.explode("->", vent[i])
        for j = 1, #temp do
            table.insert(coordinates, temp[j])
        end
    end
    return coordinates
end
local coordinate = extractCoordinates(test)

-- extract X and y
local function extractXorY(arr, negative)
    local result = {}
    local start = 1
    if negative == false then
        start = 2
    end
    for i = start, #arr, 2 do
        table.insert(result, arr[i])
    end
    return result
end

local x = extractXorY(coordinate, true)
local y = extractXorY(coordinate, false)

-- make x1 and x2 from x
local function makex1x2(str, num) -- hardest part, naming things xD
    local temp = aoc.explode(",", str)
    return tonumber(temp[num])
end

local function extractEachCoordinate(arr, num)
    local result = {}
    for i = 1, #arr do
        table.insert(result, makex1x2(arr[i], num))
    end
    return result
end

local x1 = extractEachCoordinate(x, 1)
local y1 = extractEachCoordinate(x, 2)
local x2 = extractEachCoordinate(y, 1)
local y2 = extractEachCoordinate(y, 2)

-- findout index of horizontal/vertical vent
local function findHorizontalOrVerticalVent(arr1, arr2)
    local result = {}
    for i = 1, #arr1 do
        if arr1[i] == arr2[i] then
            table.insert(result, i)
        end
    end
    return result
end

local vertical = findHorizontalOrVerticalVent(x1, x2)
local horizontal = findHorizontalOrVerticalVent(y1, y2)

local vent = aoc.mergeTwoArrays(horizontal, vertical)
print(table.concat(vent, ", "))

-- arr (horizontal) 
local function fillDiagram(arr, coorX1, coorX2, coorY1, coorY2)
    local fill = {}
    for i = 1, #arr do
        -- print("Index " .. arr[i])
        -- print("x1: " .. coorX1[arr[i]])
        -- print("y1: " .. coorY1[arr[i]])
        -- print("x2: " .. coorX2[arr[i]])
        -- print("x2: " .. coorY2[arr[i]])
        if coorX1 == coorY1 then
            table.insert(fill)
        elseif coorX2 == coorY2 then
        end
    end
    return fill
end

local diagram = fillDiagram(vent, x1, x2, y1, y2)
