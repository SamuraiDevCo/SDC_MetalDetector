local detectorsNear = {}
local closestDet = 1

local inDet = false
local cooldown = false

local modelCheat = {}

Citizen.CreateThread(function()
	for i=1, #SDC.DetectorProps do
		modelCheat[tostring(GetHashKey(SDC.DetectorProps[i]))] = SDC.DetectorProps[i]
	end

	while true do
		local ped = PlayerPedId()
		local detectorsNear2 = {}
		for ent in EnumerateObjects() do
			local entC = GetEntityCoords(ent)
			if modelCheat[tostring(GetEntityModel(ent))] and Vdist(entC.x, entC.y, entC.z, GetEntityCoords(ped)) <= 50 then
				table.insert(detectorsNear2, ent)
			end
		end
		detectorsNear = detectorsNear2

		if detectorsNear[1] then
			local coords = GetEntityCoords(ped)
			local minDistance = 10
			for i=1, #detectorsNear do
				dist = Vdist(coords.x, coords.y, coords.z, GetEntityCoords(detectorsNear[i]))
				if dist < minDistance then
					minDistance = dist
					closestDet = i
				end
			end
		else
			closestDet = 1
		end


		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		
		if detectorsNear[1] and Vdist(coords.x, coords.y, coords.z, GetOffsetFromEntityInWorldCoords(detectorsNear[closestDet], 0.0, 0.0, 1.0)) <= 5 and not cooldown then
			if Vdist(coords.x, coords.y, coords.z, GetOffsetFromEntityInWorldCoords(detectorsNear[closestDet], 0.0, 0.0, 1.0)) <= 0.5 and not inDet then
				inDet = true
				TriggerServerEvent("SDMD:Server:CheckInv", GetEntityCoords(detectorsNear[closestDet]))
			elseif Vdist(coords.x, coords.y, coords.z, GetOffsetFromEntityInWorldCoords(detectorsNear[closestDet], 0.0, 0.0, 1.0)) > 0.8 and inDet then
				inDet = false
				cooldown = true
				Citizen.Wait(1000 * SDC.DetectorCooldown)
				cooldown = false
			end
			Citizen.Wait(100)
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent("SDMD:Client:DetectorBeep")
AddEventHandler("SDMD:Client:DetectorBeep", function(dacoords, id)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local dist = Vdist(coords, dacoords.x, dacoords.y, dacoords.z)

	if dist <= SDC.MaxSoundDistance then
		local int = math.ceil(SDC.MaxSoundDistance/10)
		local sec = math.ceil(dist/int)
		local tab = {
			[1] = 1.0,
			[2] = 0.9,
			[3] = 0.8,
			[4] = 0.7,
			[5] = 0.6,
			[6] = 0.5,
			[7] = 0.4,
			[8] = 0.3,
			[9] = 0.2,
			[10] = 0.1
		}
		local finalVolume = 0.0

		if sec <= 1 then
			finalVolume = tab[1]
		elseif sec >= 10 then
			finalVolume = tab[10]
		else
			finalVolume = tab[sec]
		end
		SendNUIMessage({
			SoundType = {"Started", "./sound/"..SDC.DetectorSoundFile..".ogg", finalVolume},
			SoundPerson	= id
		})
	end
end)


local detData = {}
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for i=1, #SDC.SpawnDetectors do
			if Vdist(coords.x, coords.y, coords.z, SDC.SpawnDetectors[i].Coords) <= SDC.SpawnDetectorDist then
				if not detData[tostring(i)] then
					LoadPropDict(SDC.SpawnDetectors[i].Model)
					local dadet = CreateObject(GetHashKey(SDC.SpawnDetectors[i].Model), SDC.SpawnDetectors[i].Coords.x, SDC.SpawnDetectors[i].Coords.y, SDC.SpawnDetectors[i].Coords.z,  false,  true, false)
					PlaceObjectOnGroundProperly(dadet)
					SetEntityHeading(dadet, SDC.SpawnDetectors[i].Coords.w)
					FreezeEntityPosition(dadet, true)
					detData[tostring(i)] = dadet
				end
			elseif detData[tostring(i)] then
				DeleteEntity(detData[tostring(i)])
				detData[tostring(i)] = nil
			end
		end
		Citizen.Wait(500)
	end
end)
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
		for k,v in pairs(detData) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		end
	end
end)

--Functions
function LoadPropDict(model)
	while not HasModelLoaded(model) do
	  RequestModel(model)
	  Wait(10)
	end
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end