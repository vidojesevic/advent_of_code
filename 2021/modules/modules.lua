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
    local measurement = {}
    for line in file:gmatch("([^\n]+)") do
        table.insert(measurement, line)
    end
    return measurement
end

function aoc.convertTableOfNumberToString(tableNumber)
    local tableString = {}
    for i = 1, #tableNumber do
        table.insert(tableString, tostring(tableNumber[i]))
    end
    return tableString
end

return aoc
