-- This works as a basic menu unlike the context menu
-- Not sure how to use it though.

-- https://coxdocs.dev/ox_lib/Modules/Interface/Client/menu

-- Here is a full menu example wiht ox_lib:
-- https://github.com/BerkieBb/bMenu

-- local menuPosition = 'top-left'

-- TODO Figure out permissions for the menus, so only admins can access certain ones such as the test one.

lib.registerMenu({
    id = 'kcnet_menu',
    title = 'KCNet Menu',
    -- position = 'top-right',
    position = Config.MenuPosition,

    onSideScroll = function(selected, scrollIndex, args)
        -- print("Scroll: ", selected, scrollIndex, args)
    end,

    onSelected = function(selected, secondary, args)
        if not secondary then
            -- print("Normal button")
        else
            if args.isCheck then
                -- print("Check button")
            end

            if args.isScroll then
                -- print("Scroll button")
            end
        end
        -- print(selected, secondary, json.encode(args, {indent=true}))
    end,

    onCheck = function(selected, checked, args)
        -- print("Check: ", selected, checked, args)
    end,
    onClose = function(keyPressed)
        -- print('Menu closed')
        if keyPressed then
            -- print(('Pressed %s to close the menu'):format(keyPressed))
        end
    end,

    options = {
        -- {label = 'Simple button', description = 'It has a description!'},
        -- {label = 'Checkbox button', checked = true},
        -- {label = 'Scroll button with icon', icon = 'arrows-up-down-left-right', values={'hello', 'there'}},
        -- {label = 'Button with args', args = {someArg = 'nice_button'}},
        -- {label = 'List button', values = {'You', 'can', 'side', 'scroll', 'this'}, description = 'It also has a description!'},
        -- {label = 'List button with default index', values = {'You', 'can', 'side', 'scroll', 'this'}, defaultIndex = 5},
        -- {label = 'List button with args', values = {'You', 'can', 'side', 'scroll', 'this'}, args = {someValue = 3, otherValue = 'value'}},

        { label = 'Player Options', args = { 'player_options' } },
        { label = 'Teleport Options', args = { 'teleport_options' } },
        { label = 'Vehicle Options', args = { 'vehicle_options' } },
        { label = 'Music Options', args = { 'music_options' } },
        { label = 'Camera Options', args = { 'camera_options' } },
        { label = 'Lobby Menu', args = { 'lobby_menu' } },

        -- TODO Set these up
        -- { label = 'Test Options', args = { 'test_options' } },

    }
}, function(selected, scrollIndex, args)
    if not args or not args[1] then return end

    -- I got this sub menu to work
    if args[1] == "player_options" then
        CreatePlayerMenu()
        lib.showMenu("player_options")

    elseif args[1] == "teleport_options" then
        CreateTeleportMenu()
        lib.showMenu("teleport_options")

    -- TODO Set these up
    -- elseif args[1] == "test_options" then
    --     CreateTestMenu()
    --     lib.showMenu("test_options")

    elseif args[1] == "vehicle_options" then
        CreateVehicleMenu()
        lib.showMenu("vehicle_options")

    elseif args[1] == "music_options" then
        CreateMusicMenu()
        lib.showMenu("music_options")

    elseif args[1] == "camera_options" then
        CreateCameraMenu()
        lib.showMenu("camera_options")

    elseif args[1] == "lobby_menu" then
        CreateLobbyMenu()
        lib.showMenu("lobby_menu")
    end


    -- print(selected, scrollIndex, args)
end)

-- TODO Rename this later
RegisterKeyMapping("testmenu", "Open Menu", "keyboard", Config.KeyBind)
-- -- Open the menu with the command.
RegisterCommand('testmenu', function()
    if not lib.getOpenMenu() then
        lib.showMenu('kcnet_menu')
    else
        lib.hideMenu(false)
    end
end, false)
