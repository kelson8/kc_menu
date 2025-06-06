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
			SetEntityCoords(player, policeRooftopPos.x, policeRooftopPos.y, policeRooftopPos.z,
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
			SetEntityCoords(player, policeGroundPos.x, policeGroundPos.y, policeGroundPos.z,
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
