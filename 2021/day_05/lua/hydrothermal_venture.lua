-- = = = = = = = = = = = = --
--   Hydrothermal Venture  --
-- = = = = = = = = = = = = --
package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

-- local test = aoc.fileRead("../test.txt")
local test = aoc.fileRead("../input.txt")
-- print(test)

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
-- print(table.concat(coordinate, "\n"))

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

local function fillDiagramVert(arr, coorX1, coorY1, coorY2)
    local fill = {}
    for i = 1, #arr do
        table.insert(fill, coorX1[arr[i]] .. "," .. coorY1[arr[i]])
        local max = math.max(coorY1[arr[i]], coorY2[arr[i]])
        if max == coorY1[arr[i]] then
            local div = coorY1[arr[i]] - coorY2[arr[i]]
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] .. "," .. coorY1[arr[i]] - j)
            end
        elseif max == coorY2[arr[i]] then
            local div = coorY2[arr[i]] - coorY1[arr[i]]
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] .. "," .. coorY1[arr[i]] + j)
            end
        end
    end
    return fill
end

-- there is more elegant solution, but I don't care right now xD
local function fillDiagramHor(arr, coorY, coorX1, coorX2)
    local fill = {}
    for i = 1, #arr do
        table.insert(fill, coorX1[arr[i]] .. "," .. coorY[arr[i]])
        local max = math.max(coorX1[arr[i]], coorX2[arr[i]])
        if max == coorX1[arr[i]] then
            local div = coorX1[arr[i]] - coorX2[arr[i]]
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] - j .. "," .. coorY[arr[i]])
            end
        elseif max == coorX2[arr[i]] then
            local div = coorX2[arr[i]] - coorX1[arr[i]]
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] + j .. "," .. coorY[arr[i]])
            end
        end
    end
    return fill
end

local diagramVert = fillDiagramVert(vertical, x1, y1, y2)
local diagramHor = fillDiagramHor(horizontal, y1, x1, x2)

local finalArray = aoc.mergeTwoArrays(diagramVert, diagramHor)

local function findCross(arr)
    local count = {}
    local result = 0
    for _, str in ipairs(arr) do
        if not count[str] then
            count[str] = 1
        else
            count[str] = count[str] + 1
            if count[str] == 2 then
                result = result + 1
            end
        end
    end
    return result
end

local resultPartOne = findCross(finalArray)
print("Part One\nResult: " .. resultPartOne)

-- Part two
local function findDiagonalVent315(x1, x2, y1, y2)
    local result = {}
    for i = 1, #x1 do
        -- first case
        if (x1[i] - y1[i]) == (x2[i] - y2[i]) then
            -- print(x1[i] .. "," .. y1[i] .. "->" .. x2[i] .. "," .. y2[i])
            table.insert(result, i)
        end
    end
    return result
end

local function findDiagonalVent45(x1, x2, y1, y2)
    local result = {}
    for i = 1, #x1 do
        -- first case
        if (x1[i] - y2[i]) == (x2[i] - y1[i]) then
            -- print(x1[i] .. "," .. y1[i] .. "->" .. x2[i] .. "," .. y2[i])
            table.insert(result, i)
        end
    end
    return result
end

local vent315 = findDiagonalVent315(x1, x2, y1, y2)
-- print("Indexes of 315 vent: " .. table.concat(vent315, ", "))

local vent45 = findDiagonalVent45(x1, x2, y1, y2)
-- print("Indexes of 315 vent: " .. table.concat(vent45, ", "))

local function fillDiagramDiagonal315(arr, coorX1, coorX2, coorY1)
    local fill = {}
    for i = 1, #arr do
        table.insert(fill, coorX1[arr[i]] .. "," .. coorY1[arr[i]])
        -- print(coorX1[arr[i]] .. "," .. coorY1[arr[i]])
        local div = coorX1[arr[i]] - coorX2[arr[i]]
        if div > 0 then
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] - j .. "," .. coorY1[arr[i]] - j)
            end
        else
            div = math.abs(div)
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] + j .. "," .. coorY1[arr[i]] + j)
            end
        end
    end
    return fill
end

local function fillDiagramDiagonal45(arr, coorX1, coorX2, coorY1)
    local fill = {}
    for i = 1, #arr do
        table.insert(fill, coorX1[arr[i]] .. "," .. coorY1[arr[i]])
        -- print(coorX1[arr[i]] .. "," .. coorY1[arr[i]])
        local div = coorX1[arr[i]] - coorX2[arr[i]]
        if div > 0 then
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] - j .. "," .. coorY1[arr[i]] + j)
            end
        else
            div = math.abs(div)
            for j = 1, div do
                table.insert(fill, coorX1[arr[i]] + j .. "," .. coorY1[arr[i]] - j)
            end
        end
    end
    return fill
end

local diagramDiagonal315 = fillDiagramDiagonal315(vent315, x1, x2, y1)
-- print("Vent 315 coordinates:\n" .. table.concat(diagramDiagonal315, "\n"))
local diagramDiagonal45 = fillDiagramDiagonal45(vent45, x1, x2, y1)
-- print("Vent 45 coordinates:\n" .. table.concat(diagramDiagonal45, "\n"))
local diagonalAllCoordinates = aoc.mergeTwoArrays(diagramDiagonal45, diagramDiagonal315)
local finalPartTwo = aoc.mergeTwoArrays(diagonalAllCoordinates, finalArray)
-- print(table.concat(finalPartTwo, "\n"))
local resultPartTwo = findCross(finalPartTwo)
print("Part two: " .. resultPartTwo)
