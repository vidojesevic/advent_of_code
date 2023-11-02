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

return aoc
