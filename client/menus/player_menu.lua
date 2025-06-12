local mobileRadioChecked = false

local function PlayerTogglesMenu()
    lib.registerMenu({
            id = 'player_toggles',
            title = 'Player Toggles',
            position = Config.MenuPosition,

            onClose = function(keyPressed)
                CloseMenu(false, keyPressed, 'player_options')
            end,

            onSideScroll = function(selected, scrollIndex, args)
            end,

            onSelected = function(selected, secondary, args)
            end,

            onCheck = function(selected, checked, args)
                if args[1] == 'mobile_radio' then
                    -- Update for use in loop
                    mobileRadioStatus = checked
                    -- Update checkbox status
                    mobileRadioChecked = checked
                end
            end,

            options = {
                -- Disable this for now.
                -- { label = 'Kill player', description = 'Kill yourself', args = { 'kill_player' } },

                { label = 'Mobile radio', description = 'Turn on/off the mobile radio outside a vehicle', checked = mobileRadioChecked, args = { 'mobile_radio' } },
            },
        },
        function(selected, scrollIndex, args)
            if not args or not args[1] then return end

            if args[1] == 'kill_player' then
                SetEntityHealth(PlayerPedId(), 0.0)
            -- Moved into checkboxes.
            -- elseif args[1] == 'mobile_radio' then
            --     Player.ToggleMobileRadio()
            end
        end
    )
end

-- Clothes menu


local function CreateClothesMenu()
    local player = PlayerPedId()

    lib.registerMenu({
            id = 'clothes_menu',
            title = 'Clothes Menu',
            position = Config.MenuPosition,


            onClose = function(keyPressed)
                -- This makes this go back to the previous menu.
                CloseMenu(false, keyPressed, 'player_options')
            end,

            -- TODO Fix this to where it takes user input for the drawable ID and texture ID
            onSideScroll = function(selected, scrollIndex, args)
                local currentItem = scrollIndex
                if args[1] == 'change_hair' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_HAIR, currentItem, 0, 0)
                elseif args[1] == 'change_shirt' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_SHIRT, currentItem, 0, 0)
                elseif args[1] == 'change_torso' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_UPPR, currentItem, 0, 0)
                elseif args[1] == 'change_pants' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_LOWR, currentItem, 0, 0)
                elseif args[1] == 'change_shoes' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_FEET, currentItem, 0, 0)
                elseif args[1] == 'change_masks' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_DECL, currentItem, 0, 0)
                elseif args[1] == 'change_accessories' then
                    SetPedComponentVariation(player, PedVarComp.PV_COMP_ACCS, currentItem, 0, 0)

                    -- Unsure about this one
                    -- elseif args[1] == 'change_undershirts' then
                    --     SetPedComponentVariation(player, PedVarComp, currentItem, 0, 0)
                end
            end,

            onSelected = function(selected, secondary, args)
            end,

            onCheck = function(selected, checked, args)
                -- print("Check: ", selected, checked, args)
            end,

            -- TODO Set this up to where it works on Female and Male characters
            -- Possibly make a separate menu for Female and Male clothes
            -- For now it only works on Female characters.
            options = {
                -- { label = 'Shirt', description = 'Change your shirt', args = { 'change_shirt' } },
                { label = 'Hair',              description = '',    values = femaleHair,        args = { 'change_hair' } },
                { label = 'Shirts',            description = '',    values = femaleShirts,      args = { 'change_shirt' } },
                { label = 'Torso',             description = '',    values = femaleTorso,       args = { 'change_torso' } },
                { label = 'Pants',             description = '',    values = femalePants,       args = { 'change_pants' } },
                { label = 'Shoes',             description = '',    values = femaleShoes,       args = { 'change_shoes' } },

                { label = 'Masks',             description = '',    values = masks,             args = { 'change_masks' } },
                { label = 'Accessories',       description = '',    values = femaleAccessories, args = { 'change_accessories' } },


                { label = 'Reset To Defaults', description = 'Reset to a default set of clothes', args = { 'reset_clothes' } },
                -- { label = 'Undershirts', description = '', values = femaleUndershirts, args = { 'change_undershirts' } },
            },
        },
        function(selected, scrollIndex, args)
            if not args or not args[1] then return end
            if args[1] == 'reset_clothes' then
                ResetFemaleClothes()
                -- This fixes it to where it goes back to the previous screen
                lib.showMenu('clothes_menu')
            end
        end
    )
end

function CreatePlayerMenu()
    lib.registerMenu({
        id = 'player_options',
        title = 'Player Options',
        position = menuPosition,

        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'kcnet_menu')
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

        options = {
            { label = 'Player Toggles', description = 'Toggles for the player',                                args = { 'player_toggles' } },
            { label = 'Clothes',        description = 'Set your clothes with the MP Male or MP Female skins.', args = { 'change_clothes' } },
        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'player_toggles' then
            PlayerTogglesMenu()
            lib.showMenu('player_toggles')
        elseif args[1] == 'change_clothes' then
            CreateClothesMenu()
            lib.showMenu('clothes_menu')
        end
    end
    )
end

-- Does this not work in FiveM?
-- local isExplosiveAmmoActive = false
-- Citizen.CreateThread(function ()
--     while true do
--         Wait(0)
--         if isExplosiveAmmoActive then
--             SetExplosiveAmmoThisFrame(PlayerPedId())
--         end
--     end
-- end)
