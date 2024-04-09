function onEquip(player, item, slot, isCheck)
    if isCheck then
        return true
    end
    player:setStorageValue(Ships.MenethilMarch, 1)
    return true
end

function onDeEquip(player, item, slot)
    player:setStorageValue(Ships.MenethilMarch, 0)
    return true
end