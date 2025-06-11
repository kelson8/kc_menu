

function CreateVehicleMenu()
    lib.registerMenu({
        id = 'vehicle_options',
        title = 'Vehicle Options',
        position = menuPosition,

        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'kcnet_menu')
        end,

        onSideScroll = function(selected, scrollIndex, args)
        end,

        onSelected = function(selected, secondary, args)
        end,

        onCheck = function(selected, checked, args)
            -- print("Check: ", selected, checked, args)
        end,

        options = {
            { label = 'Upgrade vehicle', description = 'Fully upgrade your vehicle', args = { 'vehicle_upgrade' } },
        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'vehicle_upgrade' then
            Vehicle.UpgradeMax()
        end

        -- lib.showMenu(args[1], 'vehicle_upgrades')
        -- lib.showMenu('vehicle_upgrades')
    end



    )
end