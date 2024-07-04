local QBCore = nil
local ESX = nil

if SDC.Framework == "qb-core" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif SDC.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
end


function hasItem(src, item)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.Functions.GetItemByName(item)
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.getInventoryItem(item) then
            return xPlayer.getInventoryItem(item).count
        else
            return 0
        end
    end
end

function removeAllOfItem(src, item)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName(item) then
            Player.Functions.RemoveItem(item, Player.Functions.GetItemByName(item).amount)
        end
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.getInventoryItem(item) then
            xPlayer.removeInventoryItem(item, xPlayer.getInventoryItem(item).count) 
        end
    end
end