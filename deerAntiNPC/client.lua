-- Slow Thread eh
Citizen.CreateThread(function()
    while true do
        for ped in EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                SetEntityAsMissionEntity( ped, true, true )
                DeletePed( ped )
            end
            Citizen.Wait(500)
        end
        Citizen.Wait(5000)
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
