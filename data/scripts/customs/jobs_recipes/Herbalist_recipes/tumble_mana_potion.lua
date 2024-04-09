
local potion = Action()

 
function potion.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Herbalist.TumbleManaPotion) == 1 then
		player:say("You have already learned the recipe of tumble mana potion.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Herbalist.TumbleManaPotion, 1)
	item:remove(1)
end
end
potion:id(26752)
potion:register()