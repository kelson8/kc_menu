-- Copied implementation from kc_doors
-- My implementation in my test scripts: 
-- https://github.com/kelson8/fivem-scripts/tree/main/kc_doors

Citizen.CreateThread(function()
    GlobalState.doors = Config.Doors
end)

-- Well no wonder this wasn't working, something else has overridden the '/door' command...
-- TODO Make a context menu for this on the client, add permissions for all of this.
-- /door <name> [1 locked, 0 unlocked]
-- RegisterCommand("door", function(source, args, rawCommand)
RegisterCommand("door_test", function(source, args, rawCommand)
    local doorName = args[1]
    local lockState = tonumber(args[2])
    -- Get the door from the GlobalState, I'm not exactly sure how this works yet.
    -- TODO Look into how GlobalStates work in FiveM
    local doors = GlobalState.doors

    -- if not doorName or not doors[doorName] then
        if not doorName then
            -- sendMessage(source, "You did not specify a door to lock/unlock")
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'No door selected',
                description = 'You did not select a door to lock/unlock.'
            })
        elseif not doors[doorName] then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Door doesn\'t exist',
                description = 'The door does not exist.'
            })
            -- sendMessage(source, ("Door %s doesn't exist!"):format(doorName))

            return
        end
        -- return
    -- end

    -- if not lockState or (lockState ~= 0 and lockState ~= 1) then
        if not lockState then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Lock state required',
                description = 'You did not enter a lock state, values are 1 and 0.'
            })
            return

            -- TODO Make this not print if the other option does print.
        elseif (lockState ~= 0 and lockState ~= 1) then

            -- TriggerClientEvent('ox_lib:notify', source, {
            --     title = 'Invalid lock state',
            --     description = 'Valid values are 1 and 0.'
            -- })
            return
        end

    doors[doorName].Locked = lockState
    GlobalState.doors = doors

    TriggerClientEvent("kc_menu:client:update_doors", -1, doorName, lockState)
    if lockState == 0 then

            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Door unlocked',
                description = ('You have unlocked the door %s'):format(doorName)
            })

    elseif lockState == 1 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Door locked',
                description = ('You have locked the door %s'):format(doorName)
            })
    end
end, false)

-- This seems to work now
RegisterCommand("doorlist", function(source, args, rawCommand)
    local doors = GlobalState.doors

    for k,v in pairs(doors) do
        -- print(doors[k].DoorHash:gsub("\n", " "))
        -- print("Door name: %s, locked %i"):format(doors[k].DoorHash)
        print(string.format("Door name: %s, locked %i", doors[k].DoorHash, doors[k].Locked))
    end

end, false)