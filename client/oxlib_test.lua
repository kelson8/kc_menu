-- https://forum.cfx.re/t/free-ox-lib-ui-and-common-code/4853434/6?page=2

-- Well this guide was for typescript
-- https://www.youtube.com/watch?v=J_sItOWqTEc

-- This one uses oxlib and makes some menus
-- https://www.youtube.com/watch?v=KaMmsXqYhbg

-- For keymapping: https://forum.cfx.re/t/how-to-advanced-registerkeymapping-with-nuifocus-in-true/4778790

-- lib.addRadialItem({
--     id = 'general:main',

-- })

-- I am drawing a basic menu using this.

-- Teleport locations




--

-- Draw a menu

lib.registerContext({
    id = 'main_menu',
    title = 'Main Menu',
    options = {
        -- {
        --     title = 'Button 1'
        -- },

        -- Disabled button
        -- {
        --     title = 'Disabled',
        --     description = 'This button is disabled',
        --     icon = 'phone',
        --     disabled = true,
        -- },

        -- Player menu
        {
            title = 'Player',
            icon = 'circle',
            menu = 'player_menu'
            -- onSelect = function()

            -- end
        },

        -- Teleport menu
        {
            title = 'Teleports',
            icon = 'circle',
            menu = 'teleport_menu'
        },

        -- Vehicle menu
        {
            title = 'Vehicle',
            icon = 'circle',
            menu = 'vehicle_menu'
        },

        -- Music menu
        {
            title = 'Music',
            icon = 'circle',
            menu = 'music_menu'
        },

        -- TODO Setup permissions for these.
        -- Test menu, in another file
        {
            title = 'Test',
            icon = 'circle',
            menu = 'test_menu'
        },



        -- Event
        -- {
        --     title = 'event',
        --     event = 'my_event',
        -- }
    }
})

-- Create the teleport menu
lib.registerContext({
    id = 'teleport_menu',
    title = 'Teleports',
    menu = 'main_menu',
    -- onBack = function()
    -- print('back')
    -- end,
    options = {
        {
            title = 'Airport',
            onSelect = function()
                Teleports.TeleportFade(positions.airportX, positions.airportY, positions.airportZ, positions.airportHeading)
            end
        },
        {
            title = 'Mount Chilliad',
            onSelect = function()
                Teleports.TeleportFade(positions.mountChilliadX, positions.mountChilliadY, positions.mountChilliadZ,
                    positions.mountChilliadHeading)
            end
        },

        {
            title = 'Cayo Perico Airstrip',
            onSelect = function ()
                Teleports.TeleportFade(positions.cayoAirstripX, positions.cayoAirstripY, positions.cayoAirstripZ,
                    positions.cayoAirstripHeading)
            end
        }
    }
})

-- Vehicle menu, almost complete.
-- Player.Coords()

local playerCoords = Player.Coords()
local playerHeading = Player.Heading()
local playerX = Truncate(playerCoords.x, 3) + 3
local playerY = Truncate(playerCoords.y, 3) + 3
local playerZ = Truncate(playerCoords.z, 3)

-- local input = lib.inputDialog('Basic dialog', {'First row', 'Second row'})

-- Default button to cancel progress bar is 'X'
function progressBar()
    if lib.progressBar({
        duration = 5000,
        label = 'Progress Bar',
        -- Cannot trigger if dead
        useWhileDead = false,
        canCancel = true,
        -- Disable these items
        disable = {

            -- Disallow using while in a vehicle
            car = true,
            -- Disallow while moving
            move = true,
            sprint = true,
        },
        anim = {
            dict = 'mp_player_intdrink',
            clip = 'loop_bottle',
        },
        prop = {
            model = 'prop_ld_flow_bottle',
            pos = vec3(0.03, 0.03, 0.02),
            rot = vec3(0.0, 0.0, -1.5),
        },
    }) then
        -- print("Done")
    else
        -- print("Cancelled")
    end
end

lib.registerContext({
    id = 'vehicle_menu',
    title = 'Vehicle',
    menu = 'main_menu',
    options = {


        {

            -- I got this working for a vehicle spawner with input.
            title = 'Select vehicle model',

            -- https://overextended.dev/ox_lib/Modules/Interface/Client/input
            onSelect = function()
                -- local input = lib.inputDialog('Basic dialog', {'First row', 'Second row'})
                local input = lib.inputDialog('Vehicle Model', { 'Input Model' })
                local vehicleModel = input[1]

                if not input then return end


                -- cheetah
                Vehicle.Create(vehicleModel, playerX, playerY, playerZ, playerHeading, true)
                print(json.encode(input), input[1], input[2])
            end
        },

        -- {
        --     -- lib.inputDialog("Test", 2),
        --     title = 'Spawn In Vehicle',
        --     -- checked = false,


        -- },

        {
            title = 'Spawn Cheetah',
            -- description = '.',
            onSelect = function()
                -- local playerHeading = Truncate(Player.Heading(), 3)
                -- local playerHeading = Player.Heading()
                Vehicle.Create("cheetah", playerX, playerY, playerZ, playerHeading, true)
            end
        },
    }
})

-- Music menu
lib.registerContext({
    id = 'music_menu',
    title = 'Music',
    menu = 'main_menu',
    options = {
        {
            title = 'Chase parachute',
            description = 'Play the CHASE_PARACHUTE_START music from the game.',
            onSelect = function()
                Music.Play("CHASE_PARACHUTE_START")
            end
        },

        -- PlayArenaWarTheme()
        {
            title = "Arena war",
            description = 'Play the arena war theme from GTA Online.',
            onSelect = function()
                Music.PlayArenaWarTheme()
            end
        },

        {
            title = 'Stop music',
            description = 'Stop the currently playing sound track.',
            onSelect = function()
                Music.Stop()
            end
        },
    }
})


-- Create the event
-- RegisterNetEvent('my_event', function()
--     lib.registerContext({
--         id = 'event_menu',
--         title = 'New Menu',
--         menu = 'main_menu',
--         options = {
--             {
--                 title = 'Event'
--             }
--         }
--     }
--     )
--     lib.showContext('event_menu')
-- end)





-- Moved to menus/new_menu.lua
-- RegisterKeyMapping("openmenu", "Open Menu", "keyboard", "F1")
-- I could possibly use this for an admin menu or something
-- RegisterKeyMapping("openmenu", "Open Menu", "keyboard", "F3")
-- -- Open the menu with the command.
-- RegisterCommand("openmenu", function()
--     lib.showContext('main_menu')
-- end, false)

RegisterCommand('progressbar', progressBar, false)
