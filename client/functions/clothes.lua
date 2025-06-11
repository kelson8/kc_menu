-- Generate tables with a list of numbers for the clothing options

-- Female

femaleAccessories = {}
femaleHair = {}
femaleShirts = {}
femaleUnderShirts = {}
femalePants = {}
femaleTorso = {}

femaleShoes = {}

masks = {}

-- TODO Set these up later
-- Male
-- maleHair = {}
maleShirts = {}
-- malePants = {}
-- maleShoes = {}
-- maleTorso = {}


-- Setup the shirts tables for the ox_lib clothes menu.
local function setupShirts()
-- function setFemaleShirts()
	-- Loop from 0 to 414 (inclusive)
	for i = 0, 414 do
		-- femaleShirts[i] = i -- Assign the index 'i' as the value at key 'i'
		table.insert(femaleShirts, i)
	end

	for i = 0, 392 do
		-- maleShirts[i] = i
        table.insert(maleShirts, i)
	end
end

local function setupHair()
    for i = 0, 80 do
		table.insert(femaleHair, i)
	end

	-- for i = 0, 82 do
    --     table.insert(maleHair, i)
	-- end
end

local function setupPants()
	for i = 0, 150 do
		table.insert(femalePants, i)
	end

	-- for i = 0, 143 do
    --     table.insert(malePants, i)
	-- end
end

local function setupTorso()
    for i = 0, 241 do
		table.insert(femaleTorso, i)
	end

	-- for i = 0, 196 do
    --     table.insert(maleTorso, i)
	-- end
end

local function setupShoes()
    for i = 0, 105 do
		table.insert(femaleShoes, i)
	end

	-- for i = 0, 101 do
    --     table.insert(maleShoes, i)
	-- end
end

local function setupMasks()
    for i = 0, 197 do
		table.insert(masks, i)
	end
end

local function setupAccessories()
    for i = 0, 120 do
		table.insert(femaleAccessories, i)
	end

	-- for i = 0, 151 do
    --     table.insert(maleAccessories, i)
	-- end
end

local function setupUndershirts()
    for i = 0, 233 do
		table.insert(femaleUnderShirts, i)
	end

	-- for i = 0, 188 do
    --     table.insert(maleUnderShirts, i)
	-- end
end

-- TODO Fix this one
-- local function setupBodyArmors()
--     for i = 0, 56 do
-- 		table.insert(femaleArmor, i)
-- 	end

-- 	-- for i = 0, 188 do
--     --     table.insert(maleArmor, i)
-- 	-- end
-- end

-- Thread to run on start for this
Citizen.CreateThread(function ()
    setupShirts()
    setupHair()
    setupPants()
    setupTorso()
    setupShoes()
    setupMasks()
    setupAccessories()
    setupUndershirts()
    -- setupBodyArmors()
end)

function ResetFemaleClothes()
    local player = PlayerPedId()
    local textureId = 0
    local paletteId = 0
    SetPedComponentVariation(player, PedVarComp.PV_COMP_SHIRT, 30, textureId, paletteId)
    SetPedComponentVariation(player, PedVarComp.PV_COMP_LOWR, 151, textureId, paletteId)
    SetPedComponentVariation(player, PedVarComp.PV_COMP_FEET, 27, textureId, paletteId)
    SetPedComponentVariation(player, PedVarComp.PV_COMP_UPPR, 22, textureId, paletteId)
end

function getFemaleShirts()
-- function getFemaleShirts()
	-- Optional: Print the table to verify
	-- for key, value in pairs(femaleShirts) do
	-- 	print("femaleShirts[" .. key .. "] = " .. value)
	-- end

    return femaleShirts
	-- for key, value in pairs(maleShirts) do
		-- print("maleShirts[" .. key .. "] = " .. value)
	-- end
end
