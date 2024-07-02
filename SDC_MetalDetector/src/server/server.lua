RegisterServerEvent("SDMD:Server:CheckInv")
AddEventHandler("SDMD:Server:CheckInv", function()
    local src = source

    for i=1, #SDC.BlacklistedItems do
        if hasItem(src, SDC.BlacklistedItems[i]) then
            TriggerClientEvent("SDMD:Client:BadInv", src)
            return
        end
    end
end)