-- I will be configuring locked/unlocked doors, garages and other items here
-- Copied in from kc_doors

-- X: 450.1041 Y: -985.7384 Z: 30.8393
-- Hash: v_ilev_ph_gendoor004

-- Use the pun_idgun resource from here for doors:
-- https://github.com/Puntherline/pun_idgun
-- Add them to the config, the door name, door hash, model hash, exact door coordinates, and if it is locked or not

function sendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = {msg, },
    })
end

Citizen.CreateThread(function()
    local doors = GlobalState.doors

    if not doors then
        return
    end

    for k,v in pairs(doors) do
        AddDoorToSystem(v.DoorHash, v.ModelHash, v.Coordinates.x, v.Coordinates.y, v.Coordinates.z, true, true, false)
        DoorSystemSetDoorState(v.DoorHash, v.Locked, false, false)
    end

    -- This isn't needed, the above loop does this.
    -- AddDoorToSystem("police_1", "v_ilev_ph_gendoor004", doorX, doorY, doorZ, true, true, false)
end)


RegisterNetEvent("kc_menu:client:update_doors", function(doorName, lockState)
    DoorSystemSetDoorState(Config.Doors[doorName].DoorHash, lockState, false, false)
end)

-- Add chat suggestions for command.
-- https://docs.fivem.net/docs/resources/chat/events/chat-addSuggestion/
TriggerEvent('chat:addSuggestion', '/door', 'Unlock/Lock doors in the world.', {
    { name = "doorName", help = "Door to lock/unlock." },
    { name = "lockState",  help = "1 Is locked, 0 is unlocked." }
})

