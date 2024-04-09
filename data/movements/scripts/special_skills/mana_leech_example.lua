function onEquip(player, item, slot, isCheck)
    if isCheck then
        return true
    end

    player:addSpecialSkill(SPECIALSKILL_MANALEECHCHANCE, 2)
    player:addSpecialSkill(SPECIALSKILL_MANALEECHAMOUNT, 1)
    return true
end

function onDeEquip(player, item, slot)
    player:addSpecialSkill(SPECIALSKILL_MANALEECHCHANCE, -2)
    player:addSpecialSkill(SPECIALSKILL_MANALEECHAMOUNT, -1)
return true
end


--- How To Register: 
--- On movements.xml add script="special_skills/name of file you created with custom value",  onEquip, and also add the script on deEquip.
--- Reset Server and voila. 