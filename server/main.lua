-- Credit to bMenu in main.lua for the permission system I am using.

local resourceName = "kc_menu"

if GetCurrentResourceName() ~= resourceName then
    error(string.format('Please don\'t rename this resource, change the folder name' ..
    '(back) to \'%s\' (case sensitive) to make sure the saved data can be saved and fetched accordingly from the cache.', resourceName))
    return
end

--#endregion Startup

--#region Callbacks

lib.callback.register('kc_menu:server:setConvar', function(_, convar, value, replicated, sendUpdate, menuId, option, optionId)
    if sendUpdate then
        -- TODO Implement this, actually I don't think this is in use in bMenu
        TriggerClientEvent('kc_menu:client:updateConvar', -1, convar, value, menuId, option, optionId)
    end
    return replicated and SetConvarReplicated(convar, value) or SetConvar(convar, value)
end)

lib.callback.register('kc_menu:server:hasCommandPermission', function(source, command)
    return IsPlayerAceAllowed(source, ('command.%s'):format(command))
end)

lib.callback.register('kc_menu:server:hasConvarPermission', function(source, category, convar)
    if not convar then return end

    if type(convar) == 'table' then
        local allowed = {}

        if GetConvar('kc_menu.use_permissions', 'true') == 'false' then
            for i = 1, #convar do
                allowed[convar[i]] = true
            end

            return allowed
        end

        local categoryType = type(category)
        local categoryText = category
        if categoryType == 'table' then
            categoryText = ''
            for i = 1, #category do
                local text = category[i]
                local length = #text
                local endStr = text:sub(length, length)
                text = endStr == '.' and text or text..'.'
                categoryText = string.format('%s%s', categoryText, text)
            end
        elseif categoryType == 'string' then
            local length = #categoryText
            local endStr = categoryText:sub(length, length)
            categoryText = endStr == '.' and categoryText or categoryText..'.'
        end

        local hasAllPermission = IsPlayerAceAllowed(source, string.format('%sAll', categoryText))
        for i = 1, #convar do
            local c = convar[i]
            -- allowed[c] = hasAllPermission or IsPlayerAceAllowed(source, string.format('bMenu.%s%s', categoryText or '', c))
            allowed[c] = hasAllPermission or IsPlayerAceAllowed(source, string.format('kc_menu.%s%s', categoryText or '', c))
        end

        return allowed
    end

    local categoryType = type(category)
    local categoryText = category
    if categoryType == 'table' then
        categoryText = ''
        for i = 1, #category do
            local text = category[i]
            local length = #text
            local endStr = text:sub(length, length)
            text = endStr == '.' and text or text..'.'
            categoryText = string.format('%s%s', categoryText, text)
        end
    elseif categoryType == 'string' then
        local length = #categoryText
        local endStr = categoryText:sub(length, length)
        categoryText = endStr == '.' and categoryText or (categoryText .. '.')
    end

    -- return GetConvar('kc_menu.use_permissions', 'false') == 'false' or IsPlayerAceAllowed(source, string.format('%sAll', categoryText)) or IsPlayerAceAllowed(source, string.format('bMenu.%s%s', categoryText or '', convar))
    return GetConvar('kc_menu.use_permissions', 'false') == 'false' 
    or IsPlayerAceAllowed(source, string.format('%sAll', categoryText)) 
    or IsPlayerAceAllowed(source, string.format('kc_menu.%s%s', categoryText or '', convar))
end)

--#endregion Callbacks