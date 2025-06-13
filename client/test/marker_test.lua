-- https://coxdocs.dev/ox_lib/Modules/Marker/Client

-- Usage without interactive
-- Places on the player
-- Citizen.CreateThread(function()
-- 	while true do
-- 		marker:draw()

-- 		Citizen.Wait(1)
-- 	end
-- end)

-- local marker = lib.marker.new({
-- 	type = 1,
-- 	coords = GetEntityCoords(cache.ped),
-- 	color = { r = 255, g = 0, b = 0, a = 200 },
-- })

-- Citizen.CreateThread(function()
-- 	while true do
-- 		marker:draw()

-- 		Citizen.Wait(1)
-- 	end
-- end)

-- Usage with interactive
-- This is neat, I can easily create markers with ox_lib.
-- So I could setup teleport markers much easier then what I was trying to do.

-- Police stations

local policeRooftopPos = vec3(447.1, -982.01, 43.69)
local policeRooftopMarkerPos = vec3(440.6, -987.01, 42.90)
local policeGroundPos = vec3(428.5, -1021.8, 28.8)



local center = vec3(430.452759, -1026.108032, 27.846140)
local uiText = "Press [E] to get notified"

-- TODO Rename to ground point
local point = lib.points.new({
	coords = center,
	distance = 10,
})

local rooftopPoint = lib.points.new({
	coords = policeRooftopMarkerPos,
	distance = 10
})

local marker = lib.marker.new({
	coords = center,
	type = 1,
	color = { r = 100, g = 100, b = 50, a = 200 },
})

local policeRooftopMarker = lib.marker.new({
	coords = policeRooftopMarkerPos,
	type = 1,
	color = { r = 100, g = 100, b = 50, a = 200 },
})

function point:nearby()
	marker:draw()

	if self.currentDistance < 1.5 then
		if not lib.isTextUIOpen() then
			-- lib.showTextUI("Press [E] to get notified")
			lib.showTextUI("Press [E] to teleport to Police Station Rooftop")
		end

		if IsControlJustPressed(0, 51) then
			local player = GetPlayerPed(-1)
			-- SetEntityCoords(player, policeRooftopPos.x, policeRooftopPos.y, policeRooftopPos.z,
			SetEntityCoords(player, Locations.policeRooftopPos.x, Locations.policeRooftopPos.y,
				Locations.policeRooftopPos.z,

				false, false, false, false)
			lib.notify({
				-- description = "Hello, World!"
				description = "Teleported to police station rooftop!"
			})
		end
	else
		lib.hideTextUI()
		-- local isOpen, currentText = lib.isTextUIOpen()
		-- if isOpen and currentText == uiText then
		-- 	lib.hideTextUI()
		-- end
	end
end

function rooftopPoint:nearby()
	policeRooftopMarker:draw()

	if self.currentDistance < 1.5 then
		if not lib.isTextUIOpen() then
			lib.showTextUI("Press [E] to teleport to Police Station Ground")
		end

		if IsControlJustPressed(0, 51) then
			local player = GetPlayerPed(-1)
			-- SetEntityCoords(player, policeGroundPos.x, policeGroundPos.y, policeGroundPos.z,
			SetEntityCoords(player, Locations.policeGroundPos.x, Locations.policeGroundPos.y, Locations.policeGroundPos
				.z,
				false, false, false, false)
			lib.notify({
				description = "Teleported to police station ground!"
			})
		end
	else
		lib.hideTextUI()
		-- local isOpen, currentText = lib.isTextUIOpen()
		-- if isOpen and currentText == uiText then
		-- 	lib.hideTextUI()
		-- end
	end
end

-----
-- Spawn
-----

local spawnPoint = lib.points.new({
	coords = Locations.spawnPos,
	distance = 10
})

local spawnMarker = lib.marker.new({
	coords = Locations.spawnPos,
	type = 1,
	color = { r = 100, g = 100, b = 50, a = 200 },
})



-- List of markers
-- Taken from online-interiors
local blips = {
	{ text = "Spawn", color = 49, sprite = 90, coord = Locations.spawnPos,}
}

CreateThread(function()
	for i, var in pairs(blips) do
		var.blip = AddBlipForCoord(var.coord.x, var.coord.y, var.coord.z)
		SetBlipAsShortRange(var.blip, true)
		SetBlipSprite(var.blip, var.sprite)
		SetBlipColour(var.blip, var.color)
		SetBlipDisplay(var.blip, 4)
		SetBlipScale(var.blip, 0.9)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(var.text)
		EndTextCommandSetBlipName(var.blip)
	end
end)

-------
-- This draws a marker at the spawn in the middle of LS and opens the lobby menu when 'E' is pressed.
function spawnPoint:nearby()
	spawnMarker:draw()

	if self.currentDistance < 1.5 then
		if not lib.isTextUIOpen() then
			-- lib.showTextUI("Press [E] Set to no population lobby.")
			lib.showTextUI("Press [E] Set to open lobby menu.")
		end


		if IsControlJustPressed(0, 51) then
			-- TriggerServerEvent('kc_menu:server:setNoPopulation')

			-- Hmm this works, I could make a separate lobby menu just for the players.
			-- One that needs them to go to a teleport location on the map instead of
			-- Always having it in the menu, I would reserve that for admins.
			-- CreateLobbyMenu()
			-- lib.showMenu('lobby_menu')

			-- Switched to using this, I may setup a different lobby event with another permission for the other menu.
			lib.showContext('lobby_context_menu')
		end

	else
		lib.hideTextUI()
	end
end
