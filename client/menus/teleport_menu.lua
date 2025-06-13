-- Credit to BerkieBb on GitHub for some of these ideas for the teleports

local locations = {}

local function refreshLocations()
    local newLocations = lib.callback.await('kc_menu:server:getConfig', false, 'locations')

    if newLocations and type(newLocations) == 'table' then
        for i = 1, #newLocations do
            locations[i] = newLocations[i]
        end
    end
end

-- Most of this teleport menu came from bMenu here
-- https://github.com/BerkieBb/bMenu/blob/main/client/menus/misc/teleport.lua
local function CreateSavedTeleportMenu()
    refreshLocations()

    -- I got the teleports setup to save to the file now.
    local menuOptions = {}
    for i = 1, #locations do
        menuOptions[i] = {label = locations[i].name, args = locations[i], close = false}
    end

    lib.registerMenu({
        id = 'saved_teleports',
        title = 'Saved Teleports',
        position = Config.MenuPosition,

        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'teleport_options')
        end,

        onSelected = function(selected, secondary, args)

        end,

        onCheck = function(selected, checked, args)
            -- print("Check: ", selected, checked, args)
        end,

        options = menuOptions

    }, function(_, _, args)
        SetEntityCoords(PlayerPedId(), args.coords.x, args.coords.y, args.coords.z, true, false, false, false)
        SetEntityHeading(PlayerPedId(), args.heading)

        -- TODO setup vehicle teleport for my system.
        -- Hmm, cache.vehicle and cache.ped might work, I guess it is ox_lib and not custom for bMenu
        -- https://overextended.dev/ox_lib/Modules/Cache/Client
        -- SetEntityCoords(currentVeh, args.coords.x, args.coords.y, args.coords.z, true, false, false, false)
        -- SetEntityHeading(currentVeh, args.heading)

        lib.notify({
            description = ('Successfully teleported to %s'):format(args.name),
            type = 'success'
            })
    end
    )
end

function CreateTeleportMenu()
    lib.registerMenu({
        id = 'teleport_options',
        title = 'Teleport Options',
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
            { label = 'Saved locations', description = 'View saved teleport locations', args = { 'saved_locations_menu' } },
            { label = 'Save location', description = 'Save current location', args = { 'save_current_location' } },
            { label = 'Refresh Saved locations', description = 'Refresh current saved locations', args = { 'refresh_saved_locations' } },
        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'saved_locations_menu' then
            CreateSavedTeleportMenu()
            lib.showMenu('saved_teleports')

        elseif args[1] == 'save_current_location' then

        -- Recreated from bMenu
        elseif args[1] == 'save_current_location' then
            local dialog = lib.inputDialog('Save Location', {'Location Name'})

            if not dialog or not dialog[1] or dialog[1] == '' then
                Wait(200)
                lib.showMenu('saved_teleports')
                return
            end

            local result, notification = lib.callback.await('kc_menu:server:saveTeleportLocation', false, dialog[1])

            lib.notify({
                description = notification,
                type = result and 'success' or 'error'
            })

            refreshLocations()
            CreateTeleportMenu()

            Wait(200)
            lib.showMenu('saved_teleports')

            -- TODO Fix this part to work, if a location is removed.
        -- elseif args[1] == "refresh_saved_locations" then
        --     refreshLocations()
        --     Wait(200)
        --     lib.showMenu('saved_teleports')
        end
    end
    )
end