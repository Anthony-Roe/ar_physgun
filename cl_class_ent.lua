local debug = false

function PhysEnt(entity)
    debug("[Physgun] Creating PhysEnt: " .. entity)
    local self = {}
    self.ent = entity
    self.distance = 0
    self.Attach = function()
        debug("[Physgun] Attaching PhysEnt: " .. self.ent)
        local p_coords = GetEntityCoords(PlayerPedId())
        local ent_coords = GetEntityCoords(self.ent, false)
        self.distance = GetDistanceBetweenCoords(p_coords.x, p_coords.y, p_coords.z, ent_coords.x, ent_coords.y, ent_coords.z)
        TriggerServerEvent("ar_physgun:RequestUpdateEntity", self.ent, self.distance, 200, false)
    end
    self.Detach = function()
        debug("[Physgun] Detatching PhysEnt: " .. self.ent)
        TriggerServerEvent("ar_physgun:RequestUpdateEntity", self.ent, self.distance, 255, true)
        DetachEntity(self.ent, 0, true)
    end
    self.Scroll = function(dirValue)
        local p_coords = GetEntityCoords(PlayerPedId())
        local ent_coords = GetEntityCoords(self.ent, false)
        self.distance = GetDistanceBetweenCoords(p_coords.x, p_coords.y, p_coords.z, ent_coords.x, ent_coords.y, ent_coords.z)
        TriggerServerEvent("ar_physgun:RequestUpdateEntity", self.ent, self.distance + dirValue, 200, false)
    end
    self.Attach()
    debug("[Physgun] PhysEnt Created: " .. self.ent)
    return self
end

RegisterNetEvent("ar_physgun:UpdateEntity")
AddEventHandler("ar_physgun:UpdateEntity", function(entity, dist, alpha, detach)
    debug("[Physgun] Updating PhysEnt: " .. entity .. ", Dist: " .. dist .. ", Alpha: " .. alpha)
    SetEntityAlpha(entity,alpha)
    AttachEntityToEntity(entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), dist, 0.0, 0.0, -80.0, 0.0, 0.0, 1, 1, 1, 1, 0, 1)
    if (detach == true) then
        DetachEntity(entity, 0, true)
    end
end)

function debug(msg)
    if (debug) then
        print(msg)
    end
end