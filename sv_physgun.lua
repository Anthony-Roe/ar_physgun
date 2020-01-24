local debug = false
RegisterNetEvent("ar_physgun:RequestUpdateEntity")
AddEventHandler("ar_physgun:RequestUpdateEntity", function(entity, dist, alpha, detach)
    if (debug) then
        print("[Physgun] ( " .. source .. " ) Updating: " .. entity .. " Dist: " .. dist .. " Alpha: " .. alpha .. " Detach: " .. tostring(detach))
    end
    TriggerClientEvent("ar_physgun:UpdateEntity", source, entity, dist, alpha, detach)
end)