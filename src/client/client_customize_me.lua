local QBCore = nil
local ESX = nil

if SDC.Framework == "qb-core" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif SDC.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
end


function GetCurrentJob()
    if SDC.Framework == "qb-core" then
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData and PlayerData["job"] then
            return PlayerData.job.name
        else
            return ""
        end
    elseif SDC.Framework == "esx" then
        local PlayerData = ESX.GetPlayerData()
        if PlayerData and PlayerData.job then
            return PlayerData.job.name
        else
            return ""
        end
    end
end