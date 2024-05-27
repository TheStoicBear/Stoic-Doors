local GetEntityBoneIndexByName = GetEntityBoneIndexByName
local GetEntityBonePosition_2 = GetEntityBonePosition_2
local GetVehicleDoorLockStatus = GetVehicleDoorLockStatus
local TaskEnterVehicle = TaskEnterVehicle
local GetClosestVehicle = GetClosestVehicle
local GetVehiclePedIsIn = GetVehiclePedIsIn
local GetSeatPedIsTryingToEnter = GetSeatPedIsTryingToEnter
local GetPedInVehicleSeat = GetPedInVehicleSeat
local TaskLeaveVehicle = TaskLeaveVehicle

local bones = Config.bones



local function toggleDoor(vehicle, door)
    if GetVehicleDoorLockStatus(vehicle) ~= 2 then
        if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
            SetVehicleDoorShut(vehicle, door, false)
        else
            SetVehicleDoorOpen(vehicle, door, false, false)
        end
    end
end

local function canInteractWithDoor(entity, coords, door, useOffset)
    if not GetIsDoorValid(entity, door) or GetVehicleDoorLockStatus(entity) > 1 or IsVehicleDoorDamaged(entity, door) then return end
    if useOffset then return true end
    local boneName = bones[door]
    if not boneName then return false end
    local boneId = GetEntityBoneIndexByName(entity, 'door_' .. boneName)
    if boneId ~= -1 then
        return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.5 or
            #(coords - GetEntityBonePosition_2(entity, GetEntityBoneIndexByName(entity, 'seat_' .. boneName))) < 0.72
    end
end

local function onSelectDoor(data, door)
    local entity = data.entity

    if NetworkGetEntityOwner(entity) == cache.playerId then
        return toggleDoor(entity, door)
    else
        TriggerServerEvent('ox_target:toggleEntityDoor', VehToNet(entity), door)
    end
end

local function ToolTip()
    lib.showTextUI(Config.ToolTipsHelpText, {
        position = Config.ToolTipPosition,
        icon = Config.ToolTipIcon,
        iconColor = Config.ToolTipIconColor,
        style = {
            borderRadius = Config.ToolTipBorderRadius,
            backgroundColor = Config.ToolTipBackground,
            color = Config.ToolTipTextColor
        }
    })
    Citizen.CreateThread(function()
        while true do
            Wait(Config.ToolTipTime)
            DisableControlAction(0, 23, true) -- Disable 'F' key on keyboard
            DisableControlAction(0, 75, true) -- Disable 'Y' button on controller
            lib.hideTextUI()
        end
    end)
end

RegisterNetEvent('ox_target:toggleEntityDoor', function(netId, door)
    local entity = NetToVeh(netId)
    toggleDoor(entity, door)
end)
if Config.ForceTarget == true then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local tryingToEnter = GetSeatPedIsTryingToEnter(playerPed)
            local occupant = GetPedInVehicleSeat(vehicle, tryingToEnter)
            
            -- Check if player is inside a vehicle and trying to enter a seat
            if vehicle ~= 0 and tryingToEnter ~= -1 then
                -- Allow the player to exit the vehicle if F or Y is pressed
                if IsDisabledControlJustPressed(0, 23) or IsDisabledControlJustPressed(0, 75) then
                    TaskLeaveVehicle(playerPed, vehicle, 0)
                end
            else
                local closestVehicle = GetClosestVehicle(GetEntityCoords(playerPed), 10.0, 0, 71) -- Check within 10 units
                if closestVehicle ~= 0 then
                    DisableControlAction(0, 23, true) -- Disable 'F' key on keyboard
                    DisableControlAction(0, 75, true) -- Disable 'Y' button on controller
                    if IsDisabledControlJustPressed(0, 23) or IsDisabledControlJustPressed(0, 75) then
                        if Config.ToolTips then
                            ToolTip()
                        end
                    end
                end
            end
        end
    end)
end
exports.ox_target:addGlobalVehicle({
    {
        name = Config.driverFName or 'ox_target:driverF',
        icon = Config.driverFIcon or 'fa-solid fa-car-side',
        label = Config.driverFLabel or 'Get in Front Driver Door',
        bones = { 'door_dside_f', 'seat_dside_f' },
        distance = Config.driverFDistance or 2,
        canInteract = function(entity, distance, coords, name)
            return canInteractWithDoor(entity, coords, 0)
        end,
        onSelect = function(data)
            TaskEnterVehicle(PlayerPedId(), data.entity, 10000, -1, 1.0, 1, 0)
        end
    },
    {
        name = Config.passengerFName or 'ox_target:passengerF',
        icon = Config.passengerFIcon or 'fa-solid fa-car-side',
        label = Config.passengerFLabel or 'Get in Front Passenger Door',
        bones = { 'door_pside_f', 'seat_pside_f' },
        distance = Config.passengerFDistance or 2,
        canInteract = function(entity, distance, coords, name)
            return canInteractWithDoor(entity, coords, 1)
        end,
        onSelect = function(data)
            TaskEnterVehicle(PlayerPedId(), data.entity, 10000, 0, 1.0, 1, 0)
        end
    },
    {
        name = Config.driverRName or 'ox_target:driverR',
        icon = Config.driverRIcon or 'fa-solid fa-car-side',
        label = Config.driverRLabel or 'Get in Rear Driver Door',
        bones = { 'door_dside_r', 'seat_dside_r' },
        distance = Config.driverRDistance or 2,
        canInteract = function(entity, distance, coords)
            return canInteractWithDoor(entity, coords, 2)
        end,
        onSelect = function(data)
            TaskEnterVehicle(PlayerPedId(), data.entity, 10000, 1, 1.0, 1, 0)
        end
    },
    {
        name = Config.passengerRName or 'ox_target:passengerR',
        icon = Config.passengerRIcon or 'fa-solid fa-car-side',
        label = Config.passengerRLabel or 'Get in Rear Passenger Door',
        bones = { 'door_pside_r', 'seat_pside_r' },
        distance = Config.passengerRDistance or 2,
        canInteract = function(entity, distance, coords)
            return canInteractWithDoor(entity, coords, 3)
        end,
        onSelect = function(data)
            TaskEnterVehicle(PlayerPedId(), data.entity, 10000, 2, 1.0, 1, 0)
        end
    }
})

