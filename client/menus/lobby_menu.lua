-- Credit to BerkieBb on GitHub for some of these ideas for the permissions

local vehNetId = 0
function CreateLobbyMenu()
    -- New
    -- TODO Setup permissions for this, I need to figure out how to set this in the server
    -- I got this working in admin_menu.lua
    -- 
    -- local perms = lib.callback.await('kc_menu:server:hasConvarPermission', false, 'Lobby', {'LobbyOptions'})

    -- local menuOptions = {
    --     {label = 'No access', description = 'You don\'t have access to any options, press enter to return', args = {'kcnet_menu'}}
    -- }

    -- local index = 1

    -- if perms.LobbyOptions then
    --     menuOptions[index] = {label = 'Lobby Options', args = {'lobby_menu'}}
    --     index += 1
    -- end

    --

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


        -- TODO Setup this, new permission system
        -- options = menuOptions

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
            TriggerServerEvent('kc_menu:server:setHub')

            if vehNetId ~= nil or vehNetId ~= 0 then
                TriggerServerEvent('kc_menu:server:setVehicleLobby', vehNetId)
            end
        elseif args[1] == 'set_no_population_lobby' then
            TriggerServerEvent('kc_menu:server:setNoPopulation')

            if vehNetId ~= nil or vehNetId ~= 0 then
                TriggerServerEvent('kc_menu:server:setVehicleNoPopulation', vehNetId)
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
-- TODO Refactor the vehicle part of this
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
                -- Extras
                local player = PlayerPedId()
                local currentVeh = GetVehiclePedIsIn(player, false)

                if DoesVehicleExist(currentVeh) then
                    vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)
                end
                --
                TriggerServerEvent('kc_menu:server:setHub')

                if vehNetId ~= nil or vehNetId ~= 0 then
                    TriggerServerEvent('kc_menu:server:setVehicleLobby', vehNetId)
                end
            end
        },

        {
            title = 'No Population',
            description = 'Set you to the no vehicles and no peds lobby.',
            onSelect = function()
                -- Extras
                local player = PlayerPedId()
                local currentVeh = GetVehiclePedIsIn(player, false)

                if DoesVehicleExist(currentVeh) then
                    vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)
                end
                --
                TriggerServerEvent('kc_menu:server:setNoPopulation')
            end
        },
    }
})
