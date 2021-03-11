--Events
AddEventHandler("entityCreating", function(ent)
    if GetEntityType(ent) == 1 then
        CancelEvent()
    end
end)