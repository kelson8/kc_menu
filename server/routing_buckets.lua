-- Taken some of this from my old menuV menu in server/routing_buckets.lua

-- File originally here: https://github.com/kelson8/fivem-scripts/blob/main/kc_menu/server/routing_buckets.lua

-- These are the current routing bucket IDs
-- The no population lobby can be switched to in my menu, which brings the player and their vehicle
-- into a routing bucket with no vehicles and no peds.
local lobbyBucket = 0
local noPopulationBucket = 10

-- TODO Convert these permissions from kc_menu to oxlib_test or just keep them for now.

-- https://forum.cfx.re/t/issues-with-ox-lib-notify/5227275

--- Basic function to display a no permission error on the players screen.
local function NoPermissionError()
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'No permission',
        description = 'You do not have permission for that action.',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'ban',
        iconColor = '#C53030'
    })
end

---------
-- Set player into hub lobby
-- TODO Add other player support to this.
---------
RegisterServerEvent("oxlib_test:server:setHub")
AddEventHandler("oxlib_test:server:setHub", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.hub") then
        SetPlayerRoutingBucket(source, lobbyBucket)

        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Sent to hub',
            description = 'You have been sent back to the main lobby, peds and vehicles now enabled.',
            icon = 'fa-circle-exclamation',
        })
    else
        NoPermissionError()
    end
end)



---------
-- Set player into no population lobby
-- TODO Add other player support to this.
---------
RegisterServerEvent("oxlib_test:server:setNoPopulation")
AddEventHandler("oxlib_test:server:setNoPopulation", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.set_no_population") then
        SetRoutingBucketPopulationEnabled(noPopulationBucket, false)

        SetPlayerRoutingBucket(source, noPopulationBucket)

        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Sent to no population lobby',
            description = 'You have been sent to the no population lobby.',
            icon = 'fa-circle-exclamation',
        })
    else
        NoPermissionError()
    end
end)

---------
-- Set vehicle no population test
-- I got this working by combining it with the other event, so it isn't in the same event.
---------
RegisterServerEvent("oxlib_test:server:setVehicleNoPopulation")
AddEventHandler("oxlib_test:server:setVehicleNoPopulation", function(vehNetId)
    if IsPlayerAceAllowed(source, "kc_menu.lobby.set_no_population") then
        SetRoutingBucketPopulationEnabled(noPopulationBucket, false)

        local currentVehicle = NetworkGetEntityFromNetworkId(vehNetId)

        if DoesEntityExist(currentVehicle) then
            SetEntityRoutingBucket(currentVehicle, noPopulationBucket)

            -- This one gets a bit annoying
            -- TriggerClientEvent('ox_lib:notify', source, {
            --     title = 'Vehicle Sent to no population lobby',
            --     description = 'Your vehicle has been sent to the no population lobby.',
            --     icon = 'fa-circle-exclamation',
            -- })
        end
    else

        -- NoPermissionError()
    end
end)


---------
-- Set vehicle back to hub
---------
RegisterServerEvent("oxlib_test:server:setVehicleLobby")
AddEventHandler("oxlib_test:server:setVehicleLobby", function(vehNetId)
    if IsPlayerAceAllowed(source, "kc_menu.lobby.hub") then
        SetRoutingBucketPopulationEnabled(noPopulationBucket, false)

        local currentVehicle = NetworkGetEntityFromNetworkId(vehNetId)

        if DoesEntityExist(currentVehicle) then
            SetEntityRoutingBucket(currentVehicle, lobbyBucket)

            -- This one gets a bit annoying
            -- TriggerClientEvent('ox_lib:notify', source, {
            --     title = 'Vehicle sent to main lobby',
            --     description = 'Your vehicle has been sent to the main lobby.',
            --     icon = 'fa-circle-exclamation',
            -- })
        end
    else
        -- NoPermissionError()
    end
end)

----------

-- I got this part to work, I had to get the network ID like I was doing in lobby_test.
-- Get current player routing bucket.
-- TODO Make this get the vehicles network id if a player is in one.
RegisterServerEvent("oxlib_test:server:getCurrentLobby")
AddEventHandler("oxlib_test:server:getCurrentLobby", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.get_lobby") then
        -- This requires the network of of the player.
        local netId = NetworkGetEntityFromNetworkId(source)

        -- TODO Set this up, if the player is in a vehicle this should return the network ID of it.
        -- TriggerClientEvent("instance:getCurrentVehicle", source)
        local currentRoutingBucket = GetEntityRoutingBucket(netId)

        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Routing Bucket',
            description = 'Current routing bucket: ' .. currentRoutingBucket,
            icon = 'fa-circle-exclamation',
        })
    else
        NoPermissionError()
    end
end)

-- This works now! I'm not sure how to adapt it to my menu for vehicles I am in though.
-- https://docs.fivem.net/docs/scripting-manual/networking/ids/
RegisterServerEvent("oxlib_test:server:getCurrentVehicleLobby")
AddEventHandler("kc_menu:getCurrentVehicleLobby", function()
    -- AddEventHandler("kc_menu:getCurrentVehicleLobby", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.get_lobby") then
        local playerName = GetPlayerName(source)
        -- This requires the network ID of the player.
        -- local netId = NetworkGetEntityFromNetworkId(source)

        -- local vehNetId = NetworkGetEntityFromNetworkId(currentVehicle)

        -- print(("%s's Current Vehicle: %s"):format(playerName, currentVehicle))

        -- I slightly changed this
        local vehNetId = NetworkGetEntityFromNetworkId(currentVehicle)
        -- if NetworkDoesEntityExistWithNetworkId(vehNetId) then
        -- end

        -- I figured this out!
        local currentVehRoutingBucket = GetEntityRoutingBucket(vehNetId)

        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Vehicle routing bucket',
            description = 'Current vehicle routing bucket: ' .. currentVehRoutingBucket,
            icon = 'fa-circle-exclamation',
        })
    else
        NoPermissionError()
    end
end)
