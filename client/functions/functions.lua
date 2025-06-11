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
    -- if PrepareMusicEvent("AW_LOBBY_MUSIC_START") then
    PrepareMusicEvent("AW_LOBBY_MUSIC_START")
    TriggerMusicEvent("AW_LOBBY_MUSIC_START")
    -- end
end

-- This seems to stop the music.
function Music.Stop()
    TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START")
end

------------
--- Vehicle functions
------------

-- Copied from car_test.lua in kc_test.
function Vehicle.UpgradeMax()
    local player = PlayerPedId()
    local currentVeh = GetVehiclePedIsIn(player, false)

    -- Should the vehicle be repaired?
    local repairVehicle = true

    -- If the spoiler and a bunch of other mods will be applied
    local extraVehicleMods = true

    -- If the livery will be upgraded
    local upgradeLivery = false


    -- if currentVeh ~= 0 or currentVeh ~= nil then
    if DoesEntityExist(currentVeh) then
        -- First, repair the vehicle
        if repairVehicle then
            SetVehicleFixed(currentVeh)
            SetVehicleBodyHealth(currentVeh, 1000.0)
            SetVehicleEngineHealth(currentVeh, 1000.0)
            SetVehiclePetrolTankHealth(currentVeh, 1000.0)
        end

        -- Not sure if this is needed now.
        -- if IsThisModelACar(currentVeh) then
        --     for i = 1, 3 do
        --         SetVehicleWheelHealth(currentVeh, i, 1000)
        --     end
        -- end

        -- TODO Move these out of this command, possibly up top of this file, I could reuse them in another file.
        -- Max vehicle upgrades, at least the essential ones.
        -- local maxEngine = GetNumVehicleMods(vehicle, 11) - 1
        local maxArmor = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_ARMOUR) - 1
        local maxEngine = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_ENGINE) - 1
        local maxBrakes = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_BRAKES) - 1
        local maxTransmission = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_GEARBOX) - 1

        -- Here are some extra vehicle mods
        local maxSpoiler = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_SPOILER) - 1
        local maxFrontBumper = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_BUMPER_F) - 1
        local maxRearBumper = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_BUMPER_R) - 1


        local maxExhaust = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_EXHAUST) - 1
        local maxGrill = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_GRILL) - 1
        local maxRoof = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_ROOF) - 1
        local maxSkirt = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_SKIRT) - 1

        -- local maxLivery = GetVehicleLiveryCount(currentVeh)
        -- https://forum.cfx.re/t/setvehiclelivery-not-working-even-when-setting-setvehiclemodkit-to-0/1584813/2
        local maxLivery = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_LIVERY_MOD) - 1
        -- print("Max livery: " .. maxLivery)

        -- Vehicle mods
        -- Armor
        SetVehicleMod(currentVeh, eVehicleModType.VMT_ARMOUR, maxArmor, false)

        -- Engine
        SetVehicleMod(currentVeh, eVehicleModType.VMT_ENGINE, maxEngine, false)

        -- Brakes
        SetVehicleMod(currentVeh, eVehicleModType.VMT_BRAKES, maxBrakes, false)

        -- Transmission
        SetVehicleMod(currentVeh, eVehicleModType.VMT_GEARBOX, maxTransmission, false)

        -- Extra mods
        if extraVehicleMods then
            -- Spoiler
            SetVehicleMod(currentVeh, eVehicleModType.VMT_SPOILER, maxSpoiler, false)

            -- Rear bumper
            SetVehicleMod(currentVeh, eVehicleModType.VMT_BUMPER_F, maxFrontBumper, false)

            -- Front bumper
            SetVehicleMod(currentVeh, eVehicleModType.VMT_BUMPER_R, maxRearBumper, false)

            -- Exhaust
            SetVehicleMod(currentVeh, eVehicleModType.VMT_EXHAUST, maxExhaust, false)

            -- Grill
            SetVehicleMod(currentVeh, eVehicleModType.VMT_GRILL, maxGrill, false)

            -- Roof
            SetVehicleMod(currentVeh, eVehicleModType.VMT_ROOF, maxRoof, false)

            -- Skirt
            SetVehicleMod(currentVeh, eVehicleModType.VMT_SKIRT, maxSkirt, false)

            -- Xenon Lights
            -- TODO Configure this one.
            -- SetVehicleMod(currentVeh, eVehicleModType.VMT_XENON_LIGHTS, 1, false)
        end


        -- This works! Now requires to be active above.
        if upgradeLivery then
            SetVehicleMod(currentVeh, eVehicleModType.VMT_LIVERY_MOD, maxLivery, false)
        end


        -- if maxLivery ~= 0 then
        --     SetVehicleLivery(currentVeh, maxLivery)
        -- end
        --

        -- Turbo and bullet proof tires
        ToggleVehicleMod(currentVeh, eVehicleModType.VMT_TURBO, true)
        SetVehicleTyresCanBurst(currentVeh, false)

        exports.kc_util:Notify("Current vehicle ~b~upgraded~w~!")
        lib.notify(
        {
            title = "Current vehicle upgraded!",
            description = 'Added all upgrades to your vehicle.',
            type = 'success'
        }
    )
    else
        lib.notify(
        {
            title = "Vehicle required for action!",
            description = 'You are not in a vehicle',
            type = 'error'
        }
    )
    end
end

--

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
