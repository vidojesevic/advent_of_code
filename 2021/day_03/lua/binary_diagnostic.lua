-- Day 3: Binary Diagnostic --

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

local file = aoc.fileRead('../input.txt')
-- local file = aoc.fileRead('../test.txt')

local diagnosticTable = aoc.extractMesurmentsInTable(file)

-- calculate gamma rate | most common bit in byte
local function extractOneBit(tableString, num)
    local zero, one = 0, 0
    for i = 1, #tableString do
        if string.sub(tableString[i], num, num) == '0' then
            zero = zero + 1
        elseif string.sub(tableString[i], num, num) == '1' then
            one = one + 1
        end
    end
    if one > zero then
        return '1'
    else
        return '0'
    end
end

local function calculateGamma(tableString)
    local result = ''
    for j = 1, string.len(tableString[1]) do
        result = result .. extractOneBit(tableString, j)
    end
    return result
end

local gamma = calculateGamma(diagnosticTable)
print("******* | Part One | *******")
print("Binary value of gamma is " .. gamma .. ", and int value is " .. tonumber(gamma, 2))

-- calculate epsilon | opposite of gamma
local function calculateEpsilon(value)
    local result = ''
    for i = 1, string.len(value) do
        if string.sub(value, i, i) == '0' then
            result = result .. '1'
        else
            result = result .. '0'
        end
    end
    return result
end

local epsilon = calculateEpsilon(gamma)
print("Binary value of epsilon is " .. epsilon .. ", and int value is " .. tonumber(epsilon, 2))

local fullDiagnostic = tonumber(gamma, 2) * tonumber(epsilon, 2)
print("Power consuption of submarine is " .. fullDiagnostic)

-- Part two
-- Oxygen

local function calculateOxygen(tableStr, num)
    local ones = {}
    local zeros = {}
    local zero, one = 0, 0
    for i = 1, #tableStr do
        if string.sub(tableStr[i], num, num) == '0' then
            zero = zero + 1
            table.insert(zeros, tableStr[i])
        else
            one = one + 1
            table.insert(ones, tableStr[i])
        end
    end
    if one == zero then
        return ones
    elseif one > zero then
        return ones
    elseif zero > one then
        return zeros
    end
end

local function diagnosticOxygen(tableStr)
    local num = 1
    local temp = calculateOxygen(tableStr, num)
    while #temp > 1 do
        num = num + 1
        temp = calculateOxygen(temp, num)
    end
    return temp[1]
end

local finalOxy = diagnosticOxygen(diagnosticTable)
print("******* | Part Two | *******")
print("Binary value of oxygen is " .. finalOxy .. ", and int value is " .. tonumber(finalOxy, 2))

local function calculateCO2(tableStr, num)
    local ones = {}
    local zeros = {}
    local zero, one = 0, 0
    for i = 1, #tableStr do
        if string.sub(tableStr[i], num, num) == '0' then
            zero = zero + 1
            table.insert(zeros, tableStr[i])
        else
            one = one + 1
            table.insert(ones, tableStr[i])
        end
    end
    if one == zero then
        return zeros
    elseif one > zero then
        return zeros
    elseif zero > one then
        return ones
    end
end

local function diagnosticCO2(tableStr)
    local num = 1
    local temp = calculateCO2(tableStr, num)
    while #temp > 1 do
        num = num + 1
        temp = calculateCO2(temp, num)
    end
    return temp[1]
end

local finalCO2 = diagnosticCO2(diagnosticTable)
print("Binary value of oxygen is " .. finalCO2 .. ", and int value is " .. tonumber(finalCO2, 2))
local lifeSupport = tonumber(finalOxy, 2) * tonumber(finalCO2, 2)
print("Life support rating of the submarine is " .. lifeSupport)
