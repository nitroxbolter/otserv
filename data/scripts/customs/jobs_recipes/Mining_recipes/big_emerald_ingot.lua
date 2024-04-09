
local ingot = Action()

 
function ingot.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Mining.BigEmeraldIngot) == 1 then
		player:say("You have already learned the recipe of big emerald ingot.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Mining.BigEmeraldIngot, 1)
	item:remove(1)
end
end
ingot:id(26583)
ingot:register()