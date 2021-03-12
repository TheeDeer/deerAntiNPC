local whitelistHP = 108  -- THE HP OF PEDS THAT U WANT TO KEEP / USE THIS TO NOT DELETE PEDS THAT ARE SERVER-SPAWNED.

--If you are planning on whitelisting peds you will have to ensure the script that spawns them sets their hp to the above number. 
-- I recomend not using 108 as the whitelisted hp, as modders may see you using this script and use 108 on spawned peds.

-- MAKE SURE TO CHANGE THIS IN CLIENT.LUA AS WELL
--Events
AddEventHandler("entityCreating", function(ent)
    Citizen.Wait(100)
    if GetEntityType(ent) == 1 and GetEntityHealth(ent) ~= whitelistHP then
        CancelEvent()
    end
end)
