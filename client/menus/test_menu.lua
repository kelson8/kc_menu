---@diagnostic disable: param-type-mismatch

-- This works easily for making separate files for the menus.
-- Create the test menu



-- TODO Setup permissions for this.
lib.registerContext({
    id = 'test_menu',
    title = 'Test',
    menu = 'main_menu',

    options = {

        {
            -- Well now, this works well.
            title = 'Kill nearest ped',
            onSelect = function()
                local player = GetPlayerPed(-1)
                local playerPos = GetEntityCoords(player)
                local closestPed = lib.getClosestPed(playerPos, 10.0)
                SetEntityHealth(closestPed, 0.0)
            end
        },

        {
            -- This one doesn't seem to work.
            title = 'Kill nearest vehicle',
            onSelect = function()
                local player = GetPlayerPed(-1)
                local playerPos = GetEntityCoords(player)
                local closestVehicle = lib.getClosestVehicle(playerPos, 10.0, false)
                SetEntityHealth(closestVehicle, 0.0)
            end
        },

        --
        {
            -- Play an animation
            -- This seems to work
            -- https://forum.cfx.re/t/confused-playing-animation-on-the-player/2426
            title = 'Play animation',
            onSelect = function()
                local player = GetPlayerPed(-1)
                -- lib.playAnim(player, "random@arrests@busted","enter", 2.0, -2.0,-1 ,49, 0, true, false, true)
                lib.playAnim(player, "random@arrests@busted", "enter", 8.0, -2.0, 2000, 49, 0, true, false, true)
            end
        },

        {
            -- Works as a basic alert pop up:
            -- https://coxdocs.dev/ox_lib/Modules/Interface/Client/alert
            title = 'Test alert',
            onSelect = function()
                local alert = lib.alertDialog({
                    header = 'Alert',
                    content = 'Alert test\nMarkdown support.',
                    centered = true,
                    cancel = true,
                })
                print(alert)
            end
        },


        -- {
        --     title = 'Airport',
        --     onSelect = function()
        --         TeleportFade(positions.airportX, positions.airportY, positions.airportZ, positions.airportHeading)
        --     end
        -- },
    }

})



-----
-- https://overextended.dev/ox_lib/Modules/Interface/Client/menu
-- This actually works well for a regular menu, I should use this instead of the context menus eventually.
-----
-- lib.registerMenu({
--     id = 'some_menu_id',
--     title = 'Menu title',
--     position = 'top-right',
--     onSideScroll = function(selected, scrollIndex, args)
--         print("Scroll: ", selected, scrollIndex, args)
--     end,
--     onSelected = function(selected, secondary, args)
--         if not secondary then
--             print("Normal button")
--         else
--             if args.isCheck then
--                 print("Check button")
--             end

--             if args.isScroll then
--                 print("Scroll button")
--             end
--         end
--         print(selected, secondary, json.encode(args, {indent=true}))
--     end,
--     onCheck = function(selected, checked, args)
--         print("Check: ", selected, checked, args)
--     end,
--     onClose = function(keyPressed)
--         print('Menu closed')
--         if keyPressed then
--             print(('Pressed %s to close the menu'):format(keyPressed))
--         end
--     end,
--     options = {
--         {label = 'Simple button', description = 'It has a description!'},
--         {label = 'Checkbox button', checked = true},
--         {label = 'Scroll button with icon', icon = 'arrows-up-down-left-right', values={'hello', 'there'}},
--         {label = 'Button with args', args = {someArg = 'nice_button'}},
--         {label = 'List button', values = {'You', 'can', 'side', 'scroll', 'this'}, description = 'It also has a description!'},
--         {label = 'List button with default index', values = {'You', 'can', 'side', 'scroll', 'this'}, defaultIndex = 5},
--         {label = 'List button with args', values = {'You', 'can', 'side', 'scroll', 'this'}, args = {someValue = 3, otherValue = 'value'}},
--     }
-- }, function(selected, scrollIndex, args)
--     print(selected, scrollIndex, args)
-- end)

-- RegisterCommand('testmenu', function()
--     lib.showMenu('some_menu_id')
-- end)

--
