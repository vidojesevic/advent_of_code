-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 03   --
-- = = = = = = = = = = = == = = --

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

-- local file = aoc.fileRead('../test.txt')
-- local file = aoc.fileRead('../test1.txt')
local file = aoc.fileRead('../input.txt')

local lines = aoc.explode("\n", file)

local function isSymbol(char)
    local dot = "^[!@#%$%^&*()%+=_-]+$"
    if char ~= nil and string.match(char, dot) then
        return true
    end
    return false
end


local function isValid(array, i, index)
    -- print("Line: "..i.." Indexes: " .. table.concat(index, ", "))
    for _, ind in ipairs(index) do
        -- local current = array[i]:sub(ind, ind)
        local next = array[i]:sub(ind + 1, ind + 1)
        local prev = array[i]:sub(ind - 1, ind - 1)
        local up, down, bottomRight, bottomLeft, upperRight, upperLeft

        if i - 1 >= 1 then
            up = array[i - 1]:sub(ind, ind)
            if ind - 1 >= 1 then
                upperLeft = array[i - 1]:sub(ind - 1, ind - 1)
            end
            if ind + 1 <= #array[ind] then
                upperRight = array[i - 1]:sub(ind + 1, ind + 1)
            end
        end
        if i + 1 <= #array then
            down = array[i + 1]:sub(ind, ind)
            if ind - 1 >= 1 then
                bottomLeft = array[i + 1]:sub(ind - 1, ind - 1)
            end
            if ind + 1 <= #array[i] then
                bottomRight = array[i + 1]:sub(ind + 1, ind + 1)
            end
        end

        -- right
        if next and not tonumber(next) and isSymbol(next) then
            -- print("Found right!")
            return true
        end
        -- left
        if prev and not tonumber(prev) and isSymbol(prev) then
            -- print("Found left!")
            return true
        end
        -- up
        if up and not tonumber(up) and isSymbol(up) then
            -- print("Found up!")
            return true
        end
        -- down
        if down and not tonumber(down) and isSymbol(down) then
            -- print("Found down!")
            return true
        end
        -- bottom right
        if bottomRight and not tonumber(bottomRight) and isSymbol(bottomRight) then
            -- print("Found BOTTOM right!")
            return true
        end
        -- bottom left
        if bottomLeft and not tonumber(bottomLeft) and isSymbol(bottomLeft) then
            -- print("Found BOTTOM left!")
            return true
        end
        -- upper right
        if upperRight and not tonumber(upperRight) and isSymbol(upperRight) then
            -- print("Found BOTTOM right!")
            return true
        end
        -- upper left
        if upperLeft and not tonumber(upperLeft) and isSymbol(upperLeft) then
            -- print("Found BOTTOM left! Char: " .. upperLeft)
            return true
        end
    end
    return false
end

local function findNumber(array)
    local count = 0
    local nums = {}
    for i = 1, #array do
        local checker = {}
        local temp = ""
        local indexes = {}
        for j = 1, #array[i] do
            local char = array[i]:sub(j, j)
            -- print("Char: " .. char)
            if tonumber(char, 10) then
                -- one digit
                if temp == "" and not checker[j] then
                    temp = char
                    checker[j] = true
                    table.insert(indexes, j)
                end
                local next = array[i]:sub(j + 1, j + 1)
                if not tonumber(next, 10) then
                    -- print("One digit")
                    table.insert(nums, temp)
                    local valid = isValid(array, i, indexes)
                    if valid then
                        table.insert(nums, temp)
                        count = count + tonumber(temp)
                    end
                    temp = ""
                    indexes = {}
                end

                -- two digit
                if tonumber(next, 10) and not checker[j + 1] then
                    checker[j + 1] = true
                    temp = temp .. next
                    table.insert(indexes, j + 1)
                end
                local third = array[i]:sub(j + 2, j + 2)
                if tonumber(third, 10) == nil and #indexes ~= 0 then
                    local valid = isValid(array, i, indexes)
                    if valid then
                        table.insert(nums, temp)
                        count = count + tonumber(temp)
                    end
                    temp = ""
                    indexes = {}
                end

                -- three digit
                if tonumber(third, 10) and not checker[j + 2] then
                    checker[j + 2] = true
                    temp = temp .. third
                    table.insert(indexes, j + 2)
                end

                local forth = array[i]:sub(j + 3, j + 3)
                if not tonumber(forth, 10) then
                    table.insert(nums, temp)
                    local valid = isValid(array, i, indexes)
                    if valid then
                        table.insert(nums, temp)
                        count = count + tonumber(temp)
                    end
                    temp = ""
                    indexes = {}
                end
            end
        end
        indexes = {}
    end
    -- print(table.concat(nums, " "))
    return count
end

local result = findNumber(lines)
print("Result of part one: " .. result)
