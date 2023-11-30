-- Day 4: Giant Squid --

print("\\\\ Giant Squid Bingo //")
package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

local bingo = aoc.fileRead('../input.txt')
-- local bingo = aoc.fileRead('../test.txt')

-- extract numbers
local numbersStr = string.match(bingo, "([^\n]*)")

local function extractNumbers(numStr)
    local numbers = {}

    for number in numStr:gmatch("%d+") do
        table.insert(numbers, tonumber(number))
    end
    return numbers
end

local num = extractNumbers(numbersStr)
-- print("Bingo numbers: " .. table.concat(num, " "))
-- for i = 1, #num do
--     print(type(num[i]))
-- end

--extract lines
local function extractLines(numStr)
    local line = {}

    for number in numStr:gmatch("([^\n]*)\n") do
        table.insert(line, number)
    end
    return line
end

local lines = extractLines(bingo)
local function removeDrawNumAndEmptyItem(lineTable)
    -- remove Draw Numbers 
    table.remove(lineTable, 1)

    -- remove empty item
    for i = 1, #lines, 5 do
        if i <= #lines then
            table.remove(lineTable, i)
        end
    end

    return lineTable
end

lines = removeDrawNumAndEmptyItem(lines)
-- print(table.concat(lines, '\n'))
-- print(lines[1])
-- print("Lines length " .. #lines)

local function makeMatrix(lin)
    local matrices = {}
    local currentMatrix = {}
    local rowAdded = 0

    for _, line in ipairs(lin) do
        local row = {}
        for numb in line:gmatch("%d+") do
            table.insert(row, tonumber(numb))
        end
        table.insert(currentMatrix, row)
        rowAdded = rowAdded + 1

        if rowAdded == 5 then
            table.insert(matrices, currentMatrix)
            currentMatrix = {}
            rowAdded = 0
        end
    end
    return matrices
end

local matrix = makeMatrix(lines)

-- Checking if matrix are ok --
-- for i = 1, #matrix do
--     print("Matrix " .. i)
--     for j = 1, #matrix[i] do
--         print(table.concat(matrix[i][j], ' '))
        -- check for type
        -- for m = 1, #matrix[i][j] do
        --     print(type(matrix[i][j][m]))
        -- end
--     end
-- end

-- check individual player to test code for winner --
-- local indd = 75
-- print("Player number " .. indd)
-- for i = 1, #matrix[indd] do
--     print(table.concat(matrix[indd][i], ' '))
-- for j = 1, #matrix[indd][i] do
--     print(matrix[indd][i][j])
-- end
-- end

local function winByColumn(mat)
    -- win by column --
    for i = 1, #mat do
        local count = 0
        for j = 1, #mat[i] do
            -- print(mat)
            if mat[j][i] == 0 then
                count = count + 1
            end
            if count == 5 then
                return 1
            end
        end
    end
    return 0
end

local function winByRow(mat)
    local sum = 0
    for i = 1, #mat do
        for j = 1, #mat[i] do
            sum = sum + mat[i][j]
        end
        if sum == 0 then
            return 0
        end
    end
    return sum
end

local function checkIfPlayerAlreadyWon(winers, number)
    for i = 1, #winers do
        if winers[i] == number then
            return 1
        end
    end
    return 0
end

-- Game
local function playBingo(random, matrica)
    local game = 0
    local winner = {}
    local winnerBoard = {}
    for i = 1, #random do
        for j = 1, #matrica do
            for m = 1, #matrica[j] do
                for k = 1, #matrica[j][m] do
                    local row = matrica[j][m]

                    if random[i] == row[k] then
                        row[k] = 0
                    end
                end
                local column = winByColumn(matrica[j])
                if column == 1 then
                    game = random[i]
                    local check = checkIfPlayerAlreadyWon(winner, j)
                    if check == 0 then
                        table.insert(winner, j)
                        winnerBoard = matrica[j]
                    end
                    -- First winner
                    -- print("Ladies and gentleman, we have a winner")
                    -- return game, matrica[j]
                end

                -- win by row --
                local rowWin = winByRow(matrica[j])
                if rowWin == 0 then
                    game = random[i]
                    local check = checkIfPlayerAlreadyWon(winner, j)
                    if check == 0 then
                        table.insert(winner, j)
                        winnerBoard = matrica[j]
                    end
                    -- First winner
                    -- print("Ladies and gentleman, we have a winner")
                    -- return game, matrica[j]
                end
                if #winner == #matrica then
                    return winner[#winner], game, winnerBoard
                end
            end
        end
    end
end

-- First winner -- Part one

-- local game, winRow = playBingo(num, matrix)

-- Last winner - Part two

local player, game, winnerBoard = playBingo(num, matrix)
if game ~= 0 then
    print("Winning number is " .. game .. ", and last winner is " .. player)
else
    print("No winner found yet!")
end

local function calculateResult(winrow, winnum)
    local sum = 0
    for i = 1, #winrow do
        for j = 1, #winrow[i] do
            sum = sum + winrow[i][j]
        end
    end
    return sum * winnum
end

-- First
-- local result = calculateResult(winRow, game)
local result = calculateResult(winnerBoard, game)
print(result)

