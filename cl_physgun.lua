local gunHash = 0
local player = PlayerId()
local cur_ent = nil
local aiming = false
local _, gun = nil
local scrollMod = 2

Citizen.CreateThread(function() -- Handles all of the controls
    while true do

        if (aiming == false and cur_ent ~= nil) then
            cur_ent.Detach()
            cur_ent = nil
        end
        if (gun == gunHash) then
            DisablePlayerFiring(player, true)
            if (IsPlayerFreeAiming(player)) then
                DisableControlAction(0, 16, true) -- Scroll down
                DisableControlAction(0, 17, true) -- Scroll Up
                DisableControlAction(0, 50, true) -- INPUT_ACCURATE_AIM
                aiming = true
                if (IsDisabledControlJustPressed(0, 24)) then
                    local target, entity = GetEntityPlayerIsFreeAimingAt(player)
                    if (entity and (entity ~= 0)) then
                        if (cur_ent == nil) then
                            cur_ent = PhysEnt(entity)
                        end
                    end
                end
                if (IsDisabledControlPressed(0, 16)) then -- Scroll Down
                    if (cur_ent ~= nil) then
                        cur_ent.Scroll(-1 * scrollMod)
                    end
                end
                if (IsDisabledControlPressed(0, 17)) then -- Scroll Up
                    if (cur_ent ~= nil) then
                        cur_ent.Scroll(scrollMod)
                    end
                end
            elseif (not IsPlayerFreeAiming(player)) then
                aiming = false
            end
        else
            EnableControlAction(0, 16, true) -- Scroll down
            EnableControlAction(0, 17, true) -- Scroll Up
            EnableControlAction(0, 50, true) -- INPUT_ACCURATE_AIM
        end
        if (IsControlJustPressed(0, 26)) then
            gunHash = gun
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function() -- Handles all of the entity movements
    while true do
        _, gun = GetCurrentPedWeapon(PlayerPedId()) -- Update current gun
        Citizen.Wait(100)
    end
end)


