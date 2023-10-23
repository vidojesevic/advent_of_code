-- Day 3: Binary Diagnostic --

package.path = package.path .. ";../../modules/modules.lua"
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
print("Gamma is " .. gamma .. ", and int value is " .. tonumber(gamma, 2))

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
print("Epsilon is " .. epsilon .. ", and int value is " .. tonumber(epsilon, 2))

local fullDiagnostic = tonumber(gamma, 2) * tonumber(epsilon, 2)
print("Power consuption of submarine is " .. fullDiagnostic)

-- Part two


