RegisterCommand("current_coords", function()
    -- sendMessage(Player.Coords())

    local playerCoords = Player.Coords()
    local playerX = Truncate(playerCoords.x, 3)
    local playerY = Truncate(playerCoords.y, 3)
    local playerZ = Truncate(playerCoords.z, 3)

    Text.SendMessage("X: " .. playerX .. " Y: " .. playerY .. " Z: " .. playerZ)
end, false)

RegisterCommand("current_heading", function()
    local playerHeading = Truncate(Player.Heading(), 3)
    Text.SendMessage("Heading: " .. playerHeading)
end, false)

-- Why does this only work once for my vehicles that I spawn?
-- Clear area of 25
RegisterCommand("clear_vehicles", function()
    local playerCoords = Player.Coords()
    local playerX = playerCoords.x
    local playerY = playerCoords.y
    local playerZ = playerCoords.z

    -- World.ClearVehiclesInArea(playerX, playerY, playerZ, 25.0)
    -- World.ClearArea(playerX, playerY, playerZ, 25.0)

    -- ClearArea(x, y, z, radius, true, false, false, false)
    ClearArea(playerX, playerY, playerZ, 25.0, true, false, false, false)
    -- Text.Notify("Area cleared")
end, false)
