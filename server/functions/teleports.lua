-- Credit to BerkieBb on GitHub for this file
-- https://github.com/BerkieBb/bMenu/blob/main/server/teleports.lua

-- I have only modified it for my needs

--- This works for stripping the extra digits from the coordinates
--- https://www.reddit.com/r/Stormworks/comments/srlkyq/lua_decimal_point/
---@param number number The number to strip the digits from
---@param decdigits number The amount of digits to strip from the number
---@return number The truncated number, such as -1874.347290 to -1874.347
function Truncate(number, decdigits)
    number = number * (10 ^ decdigits)
    number = math.floor(number)
    number = number / (10 ^ decdigits)

    return number
end

--#region Callbacks

lib.callback.register('oxlib_test:server:saveTeleportLocation', function(source, teleportName)
    local file = {string.strtrim(LoadResourceFile('oxlib_test', 'config/locations.lua'))}

    if file then
        file[1] = file[1]:gsub('}$', '')

        local playerPed = GetPlayerPed(source)

        -- Truncate the coord values to make them have not as many decimal places.
        local playerCoords = GetEntityCoords(playerPed)
        local playerX = Truncate(playerCoords.x, 3)
        local playerY = Truncate(playerCoords.y, 3)
        local playerZ = Truncate(playerCoords.z, 3)
        local newPlayerCoords = vector3(playerX, playerY, playerZ)
        local newPlayerHeading = Truncate(GetEntityHeading(playerPed), 3)

        file[2] = [[

    {
        name = '%s',
        coords = %s,
        heading = %s
    },
]]

        -- file[2] = file[2]:format(teleportName, GetEntityCoords(playerPed), GetEntityHeading(playerPed))
        file[2] = file[2]:format(teleportName, newPlayerCoords, newPlayerHeading)

        file[3] = '}'

        SaveResourceFile('oxlib_test', 'config/locations.lua', table.concat(file), -1)

        return true, ('Successfully added location %s'):format(teleportName)
    end

    return false, 'Something went wrong with loading the locations file'
end)

lib.callback.register('oxlib_test:server:getConfig', function(_, fileName)
    local file = LoadResourceFile('oxlib_test', ('config/%s.lua'):format(fileName))
    if not file then return end

    local returnVal = load(file, ('@@oxlib_test/config/%s.lua'):format(fileName))
    if not returnVal then return end

    return returnVal()
end)

--#endregion Callbacks
