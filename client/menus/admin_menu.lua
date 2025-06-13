-- This menu will contain various admin features that I may use

-- TODO Add these below 
-- Add blip tests -- Not started yet

function CreateAdminMenu()
    -- New for permission setup, this seems to work
    local perms = lib.callback.await('kc_menu:server:hasConvarPermission', false, {'Admin', 'AdminOptions'},
    {'EnableBusySpinner',
    'DisableBusySpinner'})

    local menuOptions = {
        {label = 'No access', description = 'You don\'t have access to any options, press enter to return', args = {'kcnet_menu'}}
    }

    local index = 1

    -- add_ace group.admin kc_menu.Admin.AdminOptions.EnableBusySpinner allow # Allow enabling the busy spinner
    -- add_ace group.admin kc_menu.Admin.AdminOptions.DisableBusySpinner allow # Allow disabling the busy spinner

    if perms.EnableBusySpinner then
        menuOptions[index] = {label = 'Enable busy spinner', description = 'Turn on the busy spinner.', args = {'enable_busy_spinner'}}
        index += 1
    end


    if perms.DisableBusySpinner then
        menuOptions[index] = {label = 'Disable busy spinner', description = 'Turn off the busy spinner.', args = {'disable_busy_spinner'}}
        index += 1
    end

    --

    lib.registerMenu({
        id = 'admin_menu',
        title = 'Admin Menu',
        position = Config.MenuPosition,

        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'kcnet_menu')
        end,

        onSelected = function(selected, secondary, args)
        end,

        onCheck = function(selected, checked, args)
            -- print("Check: ", selected, checked, args)
        end,

        options = menuOptions

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'enable_busy_spinner' then
            -- 1
            Text.ShowBusySpinner("Test")

        elseif args[1] == 'disable_busy_spinner' then
            -- 2
            Text.HideBusySpinner()
        end
    end
    )
end