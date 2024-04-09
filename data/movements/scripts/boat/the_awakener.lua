function onEquip(player, item, slot, isCheck)
    if isCheck then
        return true
    end
    player:setStorageValue(Ships.TheAwakener, 1)
    return true
end

function onDeEquip(player, item, slot)
    player:setStorageValue(Ships.TheAwakener, 0)
    return true
end