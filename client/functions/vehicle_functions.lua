---@diagnostic disable: duplicate-set-field

Vehicle = {}

------------
--- Vehicle functions
------------

--- Upgrade the players car with the max upgrades
--- Copied from car_test.lua in kc_test.
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

        -- exports.kc_util:Notify("Current vehicle ~b~upgraded~w~!")
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

--- TODO Move this somewhere else.
--- Check if a vehicle exists and a player is in one.
---@param vehicleToCheck any Vehicle to check
---@return boolean If the vehicle exists and the player is in a vehicle.
function DoesVehicleExist(vehicleToCheck)
    if vehicleToCheck ~= 0 or vehicleToCheck ~= nil and IsPedInAnyVehicle(PlayerPedId(), false) then
        return true
    end

    return false
end

--