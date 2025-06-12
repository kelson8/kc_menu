-- Credit to BerkieBb on GitHub for some of these ideas for the teleports

local vehNetId = 0

--- TODO Move this somewhere else.
--- Check if a vehicle exists and a player is in one.
---@param vehicle any Vehicle to check
---@return boolean If the vehicle exists and the player is in a vehicle.
local function DoesVehicleExist(vehicle)
    if vehicle ~= 0 or vehicle ~= nil and IsPedInAnyVehicle(PlayerPedId(), false) then
        return true
    end

    return false
end

function CreateLobbyMenu()
    lib.registerMenu({
        id = 'lobby_menu',
        title = 'Lobby List',
        position = Config.MenuPosition,

        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'kcnet_menu')
        end,

        onSelected = function(selected, secondary, args)
        end,

        onCheck = function(selected, checked, args)
            -- print("Check: ", selected, checked, args)
        end,

        options = {
            { label = 'Hub',           description = 'Set you to the hub lobby with other players',   args = { 'set_hub_lobby' } },
            { label = 'No population', description = 'Set you to the no vehicles and no peds lobby.', args = { 'set_no_population_lobby' } },
        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        -- Extras
        local player = PlayerPedId()
        local currentVeh = GetVehiclePedIsIn(player, false)

        if DoesVehicleExist(currentVeh) then
            vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)
        end
        --

        if args[1] == 'set_hub_lobby' then
            TriggerServerEvent('oxlib_test:server:setHub')

            if vehNetId ~= nil or vehNetId ~= 0 then
                TriggerServerEvent('oxlib_test:server:setVehicleLobby', vehNetId)
            end
        elseif args[1] == 'set_no_population_lobby' then
            TriggerServerEvent('oxlib_test:server:setNoPopulation')

            if vehNetId ~= nil or vehNetId ~= 0 then
                TriggerServerEvent('oxlib_test:server:setVehicleNoPopulation', vehNetId)
            end
        end
    end
    )
end

-----
-- Lobby context menu
-- For use in marker test, I will be making the usage of lobby switching in the menu an admin feature.
-- Players can go to a teleport location to switch between no population lobby and hub.
-- I may even add a no pvp lobby and a pvp lobby, and disable god mode in vMenu for other players.
-----
lib.registerContext({
    id = 'lobby_context_menu',
    title = 'Lobby Menu',
    menu = 'lobby_context_menu',
    options = {
        {
            title = 'Hub',
            description = 'Set you to the hub lobby with other players',
            onSelect = function()
                TriggerServerEvent('oxlib_test:server:setHub')
            end
        },

        {
            title = 'No Population',
            description = 'Set you to the no vehicles and no peds lobby.',
            onSelect = function()
                TriggerServerEvent('oxlib_test:server:setNoPopulation')
            end
        },
    }
})
