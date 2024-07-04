RegisterServerEvent("SDMD:Server:CheckInv")
AddEventHandler("SDMD:Server:CheckInv", function()
    local src = source

    if SDC.RemoveAllOfBlastedItem then
        local hasSent = false
        for i=1, #SDC.BlacklistedItems do
            if hasItem(src, SDC.BlacklistedItems[i]) then
                if not hasSent then
                    TriggerClientEvent("SDMD:Client:BadInv", src)
                    hasSent = true
                end
                removeAllOfItem(src, SDC.BlacklistedItems[i])
            end
        end
    else
        for i=1, #SDC.BlacklistedItems do
            if hasItem(src, SDC.BlacklistedItems[i]) then
                TriggerClientEvent("SDMD:Client:BadInv", src)
                return
            end
        end
    end
end)