fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- This requires my ox_lib for testing.
-- In the future, this will also require kc_util from here: 
-- https://github.com/kelson8/fivem-scripts/tree/main/kc_util
dependencies {'ox_lib'}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'config/locations.lua',
    'config/doors_config.lua',
}

-- Oxlib testing

client_scripts {
    -- Locations
    'client/teleport_locations.lua',
    'client/test/marker_locations.lua',

    'client/enums.lua',
    -- Functions

    'client/functions/clothes.lua',
    'client/functions/doors.lua',
    'client/functions/functions.lua',
    'client/functions/menu.lua',

    'client/commands/test_commands.lua',
    'client/oxlib_command_test.lua',

    -- New tests

    -- Markers
    'client/test/marker_test.lua',

    -- New menu test in other file
    'client/menus/test_menu.lua',

    -- New menu test using menu instead of context menu

    'client/menus/camera_menu.lua',
    'client/menus/lobby_menu.lua',
    'client/menus/player_menu.lua',
    'client/menus/music_menu.lua',
    'client/menus/teleport_menu.lua',

    'client/menus/vehicle_menu.lua',

    'client/menus/new_menu.lua',


    -- Most menus are here.
    'client/oxlib_test.lua',
}

server_scripts {
    'server/functions/teleports.lua',
    'server/functions/doors.lua',

    'server/routing_buckets.lua',
}
