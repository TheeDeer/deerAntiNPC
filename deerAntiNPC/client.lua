local whitelistHP = 108  -- THE HP OF PEDS THAT U WANT TO KEEP / USE THIS TO NOT DELETE PEDS THAT ARE SERVER-SPAWNED.

--If you are planning on whitelisting peds you will have to ensure the script that spawns them sets their hp to the above number. 
-- I recomend not using 108 as the whitelisted hp, as modders may see you using this script and use 108 on spawned peds.

-- MAKE SURE TO CHANGE THIS IN server.LUA AS WELL

-- Slow Thread eh
Citizen.CreateThread(function()
    while true do
        for ped in EnumeratePeds() do
            if not IsPedAPlayer(ped) and GetEntityHealth(ped) ~= whitelistHP then
                TriggerServerEvent('deerAntiNPC:crackPed', ped)
            end
            Citizen.Wait(10)
        end
        Citizen.Wait(1000)
    end
end)

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
        disposeFunc(iter)
        return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end