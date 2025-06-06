---@diagnostic disable: duplicate-set-field


-- Positions = {}

Music = {}
Vehicle = {}
Player = {}
Text = {}
World = {}

Teleports = {}

------------
--- Teleport functions
------------

-- TODO Move these into kc_util and make these resources depend on it.

-- Taken from functions.lua in kc_menu
--- This now teleports the players vehicle if they are in one.
--- https://forum.cfx.re/t/esx-want-to-teleport-player-with-his-vehicle/4880346
--- Teleport with a fade
---@param x any
---@param y any
---@param z any
---@param heading any
function Teleports.TeleportFade(x, y, z, heading)
    local player = GetPlayerPed(-1)
    local fadeInTime = 500
    local fadeOutTime = 500

    DoScreenFadeOut(fadeOutTime)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    -- This now teleports the players vehicle if they are in one.
    if IsPedInAnyVehicle(player, false) then
        local currentVeh = GetVehiclePedIsIn(player, false)
        SetEntityCoords(currentVeh, x, y, z, false, false, false, false)
        SetEntityHeading(currentVeh, heading)
    else
        SetEntityCoords(player, x, y, z, false, false, false, false)
        SetEntityHeading(player, heading)
    end

    Wait(fadeInTime)
    DoScreenFadeIn(fadeInTime)
end

------------
--- Music functions
------------

-- function PlayMusicEvent(musicEvent)
function Music.Play(musicEvent)
    PrepareMusicEvent(musicEvent)
    TriggerMusicEvent(musicEvent)
end

function Music.PlayArenaWarTheme()
    if PrepareMusicEvent("AW_LOBBY_MUSIC_START") then
        TriggerMusicEvent("AW_LOBBY_MUSIC_START")
    end
end

-- This seems to stop the music.
function Music.Stop()
    TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START")
end

------------
--- Vehicle functions
------------

-- Copied from vehicle_functions.lua in kc_menu.

local vehicle = 0

-- Spawn vehicle at a set coords with a heading, and optionally, clear the area around it.
-- function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r1, g1, b1)
function Vehicle.Create(vehicleName, x, y, z, heading, clearArea)
    local player = GetPlayerPed(-1)
    local vehicleHash = GetHashKey(vehicleName)

    -- Disable tire burst here
    local tiresBurstDisabled = true

    -- Check if the vehicle actually exists
    -- if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
    -- if not IsModelInCdimage(vehicleName) then
    if not IsModelInCdimage(vehicleHash) then
        print("Model doesn't exist")
        return
    end
    
    -- if not IsModelAVehicle(vehicleName) then
    if not IsModelAVehicle(vehicleHash) then
        return
    end

    -- if vehicle == 0 then

    -- First, check if the player is in a vehicle
    if not IsPedInAnyVehicle(player, false) then

    
    -- Remove the old vehicle
        if DoesEntityExist(vehicle) then
            SetVehicleAsNoLongerNeeded(vehicle)
            DeleteVehicle(vehicle)
        end

        -- First, clear the area if toggled on.
        if clearArea then
            -- World.ClearVehiclesInArea(playerX, playerY, playerZ, 25.0)
            -- World.ClearVehiclesInArea(x, y, z, 25.0)
            World.ClearArea(x, y, z, 25.0)
        end

        -- Load the model
        RequestModel(vehicleName)
        -- RequestModel(vehicleHash)

        -- If model hasn't loaded, wait on it.
        -- while not HasModelLoaded(vehicleName) do
        while not HasModelLoaded(vehicleHash) do
            Wait(500)
        end

        -- SetEntityAsNoLongerNeeded(car)



        -- These color options don't seem to work.

        -- Car color test
        -- local carColorPrimary = colors.classic["Carbon Black"]
        -- local carColorSecondary = colors.classic["Lava Red"]
        -- SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)

        -- local vehicleNew = CreateVehicle(vehicleName, x, y, z, heading, true, false)
        vehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
        -- SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
        -- SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

        -- Make it to where the tires cannot be popped.
        if tiresBurstDisabled then
            SetVehicleTyresCanBurst(vehicleNew, false)
        end

        -- https://forum.cfx.re/t/setvehiclemod-is-not-working/1129056
        -- SetVehicleMod: https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
        -- This seems to be needed to set the vehicle mods.
        -- SetVehicleModKit(vehicleNew, 0)

        -- Test function, give vehicle all upgrades
        -- setVehicleMaxUpgrades(vehicleNew)

        SetModelAsNoLongerNeeded(vehicleHash)
    -- else
        -- if DoesEntityExist(vehicle) then
            -- SetVehicleAsNoLongerNeeded(vehicle)
            -- DeleteVehicle(vehicle)
        -- end

        -- vehicle = 0
    -- end

    else
        Text.Notify("Exit your vehicle first!")
    end
end

-- TODO Set these up
-- function Vehicle.SetColor()

-- end

--

------------
-- Player functions
------------

-- TODO Test these.

---comment Get the player position
---@return vector3 A vector3 of the players position
function Player.Coords()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    return playerPos
end

function Player.Heading()
    local player = GetPlayerPed(-1)
    local playerHeading = GetEntityHeading(player)

    return playerHeading
end

------------
-- Message/Notifcation functions
------------

-- function sendMessage(msg)
function Text.SendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

-- function notify(msg)
function Text.Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

------------
-- Math functions
------------



-- https://www.reddit.com/r/Stormworks/comments/srlkyq/lua_decimal_point/
-- This works for stripping the extra digits from the coords
function Truncate(number, decdigits)
    number = number * (10 ^ decdigits)
    number = math.floor(number)
    number = number / (10 ^ decdigits)

    return number
end

------------
--- World functions
------------

function World.ClearArea(x, y, z, radius)
    ClearArea(x, y, z, radius, true, false, false, false)
end

---
---
function World.ClearVehiclesInArea(x, y, z, radius)
    ClearAreaOfVehicles(x, y, z, radius, false, false, false, false, false)
end
