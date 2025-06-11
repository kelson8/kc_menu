local function PlayerTogglesMenu()
    lib.registerMenu({
        id = 'player_toggles',
        title = 'Player Toggles',
        position = Config.MenuPosition,

        onSideScroll = function(selected, scrollIndex, args)
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
        end,

        options = {
            { label = 'Kill player', description = 'Kill yourself', args = { 'kill_player' } },
        },
    },
        function(selected, scrollIndex, args)
            if not args or not args[1] then return end

            if args[1] == 'kill_player' then
                SetEntityHealth(PlayerPedId(), 0.0)
            end
        end
    )
end

function CreatePlayerMenu()
    lib.registerMenu({
        id = 'player_options',
        title = 'Player Options',
        position = menuPosition,

        onSideScroll = function(selected, scrollIndex, args)
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
        end,

        options = {
            { label = 'Player Toggles', description = 'Toggles for the player', args = { 'player_toggles' } },
        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'player_toggles' then
            PlayerTogglesMenu()
            lib.showMenu('player_toggles')
        end

        -- lib.showMenu(args[1], 'player_options')
        -- lib.showMenu('player_options')
    end



    )
end


-- Does this not work in FiveM?
-- local isExplosiveAmmoActive = true
-- Citizen.CreateThread(function ()
--     while true do
--         Wait(0)
--         if isExplosiveAmmoActive then
--             SetExplosiveAmmoThisFrame(PlayerPedId())
--         end
--     end
-- end)