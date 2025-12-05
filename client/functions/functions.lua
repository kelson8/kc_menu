---@diagnostic disable: duplicate-set-field


-- Positions = {}

Music = {}
Vehicle = {}
Player = {}
Text = {}
World = {}

Teleports = {}

------------
--- Teleport functions
------------

-- Taken from functions.lua in kc_menu
--- This now teleports the players vehicle if they are in one.
--- https://forum.cfx.re/t/esx-want-to-teleport-player-with-his-vehicle/4880346
--- Teleport with a fade
---@param x any
---@param y any
---@param z any
---@param heading any
function Teleports.TeleportFade(x, y, z, heading)
    local player = GetPlayerPed(-1)
    local fadeInTime = 500
    local fadeOutTime = 500

    DoScreenFadeOut(fadeOutTime)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    -- This now teleports the players vehicle if they are in one.
    if IsPedInAnyVehicle(player, false) then
        local currentVeh = GetVehiclePedIsIn(player, false)
        SetEntityCoords(currentVeh, x, y, z, false, false, false, false)
        SetEntityHeading(currentVeh, heading)
    else
        SetEntityCoords(player, x, y, z, false, false, false, false)
        SetEntityHeading(player, heading)
    end

    Wait(fadeInTime)
    DoScreenFadeIn(fadeInTime)
end

------------
-- Message/Notifcation functions
------------

-- Busy spinners

Text.busySpinner = false
function Text.ShowBusySpinner(message)
    if not Text.busySpinner then
        BeginTextCommandBusyspinnerOn("STRING")
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandBusyspinnerOn(5)
        Text.busySpinner = true
    else
        BusyspinnerOff()
        Text.busySpinner = false
    end
end

function Text.HideBusySpinner()
    if Text.busySpinner then
        BusyspinnerOff()
    end
end
--



------------
--- Music functions
------------

-- function PlayMusicEvent(musicEvent)
function Music.Play(musicEvent)
    PrepareMusicEvent(musicEvent)
    TriggerMusicEvent(musicEvent)
end

function Music.PlayArenaWarTheme()
    -- if PrepareMusicEvent("AW_LOBBY_MUSIC_START") then
    PrepareMusicEvent("AW_LOBBY_MUSIC_START")
    TriggerMusicEvent("AW_LOBBY_MUSIC_START")
    -- end
end

-- This seems to stop the music.
function Music.Stop()
    TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START")
end

------------
-- Player functions
------------

-- TODO Test these.

---comment Get the player position
---@return vector3 A vector3 of the players position
function Player.Coords()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    return playerPos
end

function Player.Heading()
    local player = GetPlayerPed(-1)
    local playerHeading = GetEntityHeading(player)

    return playerHeading
end

-- Mobile radio


-- I setup this with a flag system so it shouldn't constantly run.
mobileRadioStatus = false
-- The flags should only ever be toggled here.
local mobileRadioFlag = false

-- Thread with flag system to keep the mobile radio on or off with a checkbox.
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if mobileRadioStatus and not mobileRadioFlag then
            Player.ToggleMobileRadio()
            mobileRadioFlag = true
            lib.notify({
                title = 'Radio Enabled',
                description = 'Enabled Mobile radio',
            })
        elseif not mobileRadioStatus and mobileRadioFlag then
            Player.ToggleMobileRadio()
            mobileRadioFlag = false
            lib.notify({
                title = 'Radio Disabled',
                description = 'Disabled Mobile radio',
            })
        end
    end
end)

function Player.ToggleMobileRadio()
    SetMobilePhoneRadioState(mobileRadioStatus)
    SetMobileRadioEnabledDuringGameplay(mobileRadioStatus)
end

------------
-- Message/Notifcation functions
------------

-- function sendMessage(msg)
function Text.SendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

-- function notify(msg)
function Text.Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

------------
-- Math functions
------------



-- https://www.reddit.com/r/Stormworks/comments/srlkyq/lua_decimal_point/
-- This works for stripping the extra digits from the coords
function Truncate(number, decdigits)
    number = number * (10 ^ decdigits)
    number = math.floor(number)
    number = number / (10 ^ decdigits)

    return number
end

------------
--- World functions
------------

function World.ClearArea(x, y, z, radius)
    ClearArea(x, y, z, radius, true, false, false, false)
end

---
---
function World.ClearVehiclesInArea(x, y, z, radius)
    ClearAreaOfVehicles(x, y, z, radius, false, false, false, false, false)
end
