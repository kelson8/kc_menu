fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- This requires my ox_lib for testing.
-- In the future, this will also require kc_util from here: 
-- https://github.com/kelson8/fivem-scripts/tree/main/kc_util
dependencies {'ox_lib'}

shared_scripts {
    '@ox_lib/init.lua',
}

-- Oxlib testing

client_scripts {
    'client/teleport_locations.lua',
    'client/enums.lua',

    'client/functions.lua',
    'client/commands/test_commands.lua',
    'client/oxlib_command_test.lua',


    -- New tests

    -- Markers
    'client/test/marker_test.lua',

    -- New menu test in other file
    'client/menus/test_menu.lua',

    -- Most menus are here.
    'client/oxlib_test.lua',
}

-- server_scripts {
    -- 'server/oxlib_test.lua',
-- }
