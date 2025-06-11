

function CreateMusicMenu()
    lib.registerMenu({
        id = 'music_options',
        title = 'Music Options',
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
            { label = 'Chase Parachute', description = 'Play the CHASE_PARACHUTE_START music from the game.', args = { 'chase_parachute_music' } },
            { label = 'Arena War', description = 'Play the arena war theme from GTA Online.', args = { 'arena_war_music' } },
            { label = 'Stop music', description = 'Stop the currently playing sound track.', args = { 'stop_music' } },
        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'chase_parachute_music' then
            Music.Play("CHASE_PARACHUTE_START")
        elseif args[1] == 'arena_war_music' then
            Music.PlayArenaWarTheme()
        elseif args[1] == 'stop_music' then
            Music.Stop()
        end

        -- lib.showMenu(args[1], 'vehicle_upgrades')
        -- lib.showMenu('vehicle_upgrades')
    end



    )
end