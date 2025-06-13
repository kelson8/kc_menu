-- This file won't be loaded by the project, but it can be used to easily create new menus

-- Name this CreateTestMenu or whatever to name the menu
local function CreateMenu()

    --

    lib.registerMenu({
        -- Set these values
        id = 'menu_id',
        title = 'Menu Name',
        position = Config.MenuPosition,

        -- Switch back to the main menu
        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'kcnet_menu')
        end,

        onSelected = function(selected, secondary, args)
        end,

        onCheck = function(selected, checked, args)
            -- print("Check: ", selected, checked, args)
        end,

        -- Set the menu options
        -- options = {
        --     { label = 'Option 1',           description = '',   args = { 'set_option1' } },
        --     { label = 'Option 2', description = '.', args = { 'set_option2' } },
        -- }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'set_option1' then
            -- 1

        elseif args[1] == 'set_option2' then
            -- 2
        end
    end
    )
end