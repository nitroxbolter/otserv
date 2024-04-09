function onEquip(player, item, slot, isCheck)
    if isCheck then
        return true
    end
    player:setStorageValue(Ships.Shadowmeld, 1)
    return true
end

function onDeEquip(player, item, slot)
    player:setStorageValue(Ships.Shadowmeld, 0)
    return true
end