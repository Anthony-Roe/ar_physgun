function PhysEnt(entity)
    print("[Physgun] Creating PhysEnt")
    local self = {}
    self.ent = entity
    self.distance = 0
    self.Attach = function()
        print("Attaching")
        print(self.ent)
        local p_coords = GetEntityCoords(PlayerPedId())
        local ent_coords = GetEntityCoords(self.ent, false)
        self.distance = GetDistanceBetweenCoords(p_coords.x, p_coords.y, p_coords.z, ent_coords.x, ent_coords.y, ent_coords.z)
        SetEntityAlpha(self.ent,200)
        AttachEntityToEntity(self.ent, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), self.distance, 0.0, 0.0, -80.0, 0.0, 0.0, 1, 1, 1, 1, 0, 1)
    end
    self.Detach = function()
        SetEntityAlpha(entity,255)
        DetachEntity(self.ent, 0, true)
    end
    self.Scroll = function(dirValue)
        AttachEntityToEntity(self.ent, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), self.distance + dirValue, 0.0, 0.0, -80.0, 0.0, 0.0, 1, 1, 1, 1, 0, 1)
        local p_coords = GetEntityCoords(PlayerPedId())
        local ent_coords = GetEntityCoords(self.ent, false)
        self.distance = GetDistanceBetweenCoords(p_coords.x, p_coords.y, p_coords.z, ent_coords.x, ent_coords.y, ent_coords.z)
    end
    self.Attach()
    return self
end