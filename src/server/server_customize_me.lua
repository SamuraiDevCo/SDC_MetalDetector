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
        local inventoryItem = xPlayer.getInventoryItem(item)
        if inventoryItem and inventoryItem.count > 0 then
            return true
        else
            return false
        end
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
        local inventoryItem = xPlayer.getInventoryItem(item)
        if inventoryItem then
            xPlayer.removeInventoryItem(item, inventoryItem.count)
        end
    end
end