fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- This requires ox_lib for testing.
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

    -- Events
    'client/events/casino_events.lua',

    -- Markers
    'client/test/marker_test.lua',

    -- New menu test in other file
    'client/menus/test_menu.lua',

    -- New menu test using menu instead of context menu

    'client/menus/admin_menu.lua',
    'client/menus/camera_menu.lua',
    'client/menus/lobby_menu.lua',
    'client/menus/player_menu.lua',
    'client/menus/music_menu.lua',
    'client/menus/teleport_menu.lua',

    'client/menus/vehicle_menu.lua',

    -- TODO Rename this file to main_menu
    'client/menus/new_menu.lua',
    -- 'client/menus/main_menu.lua',


    -- Most menus are here.
    'client/kc_menu.lua',
}

server_scripts {
    'server/functions/players.lua',
    'server/functions/teleports.lua',
    'server/functions/doors.lua',

    'server/commands.lua',
    'server/routing_buckets.lua',

    -- New permission system from bMenu
    'server/main.lua',
}
