local QBCore = nil
local ESX = nil

if SDC.Framework == "qb-core" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif SDC.Framework == "esx" then
    ESX = exports['es_extended']:getSharedObject()
end


function hasItem(src, item)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        local inventoryItem = Player.Functions.GetItemByName(item)
        if inventoryItem then
            return true
        else
            return false
        end
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local hasItem = xPlayer.hasItem(item)
        local foundItem = false

        foundItem = hasItem and hasItem.count > 0

        if not foundItem then
            for k, v in ipairs(xPlayer.loadout) do
                if item:upper() == v.name:upper() then
                    foundItem = true
                    break
                end
            end
        end

        return foundItem
    end
end

function removeAllOfItem(src, item)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        local inventoryItem = Player.Functions.GetItemByName(item)
        if inventoryItem then
            Player.Functions.RemoveItem(item, inventoryItem.amount)
        end
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local hasItem = xPlayer.hasItem(item)
        local foundItem = false

        if hasItem then
            foundItem = true
            xPlayer.removeInventoryItem(item, hasItem.count)
        end

        if not foundItem then
            for k, v in ipairs(xPlayer.loadout) do
                if item:upper() == v.name:upper() then
                    xPlayer.removeWeapon(item)
                    break
                end
            end
        end
    end
end