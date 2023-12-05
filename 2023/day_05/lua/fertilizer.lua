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
    for i, v in ipairs(line) do
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
        print("seed num: " .. n)
        for i = 1, #map_val, 3 do
            local dest_range = map_val[i]
            local source_range = map_val[i + 1]
            local len = map_val[i + 2]
            for j = 0, len - 1 do
                if tonumber(v) == source_range + j then
                    print("seed: " .. v .. ", soil: " .. dest_range + j)
                    table.insert(result, n, dest_range + j)
                end
            end
        end
        if result[n] == nil then
            print("seed: " .. from[n] .. ", soil: " .. from[n])
            table.insert(result, n, from[n])
        end
    end

    return result
end

print(table.concat(seeds, ", ") .. " -> seeds")
local soil = make_map_from_data(seeds, seed_to_soil_map)
print(table.concat(soil, ", ") .. " -> soil")
-- local fertilizer = make_map_from_data(soil, soil_to_fertilizer_map)
-- print(table.concat(fertilizer, ", ") .. " -> fertilizer")
-- local water = make_map_from_data(fertilizer, fertilizer_to_water_map)
-- print(table.concat(water, ", ") .. " -> water")
-- local light = make_map_from_data(water, water_to_light_map)
-- print(table.concat(light, ", ") .. " -> light")
-- local temperature = make_map_from_data(light, light_to_temperature_map)
-- print(table.concat(temperature, ", ") .. " -> temperature")
-- local humidity = make_map_from_data(temperature, temperature_to_humidity_map)
-- print(table.concat(humidity, ", ") .. " -> humidity")
-- local location = make_map_from_data(humidity, humidity_to_location_map)
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
