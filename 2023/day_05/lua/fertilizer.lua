-- = = = = = = = = = = = == = = --
--   Advent of Code || Day 05   --
-- = = = = = = = = = = = == = = --

package.path = package.path .. ";../../../modules/modules.lua"
local aoc = require("modules")

-- local file = aoc.fileRead('../test.txt')
local file = aoc.fileRead('../input.txt')

-- print(file)
local block = aoc.explode(":", file)
local seeds = block[2]
local seed_to_soil_map = block[3]
local soil_to_fertilizer_map = block[4]
local fertilizer_to_water_map = block[5]
local water_to_light_map = block[6]
local light_to_temperature_map = block[7]
local temperature_to_humidity_map = block[8]
local humidity_to_location_map = block[9]

local function extract_seeds_from_map(data)
    local map = {}
    local tabl = aoc.explode(" ", data)
    for _, v in ipairs(tabl) do
        if v ~= nil then
            local num = string.match(v, "%d+")
            if num ~= nil and tonumber(num, 10) then
                table.insert(map, num)
            end
        end
    end
    return map
end

local function extract_data_from_map(data)
    local map = {}
    local line = aoc.explode("\n", data)
    for _, v in ipairs(line) do
        local temp = aoc.explode(" ", v)
        for _, val in ipairs(temp) do
            if val ~= nil then
                local num = string.match(val, "%d+")
                if num ~= nil and tonumber(num, 10) then
                    table.insert(map, num)
                end
            end
        end
    end
    return map
end

-- Extracting data from string
seeds = extract_seeds_from_map(seeds)
seed_to_soil_map = extract_data_from_map(seed_to_soil_map)
-- print("Seed to soil: " .. table.concat(seed_to_soil_map, ", "))
soil_to_fertilizer_map = extract_data_from_map(soil_to_fertilizer_map)
-- print("Soil to fertilizer: " .. table.concat(soil_to_fertilizer_map, ", "))
fertilizer_to_water_map = extract_data_from_map(fertilizer_to_water_map)
-- print("Fertilizer to water: " .. table.concat(fertilizer_to_water_map, ", "))
water_to_light_map = extract_data_from_map(water_to_light_map)
-- print("Water to light: " .. table.concat(water_to_light_map, ", "))
light_to_temperature_map = extract_data_from_map(light_to_temperature_map)
-- print("Light to temperature: " .. table.concat(light_to_temperature_map, ", "))
temperature_to_humidity_map = extract_data_from_map(temperature_to_humidity_map)
-- print("Temperature to humidity: " .. table.concat(temperature_to_humidity_map, ", "))
humidity_to_location_map = extract_data_from_map(humidity_to_location_map)
-- print("Humidity to location: " .. table.concat(humidity_to_location_map, ", "))
--

print("advent of Code 2023\nDay 5: If You Give A Seed A Fertilizer")

local function make_map_from_data(from, map_val)
    local result = {}
    for n, v in ipairs(from) do
        if result[n] == nil then
            -- print("Inserted default on: " .. n)
            table.insert(result, n, from[n])
        end
        for i = 1, #map_val, 3 do
            if tonumber(v) > tonumber(map_val[i + 1]) and tonumber(v) < tonumber(map_val[i + 1]) + tonumber(map_val[i + 2]) then
                local index = tonumber(v) - map_val[i + 1]
                result[n] = map_val[i] + index
            end
        end
    end

    return result
end

-- print(table.concat(seeds, ", ") .. " -> seeds")
local soil = make_map_from_data(seeds, seed_to_soil_map)
-- print(table.concat(soil, ", ") .. " -> soil")
local fertilizer = make_map_from_data(soil, soil_to_fertilizer_map)
-- print(table.concat(fertilizer, ", ") .. " -> fertilizer")
local water = make_map_from_data(fertilizer, fertilizer_to_water_map)
-- print(table.concat(water, ", ") .. " -> water")
local light = make_map_from_data(water, water_to_light_map)
-- print(table.concat(light, ", ") .. " -> light")
local temperature = make_map_from_data(light, light_to_temperature_map)
-- print(table.concat(temperature, ", ") .. " -> temperature")
local humidity = make_map_from_data(temperature, temperature_to_humidity_map)
-- print(table.concat(humidity, ", ") .. " -> humidity")
local location = make_map_from_data(humidity, humidity_to_location_map)
-- print(table.concat(location, ", ") .. " -> location")

local function calculate_lowest(array)
    local low = array[1]
    for _, v in ipairs(array) do
        if tonumber(low) > tonumber(v) then
            low = v
        end
    end
    return low
end

-- local result = calculate_lowest(location)
-- print("Result of part one: " .. result)

-- Part Two

local function make_map_from_data2(from, map_val)
    local res = {}
    local nesto = ""
    for i = 1, #from, 2 do
        local start = tonumber(from[i])
        local range = tonumber(from[i + 1])
        print("start: " .. start .. ", range: " .. range)
        for j = 0, range do
            table.insert(res, start + j)
            print("current: " .. start + j)
            nesto = nesto .. start + j .. ", "
            for n = 1, #map_val, 3 do
                local finish = start + j + range - tonumber(map_val[n + 1])
                -- if finish ~= nil then
                --     print("Finish: " .. finish)
                -- end
                if finish >= 0 and start + j > tonumber(map_val[n + 1]) and start + j < tonumber(map_val[n + 1]) + tonumber(map_val[n + 2]) then
                    local index = start + j - map_val[n + 1]
                    res[#res] = map_val[n] + index
                    print("Found num on index: " .. j + 1)
                end
            end
        end
    end
    print(nesto .. " -> seeds")

    return res
end

-- seeds = make_new_seeds(seeds)
-- print("There is " .. #seeds .. " seeds now, OMG!")

-- print(table.concat(seeds, ", ") .. " -> seeds")
print(table.concat(seeds, ", ") .. " -> seeds")
soil = make_map_from_data2(seeds, seed_to_soil_map)
print(table.concat(soil, ", ") .. " -> soil")
fertilizer = make_map_from_data(soil, soil_to_fertilizer_map)
print(table.concat(fertilizer, ", ") .. " -> fertilizer")
water = make_map_from_data(fertilizer, fertilizer_to_water_map)
print(table.concat(water, ", ") .. " -> water")
light = make_map_from_data(water, water_to_light_map)
print(table.concat(light, ", ") .. " -> light")
temperature = make_map_from_data(light, light_to_temperature_map)
print(table.concat(temperature, ", ") .. " -> temperature")
humidity = make_map_from_data(temperature, temperature_to_humidity_map)
print(table.concat(humidity, ", ") .. " -> humidity")
location = make_map_from_data(humidity, humidity_to_location_map)
print(table.concat(location, ", ") .. " -> location")
-- for i = 1, #location do
--     print("Seed: " .. seeds[i] .. " soil: " .. soil[i] .. " fert: " .. fertilizer[i] .. " water: " .. water[i] .. " light: " .. light[i] .. " temp: " .. temperature[i] .. " location: " .. location[i])
-- end

-- local res = calculate_lowest({soil_low, fert_low, wate_low, light_low, temp_low, humidity_low, location_low})
local res = calculate_lowest(location)
print("Result of part two: " .. res)
