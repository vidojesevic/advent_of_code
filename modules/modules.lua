_G.aoc = {}

function aoc.fileRead(path)
    local file = io.open(path, "r")
    local content
    if file ~= nil then
        content = file:read("*a")
        file:close()
    end
    return content
end

function aoc.lines(file)
    local lineCount = 0
    for _ in file:gmatch("\n") do
        lineCount = lineCount + 1
    end
    return lineCount
end

function aoc.extractMesurmentsInTable(file)
    local arr = {}
    for line in file:gmatch("([^\n]+)") do
        table.insert(arr, line)
    end
    return arr
end

function aoc.convertTableOfNumberToString(tableNumber)
    local tableString = {}
    for i = 1, #tableNumber do
        table.insert(tableString, tostring(tableNumber[i]))
    end
    return tableString
end

function aoc.explode(div, str) -- like php
    if div == '' then return false end
    local arr = {}
    local pattern = string.format("([^%s]+)", div)
    str:gsub(pattern, function(c) arr[#arr + 1] = c end)
    return arr
end

-- just in case if I need it
function aoc.mergeTwoArrays(arr1, arr2)
    local arr = {}
    local index1, index2 = 1, 1
    while index1 <= #arr1 and index2 <= #arr2 do
        if arr1[index1] < arr2[index2] then
            table.insert(arr, arr1[index1])
            index1 = index1 + 1
        else
            table.insert(arr, arr2[index2])
            index2 = index2 + 1
        end
    end
    table.move(arr1, index1, #arr1, #arr + 1, arr)
    table.move(arr2, index2, #arr2, #arr + 1, arr)
    return arr
end
--
-- function aoc.makeMatrix(arr)
--     local lines = aoc.explode("\n", arr)
--     local result = {}
--     for i = 1, #lines do
--         result[i] = aoc.explode("", lines)
--     end
--     return result
-- end

return aoc
